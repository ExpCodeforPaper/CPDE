
function [Estimator_dlR, L2_test_sum_dlR, nrmse_rmean_dlR, nrmse_tmean_dlR] = ...
    Test_RR(X_dl_test,Y_dl_test, para_dl, std_time_test_Dridge)

%X_dl_test = TaxiPOI_test;
%Y_dl_test = OrderCount_test;
%para_dl = Beta_dl;

% % ****************************function version**************************** % %

N_dlR = size(Y_dl_test, 2);

Estimator_dlR = X_dl_test * para_dl;
  
   for i=1:size(Y_dl_test,1)
     L2_test_dlR(i,:) = sqrt(sum((Estimator_dlR(i,:) - Y_dl_test(i,:)).^2)/N_dlR);
    Diff_dlR (i,:) = Estimator_dlR(i,:) - Y_dl_test(i,:);
    Diff_ratio_dlR(i,:) = Diff_dlR(i,:)./Y_dl_test(i,:);
   end

  std_dlr_tmp = std_time_test_Dridge; 
  std_dlr_tmp (std_dlr_tmp == 0) = inf;
   
  nrmse_per_dlR = abs(Diff_dlR) ./ std_dlr_tmp;
  for j = 1:size(nrmse_per_dlR)
    nrmse_per_dlR (j, find (isinf (nrmse_per_dlR (j,:)) == 1)) = 0;
  end
  
  nrmse_rmean_dlR = sum (nrmse_per_dlR, 2)/size(Y_dl_test,2);
  nrmse_tmean_dlR = sum (nrmse_per_dlR(:))/numel(Y_dl_test); % 
  L2_test_sum_dlR = sum (L2_test_dlR)/size(Y_dl_test,1); % 
end