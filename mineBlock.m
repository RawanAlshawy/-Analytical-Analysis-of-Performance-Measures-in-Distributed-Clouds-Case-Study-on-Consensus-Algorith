function timeRequired = mineBlock(Difficulty,hashPerSec)

ProbabilityOfMining = 1/(Difficulty * 4295032833);  %2^(8*Difficulty)  Difficulty * 4295032833
timeRequired = 1/(hashPerSec*ProbabilityOfMining);

end



% If the current difficulty is D, then the target hash (the value below which block hashes must go) is:
% 
%     0x00000000FFFF0000000000000000000000000000000000000000000000000000 / D
% 
% (by definition of difficulty, which is a fraction of the maximum target), or otherwise put, the number of valid hashes is:
% 
%     65535 * 2208 / D
% 
% Which means that the ratio of all hashes over valid hashes would be:
% 
%     2256 / (65535 * 2208 / D) = D * 248 / 65535 = D * 4295032833
% 
% Which, at the current (January 2017) difficulty of D = 392963262344.3704 means that one hash in
% 
%     392963262344.3704 * 4295032833 = 1687790113931869416948
% 
% results in a valid block, or each attempt has a chance of
% 
%     1 / 1687790113931869416948 = 0.000000000000000000059 %

