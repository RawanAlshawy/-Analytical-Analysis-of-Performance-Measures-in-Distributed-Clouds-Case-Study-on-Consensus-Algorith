function newPool= SendTransaction(blockchain, walletSx, walletRx, amount, TxPool)

addressSx = [num2str(walletSx(1)) num2str(walletSx(2))];
addressRx = [num2str(walletRx(1)) num2str(walletRx(2))];

% extract unspent transactions 
lastBlock = blockchain{end};
data = lastBlock{3};
unspentTxIdArray = cell(1,1);
unspentTxAmountArray = cell(1,1);

idx = 1;
for i=1:length(data)-1
    unspentTx = data{i};
    if unspentTx{5}{1} == addressSx
        unspentTxIdArray{idx} = unspentTx{1};
        unspentTxAmountArray{idx} = unspentTx{6}{1};
        idx = idx + 1;
    end
end

% select unspent transactions to consume
unspentAmount = 0;
idx = 1;
while unspentAmount <= amount
    unspentAmount = unspentAmount + unspentTxAmountArray{idx};
    idx = idx + 1;
end
idxLast = idx - 1;
selectedUnspentTxIdArray = unspentTxIdArray{1:idxLast};
selectedUnspentTxAmountArray = unspentTxAmountArray{1:idxLast};


% create transactions
txOutId = cell(1,1);
for i=1:idxLast
    selectedUnspentTxIdArray
    txOutId{i} = selectedUnspentTxIdArray{i};
end
txOutIndex = 0;
address = cell(1,1);
TxAmount = cell(1,1);
address{1} = addressRx;
TxAmount{1} = amount;
if unspentAmount>amount
    address{2} = addressSx;
    TxAmount{2} = unspentAmount-amount;
end
Tx = createTransaction(txOutId, txOutIndex, address, wallet, TxAmount);

% add transaction to TxPool
newPool = addToTxPool(transaction, TxPool);
end