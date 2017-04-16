
function [ best_indexs ] = correlation_features(X,Y,emotion_num)

best_indexs = cell(1,emotion_num);
for i = 1 : emotion_num
    best_indexs{i} = CFS(X,Y == i);
end
end


function [ S_k ] = CFS(X, Y)

feature_num = size(X,2);

feature_target = zeros(feature_num);
for i = 1 : feature_num
    feature_target(i) = pearson_correlation(X(:,i),Y);
end
feature_target = abs(feature_target);
    
feature_feature = zeros(feature_num, feature_num);
for i = 1 : feature_num
    for j = 1 : feature_num
        feature_feature(i,j) = pearson_correlation(X(:,i),X(:,j));
    end
end
feature_feature = abs(feature_feature);

S_k = [];
best_values = [];
X_remain = 1:feature_num;
for k = 1 : feature_num
    [best_value, best_idx] = CFS_value(S_k, X_remain, feature_feature, feature_target);
    S_k = [S_k, best_idx];
    best_values = [best_values, best_value];
    X_remain = X_remain(X_remain ~= best_idx);
end

[~, i] = max(best_values);
S_k = S_k(1:i);


end

function [max_value, max_index] = CFS_value(S_k, X_remain, feature_feature, feature_target)
    scores = zeros(2,length(X_remain));
    for i = 1 : length(X_remain)
        scores(1,i) = sum(feature_target([S_k,X_remain(i)])) / sqrt((length(S_k) + 1) + 2 * sum(feature_feature(X_remain(i), S_k)));
        scores(2,i) = X_remain(i);
    end
    [max_value, idx] = max(scores(1,:));
    max_index = scores(2,idx);
end



function [ coefficient ] = pearson_correlation(X,Y)

X_mean = mean(X); 
Y_mean = mean(Y);
coefficient = sum((X - X_mean).*(Y-Y_mean)) / (sqrt(sum((X - X_mean).^2)) * sqrt(sum((Y - Y_mean).^2)));

end

