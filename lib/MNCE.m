function [obj] = MNCE(G)
%COMPUTE_ 此处显示有关此函数的摘要
%   此处显示详细说明
C = sum(G,1);
G1 = G./C;
G1 = -G1.*log(max(G1,eps));
G1 = sum(G1,1);
minentropy = min(G1);

G2 = sum(G,2);
G2 = G2./sum(G2);
G2 = -G2.*log(max(G2,eps));
entropy = sum(G2);
obj = minentropy/entropy;
end

