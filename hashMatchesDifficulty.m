function valid = hashMatchesDifficulty(hash, difficulty)

 binVec = hexToBinaryVector(hash,256);
 valid = ~(sum(binVec(1,1:difficulty))>0);
end