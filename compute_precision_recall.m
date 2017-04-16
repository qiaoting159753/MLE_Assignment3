function [pre,re] = compute_precision_recall(M)

  pre = diag(M) ./ sum(M,2);
  re = diag(M) ./ sum(M,1)';

end



