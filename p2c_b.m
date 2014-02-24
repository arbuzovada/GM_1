function [p, c, m, v] = p2c_b(b, params)
% This function evaluates distribution p(c | b)
% INPUT:
%    b: int
%    params: structure of parameters
%
% OUTPUT:
%    p: 1-by-(a_max + b + 1) array of double, p(c | b)
%    c: [0 : (a_max + b)]
%    m: double, expectation
%    v: double, variance

    if (b >= params.bmin) && (b <= params.bmax)
        % preprocessing
        p = zeros(1, params.amax + b + 1);
        lambda = [params.amin : params.amax] * params.p1 + ...
            repmat(b, 1, params.amax - params.amin + 1) * params.p2;
        p_c_a_b = exp(-lambda);
        
        for c = 0 : (params.amax + b)
            p(c + 1) = sum(sum(p_c_a_b));
            p_c_a_b = p_c_a_b .* lambda / (c + 1);
        end
        p = p / (params.amax - params.amin + 1);
        if nargout > 1
            c = [0 : (params.amax + b)];
            m = c * p';
            v = (c .^ 2) * p' - m ^ 2;
        end
    else
        throw(MException('p2c_a:InvalidArguments', ['b must ' ...
            'satisfy the following condition:\nb_min <= b <= b_max\n']));
    end
end