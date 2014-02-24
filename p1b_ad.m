function [p, b, m, v] = p1b_ad(a, d, params)
% This function evaluates distribution p(b | a, d)
% INPUT:
%    a: int
%    d: int
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(b_max - b_min + 1) array of double, p(b | a, d)
%    b: [b_min : b_max]
%    m: double, expectation
%    v: double, variance

    if (d >= 0) && (d <= 2 * (a + params.bmax)) && ...
            (a >= params.amin) && (a <= params.amax)
        % preprocessing
        numerator = zeros(1, params.bmax - params.bmin + 1);
        B = [params.bmin : params.bmax];
        k = size(B, 2);
        bin_a = binopdf([0 : a], a, params.p1);
        bin_b = zeros(params.bmax + 1, k);
        for b = B
            bin_b(b - params.bmin + 1, 1 : (b + 1)) = ...
                binopdf([0 : b], b, params.p2);
        end
        p_d_c = p2d_c(d, [0 : (a + params.bmax)], params);
        
        for b = B
            numerator(b - params.bmin + 1) = numerator(b - params.bmin + 1) + ...
            conv(bin_a, bin_b(b - params.bmin + 1, 1 : (b + 1))) * p_d_c(1 : (a + b + 1))';
        end
        p = numerator / sum(numerator);
        if nargout > 1
            b = B;
            m = b * p';
            v = (b .^ 2) * p' - m ^ 2;
        end
    else
        throw(MException('p2b_ad:InvalidArguments', ['Arguments must ' ...
            'satisfy the following conditions:\na_min <= a <= a_max\n' ...
            '0 <= d <= 2 * (a_max + b_max)\n']));
    end
end