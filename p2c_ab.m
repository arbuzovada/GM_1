function res = p2c_ab(c, a, b, params)
% This function returns the probability p(c | a, b)
% INPUT:
%    c: 1-by-k array of int
%    a: 1-by-n array of int
%    b: 1-by-m array of int
%
% OUTPUT:
%    res: n-by-m-by-k array of double, p(c | a, b)
    
    if all(a >= params.amin) && all(a <= params.amax) && ...
            all(b >= params.bmin) && all(b <= params.bmax) && ...
            all(c >= 0) && all(c <= max(a) + max(b))
        k = size(c, 2);
        n = size(a, 2);
        m = size(b, 2);
        lambda = repmat(a', 1, m) * params.p1 + repmat(b, n, 1) * params.p2;
        lambda = repmat(lambda, [1, 1, k]);
        c = repmat(reshape(c, [1, 1, k]), [n, m, 1]);
        res = poisspdf(c, lambda);
    else
        throw(MException('p2c_ab:InvalidArguments', ['Arguments must ' ...
            'satisfy the following conditions:\na_min <= a <= a_max\n' ...
            'b_min <= b <= b_max\n0 <= c <= a + b\n']));
    end
end