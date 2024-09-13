function [balance] = compute_fair(G)
%COMPUTE_BLANCE 此处显示有关此函数的摘要
%   此处显示详细说明
maximum = max(G,[],1);
minimum = min(G,[],1);
balance_vector = minimum./maximum;
balance = min(balance_vector);
end

