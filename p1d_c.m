function res = p1d_c(d, c, params)
% This function evaluates distribution p(d | c)
% INPUT:
%    d: 1-by-n array of int
%    c: 1-by-m array of int
% 
% OUTPUT:
%    res: n-by-m array of double, p(d | c)
    
    if all(c >= 0) && all(c <= params.amax + params.bmax)
        n = size(d, 2);
        m = size(c, 2);
        d = reshape(repmat(d, m, 1), 1, n * m);
        c = repmat(c, 1, n);
        res = binopdf(d - c, c, params.p3);
        res = reshape(res, m, n)';
    else
        throw(MException('p2d_c:InvalidArguments', ['Arguments must ' ...
            'satisfy the following conditions:\n0 <= c <= ' ...
            'a_max + b_max\nc <= d <= 2 * c\n']));
    end
end