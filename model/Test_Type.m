
function [results_avg, results_DKLS_KLS, results_DKLS_KM, results_DKLS_RR, ...
    results_DKM_KLS, results_DKM_KM, results_DKM_RR, ...
    results_DLFM_KLS, results_DLFM_KM, results_DLFM_RR, ...
    results_DRR_KLS, results_DRR_KM, results_DRR_RR, ...
    L2_sum_DKLS_KLS, L2_sum_DKLS_KM, L2_sum_DKLS_RR, ...
    L2_sum_DKM_KLS, L2_sum_DKM_KM, L2_sum_DKM_RR, ...
    L2_sum_DLFM_KLS, L2_sum_DLFM_KM, L2_sum_DLFM_RR, ...
    L2_sum_DRR_KLS, L2_sum_DRR_KM, L2_sum_DRR_RR] = Test_Type ...
    (GMModel, OrderC_test, Dur_test_k, est_DKLS, est_DKM, est_DLFM, est_DRR, est_KLS, est_KM, est_RR)

    [results_avg] = Test_GMModel (GMModel, OrderC_test, Dur_test_k);
    
% % DKLS_KLS    
    [results_DKLS_KLS] = Test_GMModel (GMModel, est_DKLS, est_KLS);
    L2_tmp = results_DKLS_KLS - results_avg;
    for i = 1:size(L2_tmp,1)
        L2_DKLS_KLS (i,:) = sqrt(sum((results_DKLS_KLS(i,:)-results_avg(i,:)).^2)/size(L2_tmp,2));  
    end
    L2_sum_DKLS_KLS = sum (L2_DKLS_KLS)/size(L2_tmp,1);

% % DKLS_KM    
    [results_DKLS_KM] = Test_GMModel (GMModel, est_DKLS, est_KM);
    L2_tmp = results_DKLS_KM - results_avg;
    for i = 1:size(L2_tmp,1)
        L2_DKLS_KM (i,:) = sqrt(sum((results_DKLS_KM(i,:)-results_avg(i,:)).^2)/size(L2_tmp,2));  
    end
    L2_sum_DKLS_KM = sum (L2_DKLS_KM)/size(L2_tmp,1);

% % DKLS_RR
    [results_DKLS_RR] = Test_GMModel (GMModel, est_DKLS, est_RR);
    L2_tmp = results_DKLS_RR - results_avg;
    for i = 1:size(L2_tmp,1)
        L2_DKLS_RR (i,:) = sqrt(sum((results_DKLS_RR(i,:)-results_avg(i,:)).^2)/size(L2_tmp,2));  
    end
    L2_sum_DKLS_RR = sum (L2_DKLS_RR)/size(L2_tmp,1);
    
% % DKM_KLS   
    [results_DKM_KLS] = Test_GMModel (GMModel, est_DKM, est_KLS);
    L2_tmp = results_DKM_KLS - results_avg;
    for i = 1:size(L2_tmp,1)
        L2_DKM_KLS (i,:) = sqrt(sum((results_DKM_KLS(i,:)-results_avg(i,:)).^2)/size(L2_tmp,2));  
    end
    L2_sum_DKM_KLS = sum (L2_DKM_KLS)/size(L2_tmp,1);
    
% %DKM_KM    
    [results_DKM_KM] = Test_GMModel (GMModel, est_DKM, est_KM);
    L2_tmp = results_DKM_KM - results_avg;
    for i = 1:size(L2_tmp,1)
        L2_DKM_KM (i,:) = sqrt(sum((results_DKM_KM(i,:)-results_avg(i,:)).^2)/size(L2_tmp,2));  
    end
    L2_sum_DKM_KM = sum (L2_DKM_KM)/size(L2_tmp,1);
    
% %DKM_RR
    [results_DKM_RR] = Test_GMModel (GMModel, est_DKM, est_RR);
    L2_tmp = results_DKM_RR - results_avg;
    for i = 1:size(L2_tmp,1)
        L2_DKM_RR (i,:) = sqrt(sum((results_DKM_RR(i,:)-results_avg(i,:)).^2)/size(L2_tmp,2));  
    end
    L2_sum_DKM_RR = sum (L2_DKM_RR)/size(L2_tmp,1);
    
% %DLFM_KLS
    [results_DLFM_KLS] = Test_GMModel (GMModel, est_DLFM, est_KLS);
    L2_tmp = results_DLFM_KLS - results_avg;
    for i = 1:size(L2_tmp,1)
        L2_DLFM_KLS (i,:) = sqrt(sum((results_DLFM_KLS(i,:)-results_avg(i,:)).^2)/size(L2_tmp,2));  
    end
    L2_sum_DLFM_KLS = sum (L2_DLFM_KLS)/size(L2_tmp,1);

% %DLFM_KM
    [results_DLFM_KM] = Test_GMModel (GMModel, est_DLFM, est_KM);
    L2_tmp = results_DLFM_KM - results_avg;
    for i = 1:size(L2_tmp,1)
        L2_DLFM_KM (i,:) = sqrt(sum((results_DLFM_KM(i,:)-results_avg(i,:)).^2)/size(L2_tmp,2));  
    end
    L2_sum_DLFM_KM = sum (L2_DLFM_KM)/size(L2_tmp,1);
    
% %DLFM_RR    
    [results_DLFM_RR] = Test_GMModel (GMModel, est_DLFM, est_RR);
    L2_tmp = results_DLFM_RR - results_avg;
    for i = 1:size(L2_tmp,1)
        L2_DLFM_RR (i,:) = sqrt(sum((results_DLFM_RR(i,:)-results_avg(i,:)).^2)/size(L2_tmp,2));  
    end
    L2_sum_DLFM_RR = sum (L2_DLFM_RR)/size(L2_tmp,1);
    
% %DRR_KLS    
    [results_DRR_KLS] = Test_GMModel (GMModel, est_DRR, est_KLS);
    L2_tmp = results_DRR_KLS - results_avg;
    for i = 1:size(L2_tmp,1)
        L2_DRR_KLS (i,:) = sqrt(sum((results_DRR_KLS(i,:)-results_avg(i,:)).^2)/size(L2_tmp,2));  
    end
    L2_sum_DRR_KLS = sum (L2_DRR_KLS)/size(L2_tmp,1);
    
% %DRR_KM    
    [results_DRR_KM] = Test_GMModel (GMModel, est_DRR, est_KM);
    L2_tmp = results_DRR_KM - results_avg;
    for i = 1:size(L2_tmp,1)
        L2_DRR_KM (i,:) = sqrt(sum((results_DRR_KM(i,:)-results_avg(i,:)).^2)/size(L2_tmp,2));  
    end
    L2_sum_DRR_KM = sum (L2_DRR_KM)/size(L2_tmp,1);
    
% %DRR_RR
    [results_DRR_RR] = Test_GMModel (GMModel, est_DRR, est_RR);
    L2_tmp = results_DRR_RR - results_avg;
    for i = 1:size(L2_tmp,1)
        L2_DRR_RR (i,:) = sqrt(sum((results_DRR_RR(i,:)-results_avg(i,:)).^2)/size(L2_tmp,2));  
    end
    L2_sum_DRR_RR = sum (L2_DRR_RR)/size(L2_tmp,1);

end