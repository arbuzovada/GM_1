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
[p, c, m, v] = p2b_ad(19, 33, params);
plot([params.bmin : params.bmax], p, 'b')
hold on;
plot([params.bmin : params.bmax], c, 'r')
scatter(m, 0, 'g')
v