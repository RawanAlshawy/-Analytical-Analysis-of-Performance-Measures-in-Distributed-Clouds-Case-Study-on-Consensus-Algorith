function wallet = createWallet()
addpath('.\RSA\');

[a,b,c] = GenerateKeyPair;
wallet = [a,b,c];
end