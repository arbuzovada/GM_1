function [p, c, m, v] = p1d(params)
% This function evaluates distribution p(d)
% INPUT:
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(2 * (a_max + b_max) + 1) array of double, p(d)
%    c: [0 : 2 * (a_max + b_max)]
%    m: double, expectation
%    v: double, variance

    % preprocessing
    p_d_c = p2d_c([0 : 2 * (params.amax + params.bmax)], ...
        [0 : (params.amax + params.bmax)], params);
    p_c = p1c(params);
    
    p = p_c * p_d_c';
    c = [0 : 2 * (params.amax + params.bmax)];
    m = c * p';
    v = (c .^ 2) * p' - m ^ 2;
end