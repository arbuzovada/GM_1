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

function res = p_c(c, params)
% This function returns the probability p(c)
% INPUT:
%    c: int
%
% OUTPUT:
%    res: double, p(c)

    res = 0;
    if (c >= 0) && (c <= params.amax + params.bmax)
        p_a_b = p_c_cond_a_b(c, [params.amin : params.amax], ...
            [params.bmin : params.bmax], params);
        res = sum(sum(p_a_b(:, :))) / ((params.amax - params.amin + 1) ...
            * (params.bmax - params.bmin + 1));
    end
end

function res = p_d(d, params)
% This function returns the probability p(d)
% INPUT:
%    d: int
% 
% OUTPUT:
%    res: double, p(d)

    res = 0;
    if (d >= 0) && (d <= 2 * (params.amax + params.bmax))
        d_cond_c = p_d_cond_c(d, [0 : (params.amax + params.bmax)], params);
        A = [params.amin : params.amax];
        B = [params.bmin : params.bmax];
        m = size(B, 2);
        n = size(A, 2);
        attend = repmat(A', 1, m) + repmat(B, n, 1);
        lambda = repmat(A', 1, m) * params.p1 + repmat(B, n, 1) * params.p2;
        p_a_b = exp(-lambda);
        for c = 0 : (params.amax + params.bmax)
%             p_a_b = p_c_cond_a_b(c, [params.amin : params.amax], ...
%                 [params.bmin : params.bmax], params);
            mask = (attend >= c);
            res = res + sum(sum(p_a_b(mask))) * d_cond_c(c + 1);
            p_a_b = p_a_b .* lambda / (c + 1);
        end
        
        res = res / ((params.amax - params.amin + 1) * ...
            (params.bmax - params.bmin + 1));
    end
end