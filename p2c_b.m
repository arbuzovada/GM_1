function [p, c, m, v] = p2c_b(b, params)
% This function returns the probability p(c | b)
% INPUT:
%    b: int
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(a_max + b + 1) array of double, p(c | b)
%    c: [0 : (a_max + b)]
%    m: double, expectation
%    v: double, variance

    if (b >= params.bmin) && (b <= params.bmax)
        p = zeros(1, params.amax + b + 1);
        for c = 0 : (params.amax + b)
            p(c + 1) = sum(sum(p2c_ab(c, [params.amin : params.amax], b, ...
                params)));
        end
        p = p / (params.amax - params.amin + 1);
        c = [0 : (params.amax + b)];
        m = c * p';
        v = (c .^ 2) * p' - m ^ 2;
    else
        throw(MException('p2c_a:InvalidArguments', ['b must ' ...
            'satisfy the following condition:\nb_min <= b <= b_max\n']));
    end
end