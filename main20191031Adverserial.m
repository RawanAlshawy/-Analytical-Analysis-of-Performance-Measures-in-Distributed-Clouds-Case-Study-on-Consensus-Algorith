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

%Parameters
lambda = 5e-2; %Poission distribution probability

%create users
users_num = 1e4;
%total number of coins
coins_num = 1e7;
%distribution of coins
quantityCoins = rand(1,users_num);
fractionCoins = quantityCoins/sum(quantityCoins);
usersCoins = 0.99*fractionCoins*coins_num;
usersCoins(1) = usersCoins(1)+ 0.01*coins_num;

%identify stake holders
[~,I] = sort(usersCoins,'descend');
stakeUsers = usersCoins(I(1:10));
stakeCoins = 0.3*stakeUsers;
%trueStakeHolder stakeUsers(1) will commit 30% of coins owned


for factor = 1:10
    factor
    lambda = factor*1e-2; %Poission distribution probability
    for trial = 1:1e3
%         trial
        %adding adverserial agent will commit 100%of coins owned
        stakeUsers(11) = 0.1*stakeUsers(1);
        stakeCoins(11) = stakeUsers(11);
        
        %compute probability of winning block
        probWinning = stakeCoins/sum(stakeCoins);
        blockPropagate = 0;
        for blockIndex = 1:1e4
            %conflecting blocks
            if ~blockPropagate
                numBlocks(blockIndex) = poissrnd(lambda)+1;
            else
                numBlocks(blockIndex) = numBlocks(blockIndex-1);
            end
            winners = zeros(1,11);
            
            if numBlocks(blockIndex)>1
                while sum(winners)<=0
                    winners = rand(1,11) - probWinning < 0;
                    if sum(winners) >1
                        winners = 0;
                    end
                end
                
                %     winners
                
                if winners(11)
                    blockPropagate = 1;
                    blockchain(blockIndex) = numBlocks(blockIndex);
                else
                    blockPropagate = 0;
                    blockchain(blockIndex) = 1;
                end
            else
                blockchain(blockIndex) = 1;
            end
        end
        numTrial(trial) = sum(blockchain>1);
    end
    numConflictingBlocksAttacks(factor) = mean(numTrial);
end
numConflictingBlocksAttacks