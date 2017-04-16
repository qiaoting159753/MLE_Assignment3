% x - training example
% y - target examples
function [best_feature,best_threshold] = select_attribute(x,y_emotion,features)
    
    best_feature = 0;  
    max_inf_gain = 0;
    best_threshold = 0; 
    feature_best_threshold= [];
    
    x = x(:,features);
    [row,col] = size(x);
    
   
    %calculate the original entropy
    original_entropy = entropy(y_emotion);
    
     % iterate over all features (columns)
    for i = 1 : col      
        % need to change
        pos_thresholds = unique(x(:,i));
        % select the threshold every 10 value
        % data = pos_thresholds(1:10:end,:);
        
        for j = 1 : length(pos_thresholds) - 1
            
            left_index = find(x(:,i) <= pos_thresholds(j));
            right_index = find(x(:,i) > pos_thresholds(j));
        
            left_entropy = entropy(y_emotion(left_index));
            right_entropy = entropy(y_emotion(right_index));
            
            inf_gain = original_entropy - (left_entropy * (length(left_index)/length(x)) + right_entropy * (length(right_index)/length(x)));
            
            if inf_gain > max_inf_gain
               best_threshold = pos_thresholds(j); 
               max_inf_gain = inf_gain;
            end
        end     
    feature_best_threshold = [feature_best_threshold;i,best_threshold,max_inf_gain];
    max_inf_gain = 0;
    end 
    
    [~,best_index]= max(feature_best_threshold(:,3));
    
    best_feature = features(feature_best_threshold(best_index,1));
    best_threshold = feature_best_threshold(best_index,2);
end


