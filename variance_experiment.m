params.amin = 15;
params.amax = 30;
params.n = params.amax - params.amin + 1;
params.bmin = 250;
params.bmax = 350;
params.m = params.bmax - params.bmin + 1;
params.p1 = 0.5;
params.p2 = 0.05;
params.p3 = 0.5;
nsteps = 50;

f = figure();
axis equal;
xlim([-0.05 1.05]);
ylim([-0.05 1.05]);
box on;
hold on;
va = zeros(nsteps + 1);
vb = zeros(nsteps + 1);
for i1 = 0 : nsteps
    for i2 = 0 : nsteps
        params.p1 = i1 / nsteps;
        params.p2 = i2 / nsteps;
        [~, ~, ~, va(i1 + 1, i2 + 1)] = p1c_a(fix((params.amin + params.amax) / 2), params);
        [~, ~, ~, vb(i1 + 1, i2 + 1)] = p1c_b(fix((params.bmin + params.bmax) / 2), params);
        if (va(i1 + 1, i2 + 1) < vb(i1 + 1, i2 + 1))
            scatter(i1 / nsteps, i2 / nsteps, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r')
        else
            scatter(i1 / nsteps, i2 / nsteps, 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b')
        end
        drawnow
    end
end
xlabel('p_1')
ylabel('p_2')
print('variance_binary_1', '-depsc2', '-r300');
eps2xxx('variance_binary_1.eps', {'jpeg'}, 'C:\Program Files\gs\gs9.10\bin\gswin64c.exe')

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

f = figure();
save variance_1.mat va vb
surf([0 : nsteps] / nsteps, [0 : nsteps] / nsteps, va - vb)
surf([0 : nsteps] / nsteps, [0 : nsteps] / nsteps, zeros(nsteps+1), 1000*ones(nsteps+1), 'EdgeColor', 'none')
hold on;
% surf([0 : nsteps] / nsteps, [0 : nsteps] / nsteps, vb)
xlabel('p_1')
ylabel('p_2')
zlabel('D(c|a) - D(c|b)')
colormap spring
print('variance_1', '-depsc2', '-r300');
eps2xxx('variance_1.eps', {'jpeg'}, 'C:\Program Files\gs\gs9.10\bin\gswin64c.exe')