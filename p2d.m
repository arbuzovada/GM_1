function [p, c, m, v] = p2d(params)
% This function returns the probability p(d)
% INPUT:
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(2 * (a_max + b_max) + 1) array of double, p(d)
%    c: [0 : 2 * (a_max + b_max)]
%    m: double, expectation
%    v: double, variance

    A = [params.amin : params.amax];
    B = [params.bmin : params.bmax];
    n = size(A, 2);
    k = size(B, 2);
    attend = repmat(A', 1, k) + repmat(B, n, 1);
    lambda = repmat(A', 1, k) * params.p1 + repmat(B, n, 1) * params.p2;
    p = zeros(1, 2 * (params.amax + params.bmax) + 1);
%     TODO: optimize these cycles
%     for d = 0 : 2 * (params.amax + params.bmax)
%         p_d_c = p2d_c(d, [0 : (params.amax + params.bmax)], params);
%         p_a_b = exp(-lambda);
%         for c = 0 : (params.amax + params.bmax)
%             mask = (attend >= c);
%             p(d + 1) = p(d + 1) + sum(sum(p_a_b(mask))) * p_d_c(c + 1);
%             p_a_b = p_a_b .* lambda / (c + 1);
%         end
%     end
    p_d_c = p2d_c([0 : 2 * (params.amax + params.bmax)], [0 : (params.amax + params.bmax)], params);
    p_a_b = exp(-lambda);
    for c = 0 : (params.amax + params.bmax)
        mask = (attend >= c);
        p = p + sum(sum(p_a_b(mask))) * p_d_c(:, c + 1)';
        p_a_b = p_a_b .* lambda / (c + 1);
    end
        
    p = p / (k * n);
    c = [0 : 2 * (params.amax + params.bmax)];
    m = c * p';
    v = (c .^ 2) * p' - m ^ 2;
end