function newPool = addToTxPool(transaction, TxPool)
newPool = cell(1,1);
newPool{1} = transaction;
for i=1:length(TxPool)
    newPool{i+1} = TxPool{i};
end
end


% for i=1:10
%     blockchain{i:end};
%    % unconfirmed trans list
%    %Tx1 send 5 coins to Node2
%   %  data=appendTx(coinBaseTx, oldData);
% end 
% end
