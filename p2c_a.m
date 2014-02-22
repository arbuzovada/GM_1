function [p, c, m, v] = p2c_a(a, params)
% This function evaluates distribution p(c | a)
% INPUT:
%    a: int
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(a + b_max + 1) array of double, p(c | a)
%    c: [0 : (a + b_max)]
%    m: double, expectation
%    v: double, variance

    if (a >= params.amin) && (a <= params.amax)
        % preprocessing
        p = zeros(1, a + params.bmax + 1);
        lambda = repmat(a, 1, params.bmax - params.bmin + 1) * ...
            params.p1 + [params.bmin : params.bmax] * params.p2;
        p_c_a_b = exp(-lambda);
        
        for c = 0 : (a + params.bmax)
            p(c + 1) = sum(sum(p_c_a_b));
            p_c_a_b = p_c_a_b .* lambda / (c + 1);
        end
        p = p / (params.bmax - params.bmin + 1);
        c = [0 : (a + params.bmax)];
        m = c * p';
        v = (c .^ 2) * p' - m ^ 2;
    else
        throw(MException('p2c_a:InvalidArguments', ['a must ' ...
            'satisfy the following condition:\na_min <= a <= a_max\n']));
    end
end