%traveling salesman problem in wireless communications

nodes = [0.6606,0.9695,0.5906,0.2124,0.0398,0.1367,0.9536,0.6091,0.8767,...
        0.8148,0.3876,0.7041,0.0213,0.3429,0.7471,0.5449,0.9464,0.1247,0.1636,...
        0.8668;
        0.9500,0.6740,0.5029,0.8274,0.9697,0.5979,0.2184,0.7148,0.2395,...
        0.2867,0.8200,0.3296,0.1649,0.3025,0.8192,0.9392,0.8191,0.4351,0.8646,...
        0.6768];
figure;
scatter(nodes(1,:),nodes(2,:),'*');set(gcf,'color','white');
%hold on;plot(nodes(1,:),nodes(2,:));
%cost function as the total distance of all nodes
d = 0;
for n = 1 : length(nodes)
    if n == length(nodes)
        d = d + norm(nodes(:,n) - nodes(:,1));
    else    
        d = d + norm(nodes(:,n) - nodes(:,n+1));
    end
end

initial_temperature = 78; %Kelvin
cooling_rate = .97;
maxIter = 3000;
nSwap = 4;
%Uncomment this to enable SA and its associated result plotting functions
output = simulatedannealing(nodes,initial_temperature,cooling_rate, maxIter,nSwap);


%%
%Random Hill Climbing
%Swap arbitrary number of pairs of nodes in the layout

iter = 0;
notBestSol = 1;
threshold = 1e-1;
while iter < maxIter && notBestSol
    n = randi([1 size(nodes,2)],1);
    s = nodes;
    for i = 1:n
        node_1 = round(length(nodes)*rand(1));
        if node_1 < 1
            node_1 = 1;
        end
        node_2 = round(length(nodes)*rand(1));
        if node_2 < 1
            node_2 = 1;
        end
        temp = s(:,node_1);
        s(:,node_1) = s(:,node_2);
        s(:,node_2) = temp;
    end
    nodes_new = s;
    dist_new = distance_tsp(nodes_new);
    d_origin = d;
    delta = dist_new - d;
    if delta < threshold
        d = dist_new;
        nodes_best_sofar = nodes_new;
        iter_best = iter;
    elseif iter > 2/3*maxIter
        notBestSol = 0;
        break;
    end
    threshold = delta;
    iter = iter+1;
end
iter
delta
figure;set(gcf,'color','white');plot(nodes_best_sofar(1,:),nodes_best_sofar(2,:));hold on;scatter(nodes(1,:),nodes(2,:),'*');
title(['The roundtrip length for ' num2str(length(nodes)) ' nodes is ' num2str(d) ' units at ' num2str(iter_best) ' iteration']);
%%
%Genetic Algorithm

user_config = struct('xy',nodes');
tsp_ga(user_config);