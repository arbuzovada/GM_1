function [p, c, m, v] = p1c_a(a, params)
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
        B = [params.bmin : params.bmax];
        k = size(B, 2);
        bin_a = binopdf([0 : a], a, params.p1);
        
        for b = B
            p(1 : (a + b + 1)) = p(1 : (a + b + 1)) + ...
                conv(bin_a, binopdf([0 : b], b, params.p2));
        end
        p = p / k;
        if nargout > 1
            c = [0 : (a + params.bmax)];
            m = c * p';
            v = (c .^ 2) * p' - m ^ 2;
        end
    else
        throw(MException('p2c_a:InvalidArguments', ['a must ' ...
            'satisfy the following condition:\na_min <= a <= a_max\n']));
    end
end