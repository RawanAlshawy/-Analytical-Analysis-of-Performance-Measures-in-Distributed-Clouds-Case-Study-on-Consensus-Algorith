%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is a simulation of permissionless blockchain
% with the aim to evaluate the performance of consenses
% algorithms (proof of work, proof of stake, proof of
% activity)
% Rawan Alshawy
% Master's Student - King Saud University, 2019
% Advisor: Dr. Ahmed Alsanad
% contact email: rawanalshawy@yahoo.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all
w = warning ('off','all');
% the blockchain will be simulated using ana array with four
% columns: index, timestamp, data, previous hash, hash, nonce,
% difficulty
blockchain = cell(1,1);
TxPool = cell(1,1);

% genesis blockchain
genBlock = generateGenesisBlock();
blockchain{1} = genBlock;
% in seconds
BLOCK_GENERATION_INTERVAL = 10;
% in blocks
DIFFICULTY_ADJUSTMENT_INTERVAL = 10;
%Coinbase
COINBASE_AMOUNT = 15;
%number of nodes
num_nodes = 10;
%classify node type
% 0: non-active (not miners)
% 1: active (miners)
nodeType = zeros(1,num_nodes);
nodeType(1) = 1;
%create wallet for nodes
walletsArray = zeros(num_nodes,3);
for node=1:num_nodes
    walletsArray(node,:) = createWallet();
end
balance = zeros(num_nodes,2);

% blochchain creator mines coins
for i=1:100 %axis unit time
    for node=1:num_nodes
        % check node type
        if nodeType(node) == 1 %if the node is miner
            newBlock = minersCode(blockchain,COINBASE_AMOUNT,...
                walletsArray(node,:));
            %append to blockchain
            blockchain{end+1} = newBlock;
        end
    end
    % check balance
    balance = printBalance(blockchain);
end

% blockchain public coin offering
% node = 1 is blockchain creator, owns all initial coins mined
totalSold = 0;
for node=2:num_nodes
    if(rand>0.1)
        transAmount = min(max(rand*500,50),500);
        if (totalSold+transAmount)> balance(1,2)
            break %all coins mined have been sold
        end
        TxPool = SendTransaction(blockchain, walletsArray(1,:), ...
            walletsArray(node,:), transAmount, TxPool);
        totalSold = totalSold + transAmount;
    end
end


% blockchain goes online
% for i=1:100 %axis unit time
%     for node=1:num_nodes
%         % check node type
%         if nodeType(node) == 1 %if the node is miner
%             if(rand>0.5&&balance(node)>0)
%                 % choose another node to send coins
%                 disp('error')
%             end
%             newBlock = minersCode(blockchain,COINBASE_AMOUNT,...
%                 walletsArray(node,:));
%             %append to blockchain
%             blockchain{end+1} = newBlock;
%         else %if the node is non-active
%             if(rand>0.5&&balance(node)>0)
%                 % choose another node to send coins
%                 disp('error')
%             end
%         end
%
%     end
%
%     % check balance
%     balance = printBalance(blockchain);
%
% end




% % create a block
% index = size(blockchain,1);
% timestamp = num2str(posixtime(datetime('now')) * 1e6);
% data = '?';
% prev_hash = blockchain(end,5);

% is block valide
% valid = isBlockValid(oldBlock, newBlock);

% Choosing the longest chain

% Communicating with other nodes


% hashing
% DataHash(blockchain{1,1:4},'SHA-256')

