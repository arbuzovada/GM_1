function [p, c, m, v] = p2a(params)
% This function returns the probability p(a)
% INPUT:
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(a_max - a_min + 1) array of double, p(a)
%    c: [a_min : a_max]
%    m: double, expectation
%    v: double, variance

    p = ones(1, params.amax - params.amin + 1) / (params.amax - ...
        params.amin + 1);
    c = [params.amin : params.amax];
    m = (params.amin + params.amax) / 2;
    v = (params.amax - params.amin) ^ 2 / 12;
end