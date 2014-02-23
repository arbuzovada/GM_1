function [p, c, m, v] = p1c_b(b, params)
% This function evaluates distribution p(c | b)
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
        % preprocessing
        p = zeros(1, params.amax + b + 1);
        A = [params.amin : params.amax];
        n = size(A, 2);
        bin_a = zeros(params.amax + 1, n);
        for a = A
            bin_a(a - params.amin + 1, 1 : (a + 1)) = ...
                binopdf([0 : a], a, params.p1);
        end
        bin_b = binopdf([0 : b], b, params.p2);
        
        for a = A
            p(1 : (a + b + 1)) = p(1 : (a + b + 1)) + ...
                conv(bin_a(a - params.amin + 1, 1 : (a + 1)), bin_b);
        end
        p = p / n;
        if nargout > 1
            c = [0 : (params.amax + b)];
            m = c * p';
            v = (c .^ 2) * p' - m ^ 2;
        end
    else
        throw(MException('p2c_a:InvalidArguments', ['b must ' ...
            'satisfy the following condition:\nb_min <= b <= b_max\n']));
    end
end