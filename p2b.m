function [p, b, m, v] = p2b(params)
% This function evaluates distributiony p(b)
% INPUT:
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(b_max - b_min + 1) array of double, p(b)
%    b: [b_min : b_max]
%    m: double, expectation
%    v: double, variance

    p = ones(1, params.bmax - params.bmin + 1) / (params.bmax - ...
        params.bmin + 1);
    if nargout > 1
        b = [params.bmin : params.bmax];
        m = (params.bmin + params.bmax) / 2;
        v = ((params.bmax - params.bmin + 1) ^ 2 - 1) / 12;
    end
end