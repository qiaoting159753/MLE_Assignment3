function target = tree_predict(trees,x)

tree_num = length(trees);
[row,~] = size(x);
target = zeros(row,1);

for i = 1 : row

    predicts = zeros(1,6);

    for j = 1:tree_num        
        predicts(j) = tree_test(trees{j},x(i,:));
    end    

    target_idxs = find(predicts);
    l = length(target_idxs);
    
    
    if l == 1
        target(i) = target_idxs;
    elseif l == 0
        target(i) = randi(tree_num);
    else
        % randomly handle the confusion
        target(i) = target_idxs(randi(l));
   
    end
end 
    
end


%% iteration for generating sample target
function result = tree_test(tree,x)

if isempty(tree.kids)
    result = tree.class;
else
    threshold = tree.th;
    feature = tree.op;
    
    if x(1,feature) <= threshold
        result = tree_test(tree.kids{1},x);
    else
        result = tree_test(tree.kids{2},x);
    end  
end

end