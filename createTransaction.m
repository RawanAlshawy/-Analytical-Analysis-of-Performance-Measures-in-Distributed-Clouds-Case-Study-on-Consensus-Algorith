function Tx = createTransaction(txOutId, txOutIndex, timestamp, address, wallet, amount)

addpath('.\RSA\');

%generate transaction id
TxId = generateTxId(txOutId, txOutIndex, timestamp, address, amount);

%create signature
signature = Sign(wallet(1), wallet(3), TxId);

Tx = {TxId, txOutId, txOutIndex, signature, address, amount};


end