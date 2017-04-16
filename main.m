% clear;
%% Load data
% load('emotions_data');

N = size(x, 1); % number of instances



%% Cross-Validation

 k = 10;
 emotion_num = 6;
 rand_idxs = randperm(N);
 cv_folds = crossvalind('Kfold', rand_idxs, k);   
 

 confusion_matrixs = []; 
 f1s = []; 
 precisions = []; 
 recalls = [];
  
 for i = 1:k
  
      test_idxs = (cv_folds == i);
      train_idxs = ~test_idxs;
      % test data
      test_x = x(test_idxs,:);
      test_y = y(test_idxs,:);
      % training data
      train_x = x(train_idxs,:);
      train_y = y(train_idxs,:);
      
      
      trees = training_decision_tree(train_x,train_y,emotion_num);
      predict_result = tree_predict(trees,test_x);
      
      [confusion_matrix, f1, precision, recall] = cf_matrix(predict_result, test_y);
      confusion_matrixs = confusion_matrixs + confusion_matrix;
      f1s = [f1s;f1];
      precisions = [precisions;precision];
      recalls = [recalls;recall];
      
 end
  
 average_f1 = mean(f1s); 
 average_precison = mean(precisions);
 average_recall = mean(recalls);
 

%% final training with all data
trees = training_decision_tree(x,y,emotion_num,correlation_features);

for i = 1:emotion_num
   graph_name = strcat('Decision Tree:',{' '},emolab2str(i));
   DrawDecisionTree(trees{i},graph_name);
end


save mytree trees;