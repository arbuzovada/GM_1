function [p, c, m, v] = p1c(params)
% This function evaluates distribution p(c) for model 1
% INPUT:
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(a_max + b_max + 1) array of double, p(c)
%    c: [0 : (a_max + b_max)]
%    m: double, expectation
%    v: double, variance

    % preprocessing
    p = zeros(1, params.amax + params.bmax + 1);
    A = [params.amin : params.amax];
    B = [params.bmin : params.bmax];
    n = size(A, 2);
    k = size(B, 2);
    bin_a = binopdf(repmat([0 : params.amax], n, 1), ...
        repmat(A', 1, params.amax + 1), ...
        ones(n, params.amax + 1) * params.p1);
    bin_b = binopdf(repmat([0 : params.bmax], k, 1), ...
        repmat(B', 1, params.bmax + 1), ...
        ones(k, params.bmax + 1) * params.p2);
    
    for a = A
        for b = B
            p(1 : (a + b + 1)) = p(1 : (a + b + 1)) + ...
                conv(bin_a(a - params.amin + 1, 1 : (a + 1)), ...
                bin_b(b - params.bmin + 1, 1 : (b + 1)));
        end
    end
    p = p / (n * k);
    if nargout > 1
        c = [0 : (params.amax + params.bmax)];
        m = c * p';
        v = (c .^ 2) * p' - m ^ 2;
    end
end