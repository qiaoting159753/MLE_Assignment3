function [ confusion_matrix,f1, precision, recall ] = cf_matrix( y_predicate, y_target )

%% confusion matrix
confusion_matrix = confusionmat(y_target,y_predicate);

%% precision and recall
[precisions,recalls] = compute_precision_recall(confusion_matrix);

precision = nanmean(precisions);
recall = nanmean(recalls);

%% F-measure
f1 = f_measure(precision,recall);

end

