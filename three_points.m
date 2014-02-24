% find 3 zero points
cur_p1 = [0.4, 0.6, 0.8];
params.p1 = cur_p1(1);
cur_min = 1;
cur_p2 = zeros(1, 3);
for p2 = 0 : 0.001 : 0.2
    params.p2 = p2;
    [~, ~, ~, va] = p1c_a(fix((params.amin + params.amax) / 2), params);
    [~, ~, ~, vb] = p1c_b(fix((params.bmin + params.bmax) / 2), params);
    cur = abs(va - vb);
    if cur < cur_min
        cur_p2(1) = p2;
        cur_min = cur;
    end
end
fprintf('p1 = 0.4, p2 = %f, va - vb = %f\n', cur_p2(1), cur_min);
params.p1 = cur_p1(2);
cur_min = 1;
for p2 = 0 : 0.001 : 0.2
    params.p2 = p2;
    [~, ~, ~, va] = p1c_a(fix((params.amin + params.amax) / 2), params);
    [~, ~, ~, vb] = p1c_b(fix((params.bmin + params.bmax) / 2), params);
    cur = abs(va - vb);
    if cur < cur_min
        cur_p2(2) = p2;
        cur_min = cur;
    end
end
fprintf('p1 = 0.6, p2 = %f, va - vb = %f\n', cur_p2(2), cur_min);
params.p1 = cur_p1(3);
cur_min = 1;
cur_p2 = 0;
for p2 = 0 : 0.001 : 0.2
    params.p2 = p2;
    [~, ~, ~, va] = p1c_a(fix((params.amin + params.amax) / 2), params);
    [~, ~, ~, vb] = p1c_b(fix((params.bmin + params.bmax) / 2), params);
    cur = abs(va - vb);
    if cur < cur_min
        cur_p2(3) = p2;
        cur_min = cur;
    end
end
fprintf('p1 = 0.8, p2 = %f, va - vb = %f\n', cur_p2(3), cur_min);
f = figure();
scatter(cur_p1, cur_p2, 'g')