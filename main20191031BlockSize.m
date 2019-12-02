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
blockchain = [];
TxPool = [];

%Parameters
PrTx = 1e-2; %probability of creating a transaction
PrTxValid = 0.8; %probability transaction is valid
DifficultyFixed = 1369148003869.4;%1369148003869.4; %www.blockchain.com
hashPerSecFixed = 91e18; %www.blockchain.com
BlockSize = 2^10;
%create users
users_num = 1e2;

%create miners
miners_num = 1;


%Parameter Analysis %%%[ hashPerSec ]%%%
for factor = 1:5
    for percentage = 1:10
        disp(['Percentage = ' num2str(percentage*10) '%' ])
        Difficulty = DifficultyFixed;%*(factor/10);%*(percentage/10);
        hashPerSec = hashPerSecFixed*(percentage/10);
        %simulation timeline     step:1 second
        duration = 1e5;
        waitToMine = inf;
        for time=1:duration
            for user = 1:users_num
                Tx = createTx(PrTx, PrTxValid);
                if ~islogical(Tx)
                    TxPool = [TxPool; 0, Tx];
                end
                
            end
            for miners = 1:miners_num
                if waitToMine<1
                    waitToMine = inf;
                    min_quantity = min(size(TxPool,1),BlockSize/(2^factor));
                    blockchain = [blockchain; TxPool(TxPool(1:min_quantity,3)>0,1:2)];
                    TxPool(TxPool(1:min_quantity,3)>0,:) = [];
                end
                
                if isinf(waitToMine)
                    waitToMine = mineBlock(Difficulty,hashPerSec);
                else
                    waitToMine = waitToMine - 1;
                end
            end
            
            TxPool(:,1) = TxPool(:,1)+1;
            
        end
        
        %perfromance analysis
        transactionLatency(factor, percentage) = sum(blockchain(:,1))/size(blockchain,1);
    end
end

shape = {'-ro', '', '-k*', '', '-g^', '', '-bd', '','-ys', ''};
legendx = [];
for factor = 1:2:10
    plot(round(0.1*(1:10)*hashPerSec),transactionLatency(factor, :),shape(factor))
    hold on
end

legend(legendx)
xlabel('Hash Operation Per Second')
ylabel('Average Transaction Latency')