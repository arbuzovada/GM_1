% CONSTANTS
% global A_MIN A_MAX B_MIN B_MAX P_1 P_2 P_3 N M
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
cur_sum = 0;
for i = params.bmin : params.bmax
    cur_sum = cur_sum + p('b|ad', params, i, 19, 19);
end
cur_sum