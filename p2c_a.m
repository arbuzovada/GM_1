function [p, c, m, v] = p2c_a(a, params)
% This function returns the probability p(c | a)
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
        p = zeros(1, a + params.bmax + 1);
        % TODO: optimize this cycle!!!
        for c = 0 : (a + params.bmax)
            p(c + 1) = sum(sum(p2c_ab(c, a, [params.bmin : params.bmax], ...
                params)));
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