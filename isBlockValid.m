function valid = isBlockValid(oldBlock, newBlock)

%compare index
validIndex = oldBlock{1,1} < newBlock{1,1};

%compare hash
validHash = oldBlock{1,5} == newBlock{1,5};

%compare timestamp
validTimestamp = oldBlock{1,2} < newBlock{1,2};

%calculate hash for new block
index = newBlock{1,1};
timestamp = newBlock{1,2};
data = newBlock{1,3};
prev_hash = newBlock{1,4};
nonce = newBlock{1,6};

calculatedHash = DataHash([num2str(index) ...
    data num2str(timestamp) num2str(prev_hash) nonce], 'SHA-256');
validCalcHash = newBlock{1,5} == calculatedHash;

valid = validCalcHash&&validTimestamp&&validHash&&validIndex;
end