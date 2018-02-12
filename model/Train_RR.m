
function [Beta] = ...
    Train_RR(X,Y)

%X = TaxiPOI_train;
%Y = OrderCount_train;

% % ****************************function version**************************** % %

[rX, cX] = size (X);
[rY, cY] = size (Y);
  Beta = zeros (cX, cY);
  L2_norm = zeros (1, cY);
  Res = zeros (rX, cY);
  Converge = zeros (1, cY);


k = 8e-6;
for i=1:cY
%[Beta,fitInfo] = lasso(X, Y (:,i));,'Lambda',0.41
Beta (:,i) = ridge(Y (:,i), X, k);
end

Beta (find (Beta < 0)) = 0;

end
