function [p, c, m, v] = p2b_ad(a, d, params)
% This function returns the probability p(b | a, d)
% INPUT:
%    a: int
%    d: int
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(b_max - b_min + 1) array of double, p(b | a, d)
%    c: 1-by-(b_max - b_min + 1) array of double, cumsum(p)
%    m: double, expectation
%    v: double, variance

    numerator = zeros(1, params.bmax - params.bmin + 1);
    denominator = 0;
    max_c = [params.bmin : params.bmax] + a;
    if (d >= 0) && (d <= 2 * (a + params.bmax)) % some conditions 
        p_d_c = p2d_c(d, [0 : (a + params.bmax)], params);
        for c = 0 : a + params.bmax
            mask = (c <= max_c);
            p_c_a_b = p2c_ab(c, a, [params.bmin : params.bmax], params);
%             numerator = numerator + p_c_a_b(b - params.bmin + 1) * mask(b - params.bmin + 1) * d_cond_c(c + 1);
            numerator = numerator + p_c_a_b .* mask * p_d_c(c + 1);
            denominator = denominator + sum(p_c_a_b(mask)) * p_d_c(c + 1);
        end
        p = numerator / denominator;
        c = cumsum(p);
        m = [params.bmin : params.bmax] * p';
        v = ([params.bmin : params.bmax] .^ 2) * p' - m ^ 2;
    else
        throw(MException('p2b_ad:InvalidArguments', ['Arguments must ' ...
            'satisfy the following conditions:\na_min <= a <= a_max\n' ...
            '0 <= d <= 2 * (a_max + b_max)\n']));
    end
end