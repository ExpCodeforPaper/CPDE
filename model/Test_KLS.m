% % KLS
% clc;
function [Estimator_KLS, nrmse_rmean_KLS,nrmse_tmean_KLS,L2_test_sum_KLS] = ...
    Test_KLS (X_KLS,Y_KLS,Z_KLS,test_KLS, std_time_test_KLS)
%X_KLS = class_center_dis';
%Y_KLS = Distance_inverse_ratio_test_KLS'; 
%Z_KLS = Avg_class_center_dis';
%test_KLS = AvgParkingTime_test_KLS;

% % ****************************function version**************************** % %

N_KLS = size(test_KLS, 2);

[rX_KLS, cX_KLS] = size (X_KLS);
[rY_KLS, cY_KLS] = size (Y_KLS);
Beta_KLS = zeros (cX_KLS, cY_KLS);
L2_norm_KLS = zeros (1, cY_KLS);
Res_KLS = zeros (rX_KLS, cY_KLS);
Converge_KLS = zeros (1, cY_KLS);

  for i = 1:cY_KLS
    [x_KLS,resnorm_KLS,residual_KLS,exitflag_KLS] = lsqlin(X_KLS,Y_KLS(:,i),[],[],[],[],zeros(cX_KLS,1),[],zeros(cX_KLS,1));
    Beta_KLS(:,i) = x_KLS;
    L2_norm_KLS (1, i) = sqrt(resnorm_KLS);
    Res_KLS (:, i)  = residual_KLS;
    Converge_KLS (1, i) = exitflag_KLS;
  end

  Estimator_KLS = (Z_KLS * Beta_KLS)';
  for i = 1:size(test_KLS,1)
    L2_test_KLS (i,:) = sqrt(sum((Estimator_KLS(i,:) - test_KLS(i,:)).^2)/N_KLS);
    Diff_KLS (i,:) = Estimator_KLS(i,:) - test_KLS(i,:);
    Diff_ratio_KLS(i,:) = Diff_KLS(i,:)./test_KLS(i,:);
  end
  
  std_KLS_tmp = std_time_test_KLS;
  std_KLS_tmp (std_KLS_tmp == 0) = inf;
  
  nrmse_per_KLS = abs(Diff_KLS) ./ std_KLS_tmp;

  for j = 1:size(nrmse_per_KLS)
     nrmse_per_KLS (j, find (isinf (nrmse_per_KLS (j,:)) == 1)) = 0;
  end
  nrmse_rmean_KLS = sum (nrmse_per_KLS, 2)/size(test_KLS,2);
  nrmse_tmean_KLS = sum (nrmse_rmean_KLS(:))/size(test_KLS,1);% 
  L2_test_sum_KLS = sum (L2_test_KLS)/size(test_KLS,1); % 

end

