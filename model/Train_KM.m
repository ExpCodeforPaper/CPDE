function [class_center_X, class_center_Y] = ...
    Train_KM (Kmeans_X,Kmeans_Y,numClass)
dif_numClass_to_c_mean = zeros(numClass, 1);
for k = 1:numClass
[label,class_center_X,sum_dis_to_c] = kmeans (Kmeans_X, k);
dif_numClass_to_c_mean (k,1) = sum (sum_dis_to_c, 1)/k;
end
Kmeans_Y (:,size(Kmeans_Y,2)+1) = label;
sort_Kmeans = sortrows (Kmeans_Y,size(Kmeans_Y,2));
  for j = 1:numClass
     class_center_Y (j,:) = mean (Kmeans_Y (find (Kmeans_Y(:,size(Kmeans_Y,2)) == j),1:(size(Kmeans_Y,2)-1)), 1);
  end
  
find (Kmeans_Y(:,size(Kmeans_Y,2)) == 1);
end
