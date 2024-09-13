clear;
clc;
lib_path = fullfile(pwd, '.',  filesep, "lib", filesep);
addpath(lib_path);
code_path = fullfile(pwd, '.',  filesep, "FMSC", filesep);
addpath(code_path);


data_name = 'COIL20-3v';



clear X y Y;
load(data_name);
clear Y;
G = full(ind2vec(g'))';
nSmp = length(y);
nCluster = length(unique(y));
nView = length(X);
nRepeat = 1;
iParam = 0;

% Parameter Configuration
knn_size = 5;
t = 1;
lambda_range = [-5:1:1];


% Construct L
Ls = cell(1,nView);
options = [];
options.NeighborMode = 'KNN';
options.k = knn_size;
options.WeightMode = 'HeatKernel';
options.t = t;

L_total = zeros(nSmp);
for iView = 1:nView
    S = constructW(X{iView},options);
    dd= sqrt(1./max(sum(S,2),eps));
    L= eye(nSmp) -diag(dd)*S*diag(dd);    
    Ls{iView} = L;
    L_total = L_total + L;
end
L_avg = L_total./nView;


% initialization Y0
[H, ~] = eigs(L_avg, nCluster,'SA');
H_normalized = H ./ repmat(sqrt(sum(H.^2, 2)), 1,nCluster);
label0 = kmeans(H_normalized, nCluster, 'MaxIter', 50, 'Replicates', 10);
Y0 = full(ind2vec(label0'))';

% Algorithm backbone
for ilam = 1:length(lambda_range)
    ilam
    lambda = 10^lambda_range(ilam);
    iParam = iParam + 1;
    for iRepeat = 1:nRepeat
        [Y,alphav,obj] = FMSC(Ls,Y0,G,lambda);
        [~,label] = max(Y,[],2);
        result = my_fair_eval_y(label, y,g);        
        agtFMSC_result(iParam, : , iRepeat) = result';
    end
    a1 = mean(agtFMSC_result,3);
    agtFMSC_grid_result = reshape(a1,size(agtFMSC_result,1), size(agtFMSC_result,2));
    save(['./result/result_' data_name],'agtFMSC_grid_result');
end