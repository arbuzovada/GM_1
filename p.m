function res = p(s, arg1, arg2, arg3, arg4)
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
        res = p_a(arg1);
    elseif (s == 'b')
        res = p_b(arg1);
    elseif (s == 'c')
        res = p_c(arg1);
    elseif (s == 'd')
        res = p_d(arg1);
    end
end

function res = p_a(a)
% This function returns the probability p(a)
% INPUT:
%    a: int
%
% OUTPUT:
%    res: double, p(a)

    global A_MIN A_MAX B_MIN B_MAX P_1 P_2 P_3 N M
    res = 0;
    if (a >= A_MIN) || (a <= A_MAX)
        res = 1 / (A_MAX - A_MIN + 1);
    end
end

function res = p_b(b)
% This function returns the probability p(b)
% INPUT:
%    b: int
%
% OUTPUT:
%    res: double, p(b)

    global A_MIN A_MAX B_MIN B_MAX P_1 P_2 P_3 N M
    res = 0;
    if (b >= B_MIN) && (b <= B_MAX)
        res = 1 / (B_MAX - B_MIN + 1);
    end
end

function res = p_c_cond_a_b(c, a, b)
% This function returns the probability p(c | a, b)
% INPUT:
%    c: int
%    a: 1-by-n array of int
%    b: 1-by-m array of int
%
% OUTPUT:
%    res: n-by-m array of double, p(c | a, b)
    
    global A_MIN A_MAX B_MIN B_MAX P_1 P_2 P_3 N M
    res = 0;
    if all(a >= A_MIN) && all(a <= A_MAX) && all(b >= B_MIN) && all(b <= B_MAX) && ...
        (c >= 0) && (c <= max(a) + max(b))
        m = size(b, 2);
        n = size(a, 2);
%         size(repmat(a', 1, m))
%         size(repmat(b, n, 1) * P_2)
        lambda = repmat(a', 1, m) * P_1 + repmat(b, n, 1) * P_2;
        res = exp(-lambda) .* lambda .^ c / factorial(c);
        if isnan(res)
            fprintf('fail\n');
        end
        %res = poisspdf(c, a * P_1 + b * P_2);
    end
end

function res = p_d_cond_c(d, c)
% This function returns the probability p(d | c)
% INPUT:
%    d: int
%    c: 1-by-n array of int
%
% OUTPUT:
%    res: 1-by-n array of double, p(d | c)
    
    global A_MIN A_MAX B_MIN B_MAX P_1 P_2 P_3 N M
    if all(c >= 0) && all(c <= A_MAX + B_MAX) %&& ...
            %all(d >= c) && all(d <= 2 * c)
        %res = nchoosek(c, d - c) * P_3 ^ (d - c) * (1 - P_3) ^ (2 * c - d);
        res = binopdf(c, d - c, P_3);
        res(d < c) = 0;
        rec(d > 2 * c) = 0;
    end
end

function res = p_c(c)
% This function returns the probability p(c)
% INPUT:
%    c: int
%
% OUTPUT:
%    res: double, p(c)

    global A_MIN A_MAX B_MIN B_MAX P_1 P_2 P_3 N M
    res = 0;
    if (c >= 0) && (c <= A_MAX + B_MAX)
        p_a_b = p_c_cond_a_b(c, [A_MIN : A_MAX], [B_MIN : B_MAX]);
        p_d_c = p_d_cond_c([c : 2 * c], c);
        for d = c : 2 * c
            for a = A_MIN : A_MAX
                for b = B_MIN : B_MAX
                    % res = res + p_c_cond_a_b(c, a, b);
                    res = res + p_a_b(a - A_MIN + 1, b - B_MIN + 1);
                end
            end
            res = res * p_d_c(d - c + 1);
        end
        res = res / ((A_MAX - A_MIN + 1) * (B_MAX - B_MIN + 1));
    end
end

function res = p_d(d)
% This function returns the probability p(d)
% INPUT:
%    d: int
%
% OUTPUT:
%    res: double, p(d)

    global A_MIN A_MAX B_MIN B_MAX P_1 P_2 P_3 N M 
    res = 0;
    if (d >= 0) && (d <= 2 * (A_MAX + B_MAX))
%         d_cond_c = zeros(1, A_MAX + B_MAX + 1);
%         for c = 0 : A_MAX + B_MAX
%             d_cond_c(c + 1) = p_d_cond_c(d, c);
%         end
        d_cond_c = p_d_cond_c(d, [0 : A_MAX + B_MAX])
%         for a = A_MIN : A_MAX
%             for b = B_MIN : B_MAX
%                 for c = 0 : (a + b)
%                     res = res + p_c_cond_a_b(c, a, b) * d_cond_c(c + 1);
%                 end
%             end
%         end
        c_count = repmat([A_MIN : A_MAX]', 1, M) + ...
            repmat([B_MIN : B_MAX], N, 1);
        for c = 0 : (A_MAX + B_MAX)
            res = res + sum(sum(p_c_cond_a_b(c, [A_MIN : A_MAX], ...
                [B_MIN : B_MAX]))) * d_cond_c(c + 1);
        end
        
        res = res / ((A_MAX - A_MIN + 1) * (B_MAX - B_MIN + 1));
    end
end