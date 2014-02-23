function res = p1c_ab(c, a, b, params)
% This function evaluates distribution p(c | a, b)
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
        res = zeros(size(a, 2), size(b, 2), size(c, 2));
        for i = a
            for j = b
                res(i, j, 1 : (i + j + 1)) = conv(binopdf([0 : i], ...
                    i, params.p1), binopdf([0 : j], j, params.p2));
            end
        end
    else
        throw(MException('p2c_ab:InvalidArguments', ['Arguments must ' ...
            'satisfy the following conditions:\na_min <= a <= a_max\n' ...
            'b_min <= b <= b_max\n0 <= c <= a + b\n']));
    end
end