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

function res = p_a(a, params)
% This function returns the probability p(a)
% INPUT:
%    a: int
%
% OUTPUT:
%    res: double, p(a)

%     global params.amin params.amax params.bmin params.bmax params.p1 params.p2 params.p3 N M
    res = 0;
    if (a >= params.amin) || (a <= params.amax)
        res = 1 / (params.amax - params.amin + 1);
    end
end

function res = p_b(b, params)
% This function returns the probability p(b)
% INPUT:
%    b: int
%
% OUTPUT:
%    res: double, p(b)

%     global params.amin params.amax params.bmin params.bmax params.p1 params.p2 params.p3 N M
    res = 0;
    if (b >= params.bmin) && (b <= params.bmax)
        res = 1 / (params.bmax - params.bmin + 1);
    end
end

function res = p_c_cond_a_b(c, a, b, params)
% This function returns the probability p(c | a, b)
% INPUT:
%    c: int
%    a: 1-by-n array of int
%    b: 1-by-m array of int
%
% OUTPUT:
%    res: n-by-m array of double, p(c | a, b)
    
%     global params.amin params.amax params.bmin params.bmax params.p1 params.p2 params.p3 N M
    res = 0;
    if all(a >= params.amin) && all(a <= params.amax) && all(b >= params.bmin) && all(b <= params.bmax) && ...
        (c >= 0) && (c <= max(a) + max(b))
        m = size(b, 2);
        n = size(a, 2);
%         size(repmat(a', 1, m))
%         size(repmat(b, n, 1) * params.p2)
        lambda = repmat(a', 1, m) * params.p1 + repmat(b, n, 1) * params.p2;
%         res = exp(-lambda) .* lambda .^ c / factorial(c);
%         res = ones(size(lambda));
%         for i = 1 : c
%             res = res .* lambda / i;
%         end
%         res = res .* exp(-lambda);
%         if isnan(res)
%             fprintf('fail\n');
%         end
        res = poisspdf(c, lambda);
    end
end

function res = p_d_cond_c(d, c, params)
% This function returns the probability p(d | c)
% INPUT:
%    d: int
%    c: 1-by-n array of int
% 
% OUTPUT:
%    res: 1-by-n array of double, p(d | c)
    
    if all(c >= 0) && all(c <= params.amax + params.bmax) %&& ...
            %all(d >= c) && all(d <= 2 * c)
        %res = nchoosek(c, d - c) * params.p3 ^ (d - c) * (1 - params.p3) ^ (2 * c - d);
        res = binopdf(d - c, c, params.p3);
        res(d < c) = 0;
        res(d > 2 * c) = 0;
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

function res = p_b_cond_a_d(b, a, d, params)
% This function returns the probability p(b | a, d)
% INPUT:
%    b: int
%    a: int
%    d: int
%
% OUTPUT:
%    res: double, p(b | a, d)

    res = 0;
    if (d >= 0) && (d <= 2 * (a + b))
        d_cond_c = p_d_cond_c(d, [0 : (a + params.bmax)], params);
        up = 0;
        for c = 0 : a + params.bmax
            mask = ([params.bmin : params.bmax] + a >= c);
            p_c_a_b = p_c_cond_a_b(c, a, [params.bmin : params.bmax], params);
            up = up + p_c_a_b(b - params.bmin + 1) * mask(b - params.bmin + 1) * d_cond_c(c + 1);
            res = res + sum(p_c_a_b(mask)) * d_cond_c(c + 1);
        end
        res = up / res;
    end
end