function [multipler_LMF] = ...
    Train_LFM (F_dl,A_dl)

% % ****************************function version**************************** % %
% 
iteration = 500;
[rA_dl, cA_dl] = size (A_dl);
[rF_dl, cF_dl] = size (F_dl);

% 
G = 12; 
[WA_dl, HA_dl, DA_dl] = nnmf (A_dl,G);
X = HA_dl;
Y = WA_dl;
[rY_dl, cY_dl] = size (Y);
Z = zeros (cF_dl, cY_dl);
iter = 1;  
k = 10e-2;
    while iter <= iteration

       for i=1:cY_dl
         Z (:,i) = ridge(Y (:,i), F_dl, k);
       end

       temp_1 = A_dl-Y*X;
       temp_2 = Y-F_dl*Z;
       step_Y = -(A_dl-Y*X)*X' + (Y-F_dl*Z);
       step_X = -Y'*(A_dl-Y*X) + X;

       Y = Y+(1e-7)*step_Y;
       X = X+(1e-7)*step_X;


       iter = iter+1;
    end

    multipler_LMF = Z*X;
    multipler_LMF (find (multipler_LMF < 0)) = 0;

end
