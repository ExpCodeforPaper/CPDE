
function [Filter_use, index_kmeans, AvgParkingTime_train_kmeans, AvgParkingTime_test_kmeans, Distance_inverse_ratio_train_kmeans, ...
    Distance_inverse_ratio_test_kmeans, std_time_train_kmeans, std_time_test_kmeans, ...
    OrderCount_train, OrderCount_test, TaxiPOI_train, TaxiPOI_test, std_demand_train, std_demand_test] = ...
    Prep_poi_dis_time (DisDataset_tmp, AvgDataset_tmp, std_time, OrderCount_tmp, TaxiPOI_tmp, train_size, std_demand)


% AvgParkingTime = [AvgParkingTime_workday, AvgParkingTime_holiday];
% std_time = [std_workday, std_holiday];
% DisDataset_tmp = Dis_inver_sum;
% AvgDataset_tmp = AvgParkingTime; %/60;

% DisDataset_tmp=Dist_Inver_sum;
% AvgDataset_tmp=AvgParkingTime; 
% std_time=std_t; 

% %function版本
train_size_kmeans = train_size;
train_size_ls = train_size;
train_size_demand = train_size;
[FilterR_Avg, FilterC_Avg, v_Avg] = find (AvgDataset_tmp);
[FilterR_Dis, FilterC_Dis, v_Dis] = find (DisDataset_tmp);

% Row process
% on AvgDataset_tmp
HistR_init_Avg = tabulate (FilterR_Avg); 
HistR_Avg = HistR_init_Avg;
IdR_les20_Avg = HistR_Avg (:, 2)<20;
sumR_les20_Avg = sum (IdR_les20_Avg);
HistR_Avg (IdR_les20_Avg,:) = []; 

% on Distance_inverse_ratio
HistR_init_Dis = tabulate (FilterR_Dis); 
HistR_Dis = HistR_init_Dis;
IdR_eq0_Dis = HistR_Dis (:, 2)==0;
sumR_eq0_Dis = sum (IdR_eq0_Dis);
HistR_Dis (IdR_eq0_Dis,:) = [];

% Column process
%on Distance_inverse_ratio
HistC_init_Dis = tabulate (FilterC_Dis); 
HistC_Dis = HistC_init_Dis;
IdC_eq0_Dis = HistC_Dis (:, 2)==0;
sumC_eq0_Dis = sum (IdC_eq0_Dis);
HistC_Dis (IdC_eq0_Dis,:) = [];

tmp1 = DisDataset_tmp (:,1:20);
tmp2 = DisDataset_tmp (:,22:23);
Distance_inverse_ratio_tmp = [tmp1,tmp2]; 

% std filtering NAN
for i = 1: size(std_time, 1)
   std_tmp (i,:) = isnan(std_time(i,:));
end
std_count_tmp = sum (std_tmp, 2);
std_use = find (std_count_tmp(:,1) == 0);

% Avg,Dis,std,#Order and Taxi_POI filtering
HistR_AD = intersect(HistR_Avg(:,1), HistR_Dis (:,1));
Filter_use = intersect (HistR_AD(:,1), std_use(:,1));

std_time_pre = std_time (Filter_use,:);
std_demand_pre = std_demand (Filter_use,:);

AvgParkingTime_pre = AvgDataset_tmp (Filter_use,:);
Distance_inverse_ratio_pre = Distance_inverse_ratio_tmp (Filter_use,:); 
OrderCount_pre = OrderCount_tmp (Filter_use,:);
TaxiPOI_pre = TaxiPOI_tmp (Filter_use,:);


% %***********************Random Training and Testing Set (Duration)**************************% %
index_kmeans = randperm (size(Filter_use,1));
%index = index_backup;
%t = train_size_kmeans 
% % std_duration_kmeans
std_time_train_kmeans = std_time_pre (index_kmeans(1:train_size_kmeans),:);
std_time_test_kmeans = std_time_pre (index_kmeans((train_size_kmeans+1):size(index_kmeans,2)),:);

% % Avg
AvgParkingTime_train_kmeans = AvgParkingTime_pre (index_kmeans(1:train_size_kmeans),:);
AvgParkingTime_test_kmeans = AvgParkingTime_pre (index_kmeans((train_size_kmeans+1):size(index_kmeans,2)),:);

% % Dis

% ＊Normalized
Distance_tmp_kmeans = Distance_inverse_ratio_pre;
norm_tmp_kmeans = sum (Distance_tmp_kmeans,2); 
norm_Distance_ls = bsxfun(@rdivide, Distance_tmp_kmeans, norm_tmp_kmeans);
Distance_inverse_ratio_train_kmeans = norm_Distance_ls (index_kmeans(1:train_size_kmeans),:);
Distance_inverse_ratio_test_kmeans = norm_Distance_ls (index_kmeans((train_size_kmeans+1):size(index_kmeans,2)),:);


% %***********************Random Training and Testing Set Demand**************************% %
index_demand = index_kmeans;

% % #order
OrderCount_train = OrderCount_pre (index_demand(1:train_size_demand),:);
OrderCount_test = OrderCount_pre (index_demand((train_size_demand+1):size(index_demand,2)),:);

% % Taxi_POI
TaxiPOI_train = TaxiPOI_pre (index_demand(1:train_size_demand),:);
TaxiPOI_test = TaxiPOI_pre (index_demand((train_size_demand+1):size(index_demand,2)),:);

% % std_dl
std_demand_train = std_demand_pre (index_demand(1:train_size_demand),:);
std_demand_test = std_demand_pre (index_demand((train_size_demand+1):size(index_demand,2)),:);

end