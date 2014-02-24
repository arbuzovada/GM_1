clear

% colors
red1 = [209 70 39] / 255;
green1 = [71 162 89] / 255;
blue1 = [79 110 182] / 255;
blue2 = 0.8 * [173 220 220] / 255;
brown1 = [158 62 57] / 255;
orange1 = [249 183 67] / 255;
orange2 = [202 123 67] / 255;
violet1 = [168 120 184] / 255;

% CONSTANTS
params.amin = 15;
params.amax = 30;
params.n = params.amax - params.amin + 1;
params.bmin = 250;
params.bmax = 350;
params.m = params.bmax - params.bmin + 1;
params.p1 = 0.5;
params.p2 = 0.05;
params.p3 = 0.5;

% p('b|ad', params, 300, 19, 14)
% p('d', params, params.amin + params.bmin)
% cur_sum = 0;
% for i = 0 : 2 * (params.amax + params.bmax)%params.bmin : params.bmax
%     cur_sum = cur_sum + p('d', params, i);%, 19, 19);
% end
% fprintf('%.10f\n', cur_sum);
% p_b_da = zeros(101, 761, 16);
% for d = 0 : 2 * (params.amax + params.bmax)
%     for a = params.amin : params.amax
%         if (d <= 2 * (a + params.bmax))
%             p_b_da(:, d + 1, a - params.amin + 1) = p2b_ad(a, d, params);
%             if any(isnan(p_b_da(:, d + 1, a - params.amin + 1)))
%                 a
%                 d
%             end
%         end
%     end
% end
[p, b, m, v] = p2b_ad(23, 39, params);
plot(b, p, 'Color', blue1)
hold on;
% plot(c, cumsum(p), 'r')
scatter(m, 0, 'MarkerEdgeColor', blue1)
% m
% v

% [p, c, m, v] = p2a(params);
% m
% v

[p, b, m, v] = p2b(params);
plot(b, p, 'Color', red1)
hold on;
scatter(m, 0, 'MarkerEdgeColor', red1)
m
v

% [p_c, c, m, v] = p2c(params);
% plot(c, p, 'b')
% hold on;
% plot(c, cumsum(p), 'r')
% scatter(m, 0, 'g')
% m
% v

[p, c, m, v] = p2a(params);
m
v

[p, c, m, v] = p2b(params);
m
v

[p_c, c, m, v] = p2c(params);
% plot(c, p, 'b')
% hold on;
% plot(c, cumsum(p), 'r')
% scatter(m, 0, 'g')
% m
% v

% [p, d, m, v] = p2d(params);
% plot(d, p, 'b')
% hold on;
% plot(c, cumsum(p), 'r')
% scatter(m, 0, 'g')
% m
% v
m
v

[p_d, c, m, v] = p2d(params);
% plot(c, p, 'b')
% hold on;
% plot(c, cumsum(p), 'r')
% scatter(m, 0, 'g')
m
v

% [p, c, m, v] = p2c_a(23, params);
% plot(c, p, 'b')
% hold on;
% plot(c, cumsum(p), 'r')
% scatter(m, 0, 'g')
% m
% v

% [p, c, m, v] = p2c_b(300, params);
% plot(c, p, 'b')
% hold on;
% plot(c, cumsum(p), 'r')
% scatter(m, 0, 'g')
% m
% v

xlabel('b')
ylabel('p')
legend('p(b)', 'E[b]', 'p(b|a,d)', 'E[b|a,d]', 'Location', 'SouthEast')
print('p_b_ad_2', '-depsc2', '-r300');
eps2xxx('p_b_ad_2.eps', {'jpeg'}, 'C:\Program Files\gs\gs9.10\bin\gswin64c.exe')