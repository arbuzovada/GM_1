function res = p2d_c(d, c, params)
% This function returns the probability p(d | c)
% INPUT:
%    d: int
%    c: 1-by-n array of int
% 
% OUTPUT:
%    res: 1-by-n array of double, p(d | c)
    
    if all(c >= 0) && all(c <= params.amax + params.bmax) %&& ...
            %all(d >= c) && all(d <= 2 * c)
        %res = nchoosek(c, d - c) * params.p3 ^ (d - c) * (1 - params.p3) ^ (2 * c - d);
        res = binopdf(d - c, c, params.p3);
        res(d < c) = 0;
        res(d > 2 * c) = 0;
    end
end