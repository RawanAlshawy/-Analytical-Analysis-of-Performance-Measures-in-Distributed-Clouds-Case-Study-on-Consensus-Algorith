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
% the blockchain will be simulated using ana array with seven
% columns: index, timestamp, data, previous hash, hash, nonce,
% difficulty
blockchain = zeros(1,1);
TxPool = [];

%Parameters
PrTx = 1e-2; %probability of creating a transaction
PrTxValid = 0.8; %probability transaction is valid
DifficultyFixed = 1369148003869.4;%1369148003869.4; %www.blockchain.com
hashPerSecFixed = 91e18; %www.blockchain.com

%create users
users_num = 1e2;

%create miners
miners_num = 1;


%Parameter Analysis %%%[ hashPerSec ]%%%
for factor = 1:2:10
    for percentage = 1:10
        disp(['Percentage = ' num2str(percentage*10) '%' ])
        Difficulty = DifficultyFixed*(factor/10);%*(percentage/10);
        hashPerSec = hashPerSecFixed*(percentage/10);
        %simulation timeline     step:1 second
        duration = 1e5;
        waitToMine = inf;
        for time=1:duration
            for user = 1:users_num
                Tx = createTx(PrTx, PrTxValid);
                if ~islogical(Tx)
                    TxPool = [TxPool; Tx];
                end
                
            end
            for miners = 1:miners_num
                if waitToMine<1
                    waitToMine = inf;
                    blockchain = [blockchain; TxPool(TxPool(:,2)>0,1)];
                    TxPool(TxPool(:,2)>0,:) = [];
                end
                
                if isinf(waitToMine)
                    waitToMine = mineBlock(Difficulty,hashPerSec);
                else
                    waitToMine = waitToMine - 1;
                end
            end
            
        end
        
        %perfromance analysis
        networkCapacity(factor, percentage) = size(blockchain,1)/duration;
    end
end
shape = ['ro-', '', 'k*-', '', 'g^-', '', 'bd-', '','ys-', ''];
legendx = [];
for factor = 1:2:10
    plot(round(0.1*(1:10)*hashPerSec),networkCapacity(factor, :),shape(factor))
%     legendx = [legendx;'d=' num2str(DifficultyFixed*(factor/10),13)];
    hold on
end

legend(legendx)
xlabel('hashPerSec')
ylabel('Transactions Per Second')