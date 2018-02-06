%% 5.5 - Discrete Kalman filter

%% Constants
simTime = 500;
K = 0.175;
T = 88.697;
omega_0 = 0.782330201821677;
lambda = 0.09;
sigma = 0.038525441820137;
K_omega = 2 * lambda * omega_0 * sigma;
load('wave.mat', 'psi_w');
psi_r = 30;

%% PD-controller
omega_c = 0.1;
phase_margin = 50*pi/180;
T_f = 1/ (tan(phase_margin)*omega_c);
T_d = T;
K_pd = omega_c*sqrt(1+(T_f*omega_c)^2)/K;
H_pd = tf([K_pd*T_d K_pd], [T_f 1]);

%% a
A = [         0                 1 0    0    0; 
     -omega_0^2 -2*lambda*omega_0 0    0    0;
              0                 0 0    1    0;
              0                 0 0 -1/T -K/T;
              0                 0 0    0    0];
B = [0 0 0 K/T 0]';
C = [0 1 1 0 0];
D = 1;
E = [0 0; K_omega 0; 0 0; 0 0; 0 1];

Ts = 1/10; % 10 Hz
[A_d, B_d] = c2d(A, B, Ts);
[A_d, E_d] = c2d(A, E, Ts);
C_d = C;
D_d = D;

%% b
sim('ship_5_5_b', [0 simTime]);
fig1 = figure(1);
x1 = ship.time;
y1 = ship.signals.values * pi/180;
plot(x1, y1, 'b');
grid on;
xlabel('Time [s]');
ylabel('Angle [rad]');
V_rad = var(y1);

%% c
Q = diag([30 10^(-6)]);
P_0 = diag([1 0.013 pi^2 1 2.5*10^(-4)]);
R_rad = V_rad/Ts;
X_0 = [0 0 0 0 0]';
kalmanFilter = struct('A_d', A_d, 'B_d', B_d, 'C_d', C_d, 'E_d', E_d, 'Q', Q, 'P_0', P_0, 'R_rad', R_rad, 'X_0', X_0);

%% d
sim('ship_5_5_d', [0 simTime]);
fig2 = figure(2);
x2 = ship.time;
y2 = ship.signals.values;
x3 = rudder.time;
y3 = rudder.signals.values;
x4 = bias_estimate.time;
y4 = bias_estimate.signals.values;
hold on;
plot([0 simTime],[psi_r psi_r],'k--');
plot(x2, y2, 'b');
plot(x3, y3, 'r');
plot(x4, y4, 'c');
grid on;
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('$\psi_r$', '$\psi$', '$\delta$', '$\hat{b}$');
set(legend,'Interpreter','latex');

%% e
sim('ship_5_5_e', [0 simTime]);
fig3 = figure(3);
x5 = ship.time;
y5 = ship.signals.values;
x6 = rudder.time;
y6 = rudder.signals.values;
x7 = bias_estimate.time;
y7 = bias_estimate.signals.values;
x8 = ship_estimate.time;
y8 = ship_estimate.signals.values;
hold on;
plot([0 simTime],[psi_r psi_r],'k--');
plot(x5, y5, 'b');
plot(x6, y6, 'r');
plot(x7, y7, 'c');
plot(x8, y8, 'g');
grid on;
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('$\psi_r$', '$\psi$', '$\delta$', '$\hat{b}$', '$\hat{\psi}$');
set(legend,'Interpreter','latex');

fig4 = figure(4);
x9 = wave.time;
y9 = wave.signals.values;
x10 = wave_estimate.time;
y10 = wave_estimate.signals.values;
hold on;
plot(x9, y9, 'b');
plot(x10, y10, 'r');
grid on;
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('$\psi_\omega$', '$\hat{\psi}_\omega$');
set(legend,'Interpreter','latex');

%% Printing simulink
% print('-depsc','-s','ship_5_5_b');
% print('-depsc','-s','ship_5_5_c');
% print('-depsc','-s','ship_5_5_d');
% print('-depsc','-s','ship_5_5_e');
%%