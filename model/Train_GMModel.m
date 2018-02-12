function [GMModel, results] = ...
    Train_GMModel (index_berthCount, Temple_index_use, train_size, index_kmeans, Section_parkTime)

% % filter 
Section_parkTime = Section_parkTime(index_berthCount,:);
Section_parkTime = Section_parkTime(Temple_index_use,:);

% % split to train and test by index_kmeans
Section_parkTime_train = Section_parkTime(index_kmeans(1:train_size),:);
Section_parkTime_test = Section_parkTime(index_kmeans(train_size+1:end),:);

% % convert Section_parkTime_train to Array and Train GMModel
Section_parkTime_train_array = Section_parkTime_train(:);
Section_parkTime_train_array = Section_parkTime_train_array(find(~ isnan(Section_parkTime_train_array)));

% % train GMModel

% % k components
k = 7;

options = statset('MaxIter',10000,'Display','final');
tic
GMModel = fitgmdist(Section_parkTime_train_array,k,'Options',options,'CovarianceType','diagonal');
toc

% % iterate parameters
mu = GMModel.mu;
sigma = reshape(GMModel.Sigma, [k,1]);
m = GMModel.ComponentProportion;
tol = 0.000001;
maxIter = 1000;

results = zeros(size(Section_parkTime_test, 1), k);
for row = 1:size(Section_parkTime_test,1)
    % % extract specific demand and time(minutes)
    minutes = Section_parkTime_test(row,:);
    minutes = minutes(find(~ isnan(minutes)));
    minutes = minutes';
    
    % % reassign m0 and iterate
    m0 = m;
    for iter = 1:maxIter    
        
        lh = normpdf(minutes, mu', sigma');

        lh = lh .* m0;
        lh = lh ./ sum(lh, 2);
                
        lh = sum(lh) / size(minutes, 1);

        error = sumsqr(lh - m0);
        m0 = lh;
        if error < tol
            break
        end
    end
    results(row,:) = m0;
end