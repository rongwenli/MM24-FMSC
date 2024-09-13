function Lw = compute_sumLs(Ls, alpha)
Lw = zeros(size(Ls{1}, 1));
for iView = 1:length(Ls)
    Lw = Lw + alpha(iView) * Ls{iView};
end
Lw = (Lw + Lw')/2;
end

