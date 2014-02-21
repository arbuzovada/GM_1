function [p, c, m, v] = p2c(params)
% This function returns the probability p(c)
% INPUT:
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(a_max + b_max + 1) array of double, p(c)
%    c: [0 : (a_max + b_max)]
%    m: double, expectation
%    v: double, variance

    p = zeros(1, params.amax + params.bmax + 1);
    % TODO: optimize this cycle!!!
    for c = 0 : (params.amax + params.bmax)
        p_a_b = p2c_ab(c, [params.amin : params.amax], ...
            [params.bmin : params.bmax], params);
        p(c + 1) = sum(sum(p_a_b(:, :)));
    end
    p = p / ((params.amax - params.amin + 1) ...
            * (params.bmax - params.bmin + 1));
    c = [0 : (params.amax + params.bmax)];
    m = [0 : (params.amax + params.bmax)] * p';
    v = ([0 : (params.amax + params.bmax)] .^ 2) * p' - m ^ 2;
end