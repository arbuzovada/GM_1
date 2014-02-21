function res = p2c_ab(c, a, b, params)
% This function returns the probability p(c | a, b)
% INPUT:
%    c: int
%    a: 1-by-n array of int
%    b: 1-by-m array of int
%
% OUTPUT:
%    res: n-by-m array of double, p(c | a, b)
    
    if all(a >= params.amin) && all(a <= params.amax) && ...
            all(b >= params.bmin) && all(b <= params.bmax) && ...
            (c >= 0) && (c <= max(a) + max(b))
        m = size(b, 2);
        n = size(a, 2);
        lambda = repmat(a', 1, m) * params.p1 + repmat(b, n, 1) * params.p2;
        res = poisspdf(c, lambda);
    else
        throw(MException('p2c_ab:InvalidArguments', ['Arguments must ' ...
            'satisfy the following conditions:\na_min <= a <= a_max\n' ...
            'b_min <= b <= b_max\n0 <= c <= a + b\n']));
    end
end