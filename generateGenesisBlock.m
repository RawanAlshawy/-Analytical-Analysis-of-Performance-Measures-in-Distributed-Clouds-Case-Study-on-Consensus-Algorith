function genBlock = generateGenesisBlock()
genBlock = cell(1,7);
index = 0;
timestamp = num2str(posixtime(datetime('now')) * 1e6);
data = cell(1,1); data{1}='This is genesis block';
prev_hash = 0;
nonce = 0;%sprintf('%d',randi(9,1,256));
hash = DataHash([num2str(index) ...
    data num2str(timestamp) num2str(prev_hash) nonce], 'SHA-256');
difficulty = 5;

genBlock{1,1} = index;
genBlock{1,2} = timestamp;
genBlock{1,3} = data;
genBlock{1,4} = prev_hash;
genBlock{1,5} = hash;
genBlock{1,6} = nonce;
genBlock{1,7} = difficulty;
disp('Genesis Block Generated!!')
end