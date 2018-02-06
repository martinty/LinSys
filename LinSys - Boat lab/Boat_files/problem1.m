%% 5.1 - Identification of the boat parameters

%% a - Constants
K = 0.175;  % K = 0.1825
T = 88.697;
simTime = 2500;

%% b
omega = 0.005;
sim('ship_5_1_b_disturbances_off', [0 simTime]);
fig1 = figure(1);
x1 = ship.time;
y1 = ship.signals.values;
plot(x1, y1, 'b');
grid on;
xlabel('Time [s]');
ylabel('Angle [deg]');
min_y1 = abs(findpeaks(-y1));
max_y1 = max(y1);
amplitude1 = min((max_y1 - min_y1) / 2);

omega = 0.05;
sim('ship_5_1_b_disturbances_off', [0 simTime]);
fig2 = figure(2);
x2 = ship.time;
y2 = ship.signals.values;
plot(x2, y2, 'b');
grid on;
xlabel('Time [s]');
ylabel('Angle [deg]');
min_y2 = abs(findpeaks(-y2));
max_y2 = max(y2);
amplitude2 = min((max_y2 - min_y2) / 2);

%% c
omega = 0.005;
sim('ship_5_1_c_disturbances_on', [0 simTime]);
fig3 = figure(3);
x3 = ship.time;
y3 = ship.signals.values;
plot(x3, y3, 'r');
grid on;
xlabel('Time [s]');
ylabel('Angle [deg]');

omega = 0.05;
sim('ship_5_1_c_disturbances_on', [0 simTime]);
fig4 = figure(4);
x4 = ship.time;
y4 = ship.signals.values;
plot(x4, y4, 'r');
grid on;
xlabel('Time [s]');
ylabel('Angle [deg]');

%% d
sim('ship_5_1_d', [0 simTime]);
fig5 = figure(5);
x5 = ship.time;
y5 = ship.signals.values;
x6 = model.time;
y6 = model.signals.values;
hold on;
plot(x5, y5, 'b');
plot(x6, y6, 'r');
grid on;
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('Ship', 'Model');

%% Printing simulink
% print('-depsc','-s','ship_5_1_bc');
% print('-depsc','-s','ship_5_1_d');
%%