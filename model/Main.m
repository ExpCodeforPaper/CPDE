clear
clc;

load ('load_180203');
train_size = 150;
%train_size_RR = train_size_KM;
%train_size_KM
numClas_k = 50;
numClas_dl = 50;
index_berthCount = find (Section_berthCount >= 20);

AvgParkingTime = [AvgDur_workday, AvgDur_holiday];
std_t = [stdDur_workday, stdDur_holiday];
std_dl = [stdOrd_workday, stdOrd_holiday];
OrderCount = [OrderCount_workday, OrderCount_holiday];
TaxiPOI = Taxi_POI_Dist_Norm; %Taxi_POI_Dist; %Dist_Inver_sum; 

AvgParkingTime_geq = AvgParkingTime (index_berthCount,:);
Dist_Inver_sum_geq = Dist_Inver_sum (index_berthCount,:);
std_t_geq = std_t (index_berthCount,:);

OrderCount_geq = OrderCount (index_berthCount,:);
TaxiPOI_geq = TaxiPOI (index_berthCount,:);
std_dl_geq = std_dl (index_berthCount,:);

% % Preprocessing Avg, Dis and splitting into train&test set with different sizes
[Temple_index_use, index, Avg_train_k, Avg_test_k, Dis_train_k, Dis_test_k, std_train_k, std_test_k, ...
    OrderCount_train, OrderCount_test, TaxiPOI_train, TaxiPOI_test, std_train_dl, std_test_dl] = ...
    Prep_poi_dis_time (Dist_Inver_sum_geq, AvgParkingTime_geq, std_t_geq, OrderCount_geq, TaxiPOI_geq, train_size, std_dl_geq);


% % ***********************Parking Duration Estimation********************% %
% % % Training and testing by KLS
[clas_c_KLS, avg_clas_c_KLS] = Train_KLS (Dis_train_k, Avg_train_k, numClas_k);

[Estimator_KLS, nrmse_rmean_KLS, nrmse_tmean_KLS, L2_test_sum_KLS] = ...
    Test_KLS (clas_c_KLS', Dis_test_k', avg_clas_c_KLS', Avg_test_k, std_test_k);

% % Training and testing by RR
[multipler_RR] = Train_RR (Dis_train_k, Avg_train_k);

[Estimator_RR, L2_test_sum_l, nrmse_rmean_l, nrmse_tmean_l] = ...
   Test_RR (Dis_test_k, Avg_test_k, multipler_RR, std_test_k);

% % Training and testing by KM
[class_center_KM_X, class_center_KM_Y] = Train_KM (Dis_train_k, Avg_train_k, numClas_k);

[Estimator_KM, nrmse_rmean_KM, nrmse_tmean_KM, L2_test_sum_KM] = ...
     Test_KM (class_center_KM_X, class_center_KM_Y, Dis_test_k, Avg_test_k, std_test_k);

L2_duration = [L2_test_sum_KLS, L2_test_sum_KM, L2_test_sum_l]; 
nrmse_duration = [nrmse_tmean_KLS, nrmse_tmean_KM, nrmse_tmean_l];


% %***********************Parking Demand Estimation********************% %
% % % Training and testing by RR
 [multipler_DRR] = Train_RR (TaxiPOI_train, OrderCount_train);

 [Estimator_DRR, L2_test_sum_DRR,nrmse_rmean_DRR, nrmse_tmean_DRR] = ...
     Test_RR (TaxiPOI_test, OrderCount_test, multipler_DRR, std_test_dl); 
 
% % Training and testing by LFM 
 [multipler_DLFM] = Train_LFM (TaxiPOI_train, OrderCount_train);
 
 [Estimator_DLFM, L2_test_sum_DLFM, nrmse_rmean_DLFM, nrmse_tmean_DLFM] = ...
     Test_LFM (TaxiPOI_test, OrderCount_test, multipler_DLFM, std_test_dl); 

% [errorLFM] = Train_LFM_Kg (TaxiPOI_train, OrderCount_train);
 
% % % Training and testing by KLS 
 [clas_c_dl, avg_clas_c_dl] = Train_KLS (TaxiPOI_train, OrderCount_train, numClas_dl);

 [Estimator_DKLS, nrmse_rmean_DKLS, nrmse_tmean_DKLS, L2_test_sum_DKLS] = ...
    Test_KLS (clas_c_dl', TaxiPOI_test', avg_clas_c_dl', OrderCount_test, std_test_dl);

 
% % % Training and testing by KM
[class_center_KM_X_dl, class_center_KM_Y_dl] = Train_KM (TaxiPOI_train, OrderCount_train, numClas_dl);

[Estimator_DKM, nrmse_rmean_DKM, nrmse_tmean_DKM, L2_test_sum_DKM] = ...
     Test_KM (class_center_KM_X_dl, class_center_KM_Y_dl, TaxiPOI_test, OrderCount_test, std_test_dl);

L2_demand = [L2_test_sum_DKLS, L2_test_sum_DKM, L2_test_sum_DLFM, L2_test_sum_DRR]; 
nrmse_demand = [nrmse_tmean_DKLS, nrmse_tmean_DKM, nrmse_tmean_DLFM, nrmse_tmean_DRR];

% %***********************Parking Type Estimation********************% %
% % % Train and Test GMModel
load("Section_parkTime.mat");
[GMModel, results] = Train_GMModel (index_berthCount, Temple_index_use, train_size, index, Section_parkTime);

[res_avg, res_DKLS_KLS, res_DKLS_KM, res_DKLS_RR, ...
    res_DKM_KLS, res_DKM_KM, res_DKM_RR, ...
    res_DLFM_KLS, res_DLFM_KM, results_DLFM_RR, ...
    res_DRR_KLS, res_DRR_KM, res_DRR_RR, ...
    L2_test_sum_DKLS_KLS, L2_test_sum_DKLS_KM, L2_test_sum_DKLS_RR, ...
    L2_test_sum_DKM_KLS, L2_test_sum_DKM_KM, L2_test_sum_DKM_RR, ...
    L2_test_sum_DLFM_KLS, L2_test_sum_DLFM_KM, L2_test_sum_DLFM_RR, ...
    L2_test_sum_DRR_KLS, L2_test_sum_DRR_KM, L2_test_sum_DRR_RR] = Test_Type ... 
(GMModel, OrderCount_test, Avg_test_k, Estimator_DKLS, Estimator_DKM, Estimator_DLFM, ...
Estimator_DRR, Estimator_KLS, Estimator_KM, Estimator_RR);

L2_durdem_type = [L2_test_sum_DKLS_KLS, L2_test_sum_DKLS_KM, L2_test_sum_DKLS_RR, ...
    L2_test_sum_DKM_KLS, L2_test_sum_DKM_KM, L2_test_sum_DKM_RR, ...
    L2_test_sum_DLFM_KLS, L2_test_sum_DLFM_KM, L2_test_sum_DLFM_RR, ...
    L2_test_sum_DRR_KLS, L2_test_sum_DRR_KM, L2_test_sum_DRR_RR];
