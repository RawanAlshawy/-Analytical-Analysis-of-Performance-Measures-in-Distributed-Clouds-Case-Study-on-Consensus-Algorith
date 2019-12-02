% test script
clc
clear


a = cell(1,6);
b = cell(1,6);
c = cell(1,10);

a{1} = 'last';
a{3} = 0;
a{6} = 'block';

b{1} = 'dummy';
b{3} = 5;
b{6} = 'block';

for i=1:100
    c{i} = b;
end

index = 5;
timestamp = '1568981679178';
oldData = c;
prev_hash = 'lk2h3eou12ejb1weio';
difficulty = 1;
CoinBase_amount = 1;
wallet = [1357,3,851];

% output = appendTx(a,c);
% output = serializeCell(a);
output = findBlock(index,timestamp,oldData,prev_hash,difficulty,CoinBase_amount,wallet);
