function ai = update_alpha(err)


err1 = err.^1;


ai = 1 ./ max(err1,eps);
ai= ai ./ max(sum(ai),eps);

end