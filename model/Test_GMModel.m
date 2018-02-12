function [results] = ...
    Test_GMModel (GMModel, Estimator_D, Estimator_V)

% % iterate parameters
% % k components
k = 7;

mu = GMModel.mu;
sigma = reshape(GMModel.Sigma, [k,1]);
m = GMModel.ComponentProportion;
tol = 0.000001;
maxIter = 1000;

results = zeros(size(Estimator_D, 1), k);
for row = 1:size(Estimator_D,1)    
    % % extract specific demand and time(minutes)
    demand = Estimator_D(row,:);
    minutes = Estimator_V(row,:);
    minutes = minutes';
    
    % % reassign m0 and iterate
    m0 = m;
    for iter = 1:maxIter    
        
        lh = normpdf(minutes, mu', sigma');

        lh = lh .* m0;
        lh = lh ./ sum(lh, 2);
        
        lh = lh .* demand';
        
        lh = sum(lh) / sum(demand);

        error = sumsqr(lh - m0);
        m0 = lh;
        if error < tol
            break
        end
    end
    results(row,:) = m0;
end