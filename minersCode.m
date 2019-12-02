function newBlock = minersCode(blockchain,COINBASE_AMOUNT,wallet)
%extract last block in the blockchain
lastBlock = blockchain{end};
index = lastBlock{1};
timestamp = num2str(posixtime(datetime('now')) * 1e6);
data = lastBlock{3};
prev_hash = lastBlock{5};
difficulty = lastBlock{7};

%execute mining process
newBlock = findBlock(index, timestamp, data, ...
    prev_hash, difficulty, COINBASE_AMOUNT, ...
    wallet);
end