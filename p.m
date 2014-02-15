function res = p(s, arg1, arg2, arg3, arg4)
% This function evaluates the probability specified by the string s with
% the given arguments.
% INPUT:
%    s: string, f.ex. 'a|bd'
%    arg1: double, arguments of probability function in the same order as in s
%
% OUTPUT:
%    p: double, probability

    res = 0.5;
end

% CONSTANTS
% A_MIN = 15;
% A_MAX = 30;
% B_MIN = 250;
% B_MAX = 350;
% P_1 = 0.5;
% P_2 = 0.05;
% P_3 = 0.5;

function res = p_a(a)
% This function returns the probability p(a)
% INPUT:
%    a: double
%
% OUTPUT:
%    res: double, p(a)

    res = 0;
    if (a >= A_MIN) || (a <= A_MAX)
        res = 1 / (A_MAX - A_MIN + 1);
    end
end

function res = p_b(b)
% This function returns the probability p(b)
% INPUT:
%    b: double
%
% OUTPUT:
%    res: double, p(b)

    res = 0;
    if (b >= B_MIN) && (b <= B_MAX)
        res = 1 / (B_MAX - B_MIN + 1);
    end
end

function res = p_c_cond_a_b(c, a, b)
% This function returns the probability p(c | a, b)
% INPUT:
%    c: double
%    a: double
%    b: double
%
% OUTPUT:
%    res: double, p(c | a, b)
    
    res = 0;
    if (a >= A_MIN) && (a <= A_MAX) && (b >= B_MIN) && (b <= B_MAX) && ...
        (c >= 0) && (c <= a + b)
        % lambda = a * P1 + b * P2;
        % res = exp(-lambda) * lambda ^ c / factorial(c);
        res = poisspdf(c, a * P_1 + b * P_2);
    end
end

function res = p_d_cond_c(d, c)
% This function returns the probability p(d | c)
% INPUT:
%    d: double
%    c: double
%
% OUTPUT:
%    res: double, p(d | c)
    
    res = 0;
    if (c >= 0) && (c <= A_MAX + B_MAX) && (d >= c) && (d <= 2 * c)
        res = nchoosek(c, d - c) * P_3 ^ (d - c) * (1 - P_3) ^ (2 * c - d);
    end
end