%% Calculates the entropy of a vector of values 
function result = entropy(X)

    fre_table = tabulate(X);
    prob = fre_table(:,3) / 100;
    prob = prob(prob~=0);
    result = -sum(prob .* log2(prob));
end  