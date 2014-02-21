params.amin = 15;
params.amax = 30;
params.n = params.amax - params.amin + 1;
params.bmin = 250;
params.bmax = 350;
params.m = params.bmax - params.bmin + 1;
params.p1 = 0.5;
params.p2 = 0.05;
params.p3 = 0.5;
nsteps = 20;

f = figure();
xlim([-0.05 1.05]);
ylim([-0.05 1.05]);
axis equal;
box on;
hold on;
va = zeros(nsteps + 1);
vb = zeros(nsteps + 1);
for i1 = 0 : nsteps
    for i2 = 0 : nsteps
        params.p1 = i1 / nsteps;
        params.p2 = i2 / nsteps;
        [~, ~, ~, va(i1 + 1, i2 + 1)] = p2c_a(fix((params.amin + params.amax) / 2), params);
        [~, ~, ~, vb(i1 + 1, i2 + 1)] = p2c_b(fix((params.bmin + params.bmax) / 2), params);
%         if (va < vb)
%             scatter(p1, p2, 'r')
%         else
%             scatter(p1, p2, 'b')
%         end
%         drawnow
    end
end

surf([0 : nsteps] / nsteps, [0 : nsteps] / nsteps, va - vb, 'EdgeColor', 'none') % abs(va-vb),
hold on;
% surf([0 : nsteps] / nsteps, [0 : nsteps] / nsteps, vb)
xlabel('p_1')
ylabel('p_2')
zlabel('D(c|a) - D(c|b)')
colormap spring