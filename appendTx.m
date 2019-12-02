function data = appendTx(transaction, oldData)
data = cell(1,1);
data{1} = transaction;
for i=1:length(oldData)
    data{i+1} = oldData{i};
end
end