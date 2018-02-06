%% 5.4 - Observability

%% Constants
K = 0.175;
T = 88.697;
omega_0 = 0.782330201821677;
lambda = 0.09;
sigma = 0.038525441820137;
K_omega = 2 * lambda * omega_0 * sigma;

%% a
A = [         0                 1 0    0    0; 
     -omega_0^2 -2*lambda*omega_0 0    0    0;
              0                 0 0    1    0;
              0                 0 0 -1/T -K/T;
              0                 0 0    0    0];
B = [0 0 0 K/T 0]';
C = [0 1 1 0 0];
E = [0 0; K_omega 0; 0 0; 0 0; 0 1];

%% b
A_1 = [0 1; 0 -1/T];
C_1 = [1 0];
O_1 = obsv(A_1,C_1);
rank(O_1);

%% c
A_2 = [0 1 0; 0 -1/T -K/T; 0 0 0];
C_2 = [1 0 0];
O_2 = obsv(A_2,C_2);
rank(O_2);

%% d
A_3 = [         0                 1 0    0;
       -omega_0^2 -2*lambda*omega_0 0    0;
                0                 0 0    1;
                0                 0 0 -1/T];
C_3 = [0 1 1 0];
O_3 = obsv(A_3,C_3);
rank(O_3);

%% e
A_4 = [         0                 1 0    0    0; 
       -omega_0^2 -2*lambda*omega_0 0    0    0; 
                0                 0 0    1    0; 
                0                 0 0 -1/T -K/T; 
                0                 0 0    0    0];
C_4 = [0 1 1 0 0];
O_4 = obsv(A_4,C_4);
rank(O_4);

%%