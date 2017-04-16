function y = f_measure(precision, recall)

    y = 2 * precision * recall / (precision + recall);

end