function [p, c, m, v] = p2b(params)
% This function returns the probability p(b)
% INPUT:
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(b_max - b_min + 1) array of double, p(b)
%    c: 1-by-(b_max - b_min + 1) array of double, cumsum(p)
%    m: double, expectation
%    v: double, variance

    p = ones(1, params.bmax - params.bmin + 1) / (params.bmax - ...
        params.bmin + 1);
    c = cumsum(p);
    m = (params.bmin + params.bmax) / 2;
    v = (params.bmax - params.bmin) ^ 2 / 12;
end