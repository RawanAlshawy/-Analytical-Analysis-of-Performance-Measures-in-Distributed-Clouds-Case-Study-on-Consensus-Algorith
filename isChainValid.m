function valid = isChainValid(genesisBlock, blockchain)

% check genesis block validity
validGenesisBlock = blockchain{1,:} == genesisBlock;

% check blockchain integrity
validChain = true;
for i=1:size(blockchain,1)-1
    validBlock = isBlockValid(blockchain{i,:},blockchain{i+1,:});
    validChain = validChain&&validBlock;
end

valid = validGenesisBlock&&validChain;
end