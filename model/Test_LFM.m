function [Estimator_dlL, L2_test_sum_dlL, nrmse_rmean_dlL, nrmse_tmean_dlL] = ...
    Test_LFM (F_dl_test, A_dl_test, para_dlL, std_time_test_DLFM)

% % ****************************function version**************************** % %
Estimator_dlL = F_dl_test * para_dlL;
N_dlL = size(A_dl_test, 2);

  for i=1:size(A_dl_test,1)
     L2_test_dlL(i,:) = sqrt(sum((Estimator_dlL(i,:) - A_dl_test(i,:)).^2)/N_dlL);
     Diff_dlL (i,:) = Estimator_dlL(i,:) - A_dl_test(i,:);
     Diff_ratio_dlL(i,:) = Diff_dlL(i,:)./A_dl_test(i,:);
  end
  
  std_dll_tmp = std_time_test_DLFM; 
  std_dll_tmp (std_dll_tmp == 0) = inf;
  
    nrmse_per_dlL = abs(Diff_dlL) ./ std_dll_tmp;
  for j = 1:size(nrmse_per_dlL)
    nrmse_per_dlL (j, find (isinf (nrmse_per_dlL (j,:)) == 1)) = 0;
  end
  
  nrmse_rmean_dlL = sum (nrmse_per_dlL, 2)/size(A_dl_test,2);
  nrmse_tmean_dlL = sum (nrmse_per_dlL(:))/numel(A_dl_test);
   L2_test_sum_dlL = sum (L2_test_dlL)/size(A_dl_test,1);