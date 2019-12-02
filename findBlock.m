function newBlock = findBlock(index, timestamp, oldData, ...
    prev_hash, difficulty, CoinBase_amount, wallet)

% coinbase transaction
address = cell(1,1);
address{1} = [num2str(wallet(1)) num2str(wallet(2))];
TxAmount = cell(1,1);
TxAmount{1} = CoinBase_amount;
coinBaseTx = createTransaction(cell(1,1), 0, timestamp, address, wallet, TxAmount);

% append transaction to data
data = appendTx(coinBaseTx, oldData);
nonce = 0;
xx = serializeCell(data);

while 1
    hash = DataHash([num2str(index) ...
        xx num2str(timestamp) num2str(prev_hash) num2str(nonce)], 'SHA-256');
    
    if hashMatchesDifficulty(hash,difficulty)
        break
    end
    nonce = nonce + 1;
    
end

newBlock{1,1} = index;
newBlock{1,2} = timestamp;
newBlock{1,3} = data;
newBlock{1,4} = prev_hash;
newBlock{1,5} = hash;
newBlock{1,6} = nonce;
newBlock{1,7} = difficulty;

disp('block is mined!!')
end