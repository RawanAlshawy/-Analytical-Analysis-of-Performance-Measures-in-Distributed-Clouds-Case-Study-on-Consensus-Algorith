function out = createTx(PrTx, PrTxValid)
num = [0,1,2,3,4,5,6,7,8,9];
factor = [1e0,1e1,1e2,1e3,1e4,1e5,1e6,1e7,1e8,1e9];

if rand<PrTx
    %create trasaction
    out = [sum(factor.*num(randi(9,10,1))), rand<PrTxValid];
else
    %return false
    out = false;
end

end