function trees = training_decision_tree(x,y,num,correlation_features)

trees = cell(1,num);
    for i = 1 : num
       y_emotion = double(y == i);
       trees{i}  = decision_tree_learning(x,y_emotion,correlation_features{i}); 
    end
end


%%
function tree = decision_tree_learning(x,y_emotion,features)
    % tree structure [op(node) kids(children nodes) class]
    tree = struct;
    
    if ~range(y_emotion)
        tree.class = y_emotion(1);
        tree.kids = [];
        tree.op = [];
    else
        [best_feature,best_threshold] = select_attribute(x,y_emotion,features);
          
        % split the data into two sub-data by threshold
        ltree_idx = find(x(:,best_feature) <= best_threshold);
        rtree_idx = find(x(:,best_feature) > best_threshold);
        
        if length(ltree_idx) * length(rtree_idx) == 0
            tree.class = majorityValue(y_emotion);   
            tree.op = [];
            tree.kids = [];
        else   
            tree.op = best_feature;             
            tree.th = best_threshold; 
            ltree = subtree(ltree_idx,x,y_emotion,features);
            rtree = subtree(rtree_idx,x,y_emotion,features);       
            tree.kids = {ltree,rtree}; 
        end   
    end
end



%% function
function newtree = subtree(idx,x, y_emotion,features)
    subtree_x = x(idx,:);
    subtree_y = y_emotion(idx,:);
    newtree = decision_tree_learning(subtree_x,subtree_y,features);
end


%% return the Majority value of data
function Value = majorityValue( values )
    Value = mode(values);   
end