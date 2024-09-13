function [Y,alphav,objHistory] = FMSC(Ls,Y0,G,lambda)

nView = length(Ls);
nSmp = size(Y0,1);
nCluster = size(Y0,2); 
maxIter = 50;
Y = Y0;
flag = 1;
iter = 0;
A = lambda.*(G*G');
objHistory = [];


% Initialization alpha
alphav = update_alpha(ones(nView, 1));
Lsum = compute_sumLs(Ls, alphav);

while flag
    iter = iter +1;

    % Update Y
    K = Lsum + A;
    [Y,~] = solve_Y(K,Y);

    %Update alphav
    e = compute_err(Ls, Y);
    alphav = update_alpha(e);
    Lsum = compute_sumLs(Ls, alphav);
    

    B = Lsum + A;
    T = calculate_T(Y);
    obj = sum(sum(B.*T));
    objHistory = [objHistory; obj];
    if (iter>2) && (abs((objHistory(iter)-objHistory(iter-1))/(objHistory(iter)))<1e-4 || iter>maxIter)
        flag =0;
   end
end




end

