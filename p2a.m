function [p, a, m, v] = p2a(params)
% This function evaluates distribution p(a)
% INPUT:
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(a_max - a_min + 1) array of double, p(a)
%    a: [a_min : a_max]
%    m: double, expectation
%    v: double, variance

    p = ones(1, params.amax - params.amin + 1) / (params.amax - ...
        params.amin + 1);
    if nargout > 1
        a = [params.amin : params.amax];
        m = (params.amin + params.amax) / 2;
        v = ((params.amax - params.amin + 1) ^ 2 - 1) / 12;
    end
end