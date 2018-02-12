function [Estimator_kmeans, nrmse_rmean_kmeans, nrmse_tmean_kmeans, L2_test_sum_kmeans] = ...
     Test_KM (class_center_X, class_center_Y, X_test, Y_test, std)
 for i = 1:1:size (X_test,1)
     for j = 1:1:size (class_center_X)
     Euclidean (j) = sqrt(sum((X_test(i,:) - class_center_X (j,:)).^2));
     end
     [min_v, min_posi] = min (Euclidean);
     Estimator_kmeans (i,:) = class_center_Y (min_posi,:);
 end
 
  N_kmeans = size(Y_test, 2);
  
  for i=1:size(Y_test,1)
    L2_test_kmeans(i,:) = sqrt(sum((Estimator_kmeans(i,:) - Y_test(i,:)).^2)/N_kmeans);
    Diff_kmeans (i,:) = Estimator_kmeans(i,:) - Y_test(i,:);
    Diff_ratio_kmeans(i,:) = Diff_kmeans(i,:)./Y_test(i,:);
  end

  std_kmeans_tmp = std; 
  std_kmeans_tmp (std_kmeans_tmp == 0) = inf;
  
  nrmse_per_kmeans = abs(Diff_kmeans) ./ std_kmeans_tmp;
  for j = 1:size(nrmse_per_kmeans)
    nrmse_per_kmeans (j, find (isinf (nrmse_per_kmeans (j,:)) == 1)) = 0;
  end
  
  nrmse_rmean_kmeans = sum (nrmse_per_kmeans, 2)/size(Y_test,2);
  nrmse_tmean_kmeans = sum (nrmse_per_kmeans(:))/numel(Y_test); % 
  L2_test_sum_kmeans = sum (L2_test_kmeans)/size(Y_test,1); % 
end