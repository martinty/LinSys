%% 5.3 - Control system design

%% Constants
K = 0.175;
T = 88.697;
simTime = 500;
load('wave.mat', 'psi_w');

%% a
psi_r = 30;
omega_c = 0.1;
phase_margin = 50*pi/180;
T_f = 1/ (tan(phase_margin)*omega_c);
T_d = T;
K_pd = omega_c*sqrt(1+(T_f*omega_c)^2)/K;
H_pd = tf([K_pd*T_d K_pd], [T_f 1]);

%% b
sim('ship_5_3_b', [0 simTime]);
fig1 = figure(1);
x1 = ship.time;
y1 = ship.signals.values;
x2 = rudder.time;
y2 = rudder.signals.values;
hold on;
plot([0 simTime],[psi_r psi_r],'k--');
plot(x1, y1, 'b');
plot(x2, y2, 'r');
grid on;
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('\psi_r', '\psi', '\delta');

%% c
sim('ship_5_3_c', [0 simTime]);
fig2 = figure(2);
x3 = ship.time;
y3 = ship.signals.values;
x4 = rudder.time;
y4 = rudder.signals.values;
hold on; 
plot([0 simTime],[psi_r psi_r],'k--');
plot(x3, y3, 'b');
plot(x4, y4, 'r');
grid on;
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('\psi_r', '\psi', '\delta');

%% d
sim('ship_5_3_d', [0 simTime]);
fig3 = figure(3);
x5 = ship.time;
y5 = ship.signals.values;
x6 = rudder.time;
y6 = rudder.signals.values;
hold on;
plot([0 simTime],[psi_r psi_r],'k--');
plot(x5, y5, 'b');
plot(x6, y6, 'r');
grid on;
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('\psi_r', '\psi', '\delta');

%% Printing simulink
% print('-depsc','-s','ship_5_3_bcd');
%%