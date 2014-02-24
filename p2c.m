function [p, c, m, v] = p2c(params)
% This function evaluates distribution p(c)
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
    lambda = repmat(A', 1, k) * params.p1 + repmat(B, n, 1) * params.p2;
    p_a_b = exp(-lambda);
    
    for c = 0 : (params.amax + params.bmax)
        p(c + 1) = sum(sum(p_a_b));
        p_a_b = p_a_b .* lambda / (c + 1);
    end
    p = p / ((params.amax - params.amin + 1) * ...
            (params.bmax - params.bmin + 1));
    if nargout > 1
        c = [0 : (params.amax + params.bmax)];
        m = c * p';
        v = (c .^ 2) * p' - m ^ 2;
    end
end