function balanceArray = printBalance(blockchain)

lastBlock = blockchain{end};
data = lastBlock{3};
balanceArray = zeros(1,2);
idx = 1;
for i=1:length(data)-1
    address = data{i}{5};
    amount = data{i}{6};
    for j=1:length(address)
        balanceArray(idx,1) = str2num(address{j});
        balanceArray(idx,2) = amount{j};
        idx = idx + 1;
    end
end
sortedArray = sortrows(balanceArray,1);
addressArray = unique(sortedArray(:,1));  %get unique id for rows with identical column 1
for idx = 1:length(addressArray)
    address = addressArray(idx);
    balanceAmount = sum(sortedArray(find(sortedArray(:,1)==address),2));
    disp(['The balance of Address = ' num2str(address) ' is equal to ' ...
        num2str(balanceAmount) ' coins'])
    balanceArray(idx,1) = address;
    balanceArray(idx,2) = balanceAmount;
end

end