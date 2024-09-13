function [T] = calculate_T(Y)

d = diag(Y'*Y);
d1 = 1./d;
D = diag(d1);
T = Y*D*Y';

end

