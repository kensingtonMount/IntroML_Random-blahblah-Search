%Knapsack Problem in User Fair Scheduling in Wireless Networks

value=[50 40 30 50 30 24 36 42 58 52];
packetSize=[5 4 6 3 2 6 7 1 8 10];
TotalCapacity=30;
beta=0:.01:1;
n=1000;

%%
%Random Hill Climbing
tic
n_ini = randi([1,length(packetSize)],1); %initialize with random number of items
iter = 0;
notBestSol = 1;
threshold = 5;
maxIter = 100000;
idx_ini = randi([1 length(packetSize)],[1,n_ini]);
sum_packetSize_ini = sum(value(idx_ini).*packetSize(idx_ini));
while iter < maxIter && notBestSol
    idx = randi([1 length(packetSize)],[1,n_ini]);
    sum_packetSize = sum(value(idx).*packetSize(idx));
    sum_packetSize_old = sum_packetSize_ini;
    delta = sum_packetSize - sum_packetSize_old;
    if delta > 0 && sum(packetSize(idx_ini)) < TotalCapacity
        sum_packetSize_old = sum_packetSize;
        idx_best_sofar = idx;
        packetSize_best_sofar = sum_packetSize;
%     elseif iter >2/3*maxIter
%         notBestSol = 0
%         break;
    end
    iter = iter+1;
    n_ini = randi([1,length(packetSize)],1);
    idx_ini = randi([1 length(packetSize)],[1,n_ini]);
    sum_packetSize_ini = sum(value(idx_ini).*packetSize(idx_ini));
end
FinalValue_rhc=sum(value(idx_best_sofar))
FinalItems_rhc = idx_best_sofar
toc
%%
%Simulated Annealing
tic
KnapsackSA(value, packetSize, TotalCapacity, beta, n)
toc
%%
%Genetic Algorithm
tic
knapsackGA(value,TotalCapacity)
toc


