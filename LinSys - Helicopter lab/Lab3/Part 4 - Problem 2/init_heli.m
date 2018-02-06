% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert høsten 2006 av Jostein Bakkeheim
% Oppdatert høsten 2008 av Arnfinn Aas Eielsen
% Oppdatert høsten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring


%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = 1;
Joystick_gain_y = -1;


%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]

% Våre verdier
V_measured = 6.4;
k_f = ((2* m_p * g * l_h) - (m_c * g * l_c))/(V_measured * l_h);
L_1 = l_p * k_f;
L_2 = (m_c * g * l_c) - (2 * m_p * g * l_h);
L_3 = k_f * l_h;
L_4 = -k_f * l_h;
J_p = 2 * m_p * l_p * l_p;
J_e = (m_c * l_c * l_c) + (2 * m_p * l_h * l_h);
J_lambda = (m_c * l_c * l_c) + (2 * m_p * (l_h * l_h + l_p * l_p));
V_s = -L_2 / L_3;
K_1 = L_1 / J_p;
K_2 = L_3 / J_e;
K_3 = L_4 * V_s / J_lambda;

k_pp = 4;
k_pd = sqrt(4 * k_pp / K_1);
k_rp = -1.5;

DegToRad = pi/180;

% Estimator
A = [0 1 0 0 0 0; 0 0 0 0 0 0; 0 0 0 1 0 0; 0 0 0 0 0 0; 0 0 0 0 0 1; K_3 0 0 0 0 0];
B = [0 0; 0 K_1; 0 0; K_2 0; 0 0; 0 0];
R = [0.2 0; 0 0.2];
C = [1 0 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0];

% LQR
A_LQR = [0 1 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 1 0 0 0 0; 0 0 1 0 0];
B_LQR = [0 0; 0 K_1; K_2 0; 0 0; 0 0];
Q_LQR = [20 0 0 0 0; 0 2 0 0 0; 0 0 16 0 0; 0 0 0 1 0; 0 0 0 0 1];
R_LQR = [0.2 0; 0 0.2];
C_LQR = [1 0 0 0 0; 0 0 1 0 0];
K_LQR = lqr(A_LQR, B_LQR, Q_LQR, R_LQR);

A_LQR_r = A_LQR(1:3,1:3);
B_LQR_r = B_LQR(1:3,:);
C_LQR_r = C_LQR(:,1:3);
K_LQR_r = K_LQR(:,1:3);

P_LQR = inv(C_LQR_r*inv(B_LQR_r*K_LQR_r-A_LQR_r)*B_LQR_r);

%Ob = obsv(A, C);
%rank_Ob = rank(Ob)

Poles = [-30 + 1i*50 -40 + 1i*30 -50 + 1i*10 -30 - 1i*50 -40 - 1i*30 -50 - 1i*10];
L = place(A', C', Poles)';

% Kommandoer
% print('-dpdf','-s','Model') printer simulink som pdf

