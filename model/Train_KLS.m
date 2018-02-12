% % KLS
function [class_center_dis,Avg_class_center_dis] = ...
    Train_KLS (Kmeans_Dis,Kmeans_Avg,numClass_dis)

%Kmeans_Dis = Distance_inverse_ratio_train_kmeans;
%Kmeans_Avg = AvgParkingTime_train_kmeans;
%numClass_dis = 100;

%k = numClass_dis;
% % ****************************function version**************************** % %

dif_numClass_to_c_mean_dis = zeros(numClass_dis, 1);

for k = 1:numClass_dis
[label_dis,class_center_dis,sum_dis_to_c_dis] = kmeans (Kmeans_Dis, k);
dif_numClass_to_c_mean_dis (k,1) = sum (sum_dis_to_c_dis, 1)/k;
end
Kmeans_Avg (:,size(Kmeans_Avg,2)+1) = label_dis;
Kmeans_Dis (:,size(Kmeans_Dis,2)+1) = label_dis;
sort_Kmeans_Avg_dis = sortrows (Kmeans_Avg,size(Kmeans_Avg,2));
  for j = 1:numClass_dis
     Avg_class_center_dis (j,:) = mean (Kmeans_Avg (find (Kmeans_Avg(:,size(Kmeans_Avg,2)) == j),1:(size(Kmeans_Avg,2)-1)), 1);
  end

end
