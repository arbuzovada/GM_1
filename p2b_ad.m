function [p, c, m, v] = p2b_ad(a, d, params)
% This function returns the probability p(b | a, d)
% INPUT:
%    a: int
%    d: int
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(b_max - b_min + 1) array of double, p(b | a, d)
%    c: [b_min : b_max]
%    m: double, expectation
%    v: double, variance

    if (d >= 0) && (d <= 2 * (a + params.bmax)) && ...
            (a >= params.amin) && (a <= params.amax) % some conditions 
        numerator = zeros(1, params.bmax - params.bmin + 1);
        max_c = [params.bmin : params.bmax] + a;
        p_d_c = p2d_c(d, [0 : (a + params.bmax)], params);
        p_c_a_b = p2c_ab([0 : a + params.bmax], a, [params.bmin : params.bmax], params);
        for c = 0 : a + params.bmax
            mask = (c <= max_c);
            numerator = numerator + p_c_a_b(:, :, c + 1) .* mask * p_d_c(c + 1);
        end
        p = numerator / sum(numerator);
        c = [params.bmin : params.bmax];
        m = c * p';
        v = (c .^ 2) * p' - m ^ 2;
    else
        throw(MException('p2b_ad:InvalidArguments', ['Arguments must ' ...
            'satisfy the following conditions:\na_min <= a <= a_max\n' ...
            '0 <= d <= 2 * (a_max + b_max)\n']));
    end
end