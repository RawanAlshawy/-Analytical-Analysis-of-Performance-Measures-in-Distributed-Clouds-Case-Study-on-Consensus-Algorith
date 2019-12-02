clc
clear all
close all

load('matlabAdverserial.mat')
lambda = 1e-2 * [1:10];
plot(lambda,numConflictingBlocksAttacks(1:10),'-rs')
xlabel('Network Degradation Parameter (\lambda)')
ylabel('Number of Parallel Chains Attacks')