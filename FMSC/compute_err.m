function e = compute_err(Ls, Y)
nKernel = length(Ls);
e = zeros(nKernel, 1);
for iKernel = 1:nKernel
    T  = calculate_T(Y);
    e(iKernel) = sum(sum(Ls{iKernel}.*T));
end
end