function res = p(s, params, arg1, arg2, arg3, arg4)
% This function evaluates the probability specified by the string s with
% the given arguments.
% INPUT:
%    s: string, f.ex. 'a|bd'
%    arg1: double, arguments of probability function in the same order as in s
%
% OUTPUT:
%    p: double, probability

    res = NaN;
    if (s == 'a')
        res = p_a(arg1, params);
    elseif (s == 'b')
        res = p_b(arg1, params);
    elseif (s == 'c')
        res = p_c(arg1, params);
    elseif (s == 'd')
        res = p_d(arg1, params);
    elseif (s == 'b|ad')
        res = p_b_cond_a_d(arg1, arg2, arg3, params);
    end
end