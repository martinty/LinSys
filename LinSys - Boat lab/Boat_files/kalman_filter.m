function X_hat  = fcn(ship, rudder, kalmanFilter)

persistent P_k X_k init_flag R_rad Q A_d B_d C_d E_d;

if isempty(init_flag)
    init_flag = 1;
    P_k = kalmanFilter.P_0;
    X_k = kalmanFilter.X_0;
    R_rad = kalmanFilter.R_rad;
    Q = kalmanFilter.Q;
    A_d = kalmanFilter.A_d;
    B_d = kalmanFilter.B_d;
    C_d = kalmanFilter.C_d;
    E_d = kalmanFilter.E_d;
end

%(1) Kalman gain
K_k = P_k*C_d'*inv(C_d*P_k*C_d'+R_rad);
%(2) Update estimate
X_hat = X_k + K_k*(ship-C_d*X_k);
%(3) Update covariance
P_k = (eye(5)-K_k*C_d)*P_k*(eye(5)-K_k*C_d)' + K_k*R_rad*K_k';
%(4) Project ahead
X_k = A_d*X_hat + B_d*rudder; 
P_k = A_d*P_k*A_d'+E_d*Q*E_d';

end

% Gammel funksjon
% function X_hat  = fcn(ship, rudder)
% 
% persistent P_k X_k init_flag R_rad Q A_d B_d C_d E_d;
% 
% if isempty(init_flag)
%     init_flag = 1;
%     
%     P_k = diag([1 0.013 pi^2 1 2.5*10^(-4)]);
%     X_k = [0 0 0 0 0]';
%     
%     R_rad = 6.273663271350977e-06;
%     Q = diag([30 10^(-6)]);
%     
%     A_d = [0.9970 0.0992  0      0         0;
%           -0.0607 0.9830  0      0         0;
%                 0      0  1 0.0999 -9.861e-6;
%                 0      0  0 0.9989 -1.972e-4;
%                 0      0  0      0         1];
%     B_d = [0 0 9.8613e-6 1.9719e-4 0]';
%     C_d = [0 1 1 0 0];
%     E_d = [2.6985e-5        0;
%            5.3816e-4        0;
%                 0  -3.2874e-7;
%                 0  -9.8613e-6;
%                 0         0.1];
% end
% 
% %(1) Kalman gain
% K_k = P_k*C_d'*inv(C_d*P_k*C_d'+R_rad);
% %(2) Update estimate
% X_hat = X_k + K_k*(ship-C_d*X_k);
% %(3) Update covariance
% P_k = (eye(5)-K_k*C_d)*P_k*(eye(5)-K_k*C_d)' + K_k*R_rad*K_k';
% %(4) Project ahead
% X_k = A_d*X_hat + B_d*rudder; 
% P_k = A_d*P_k*A_d'+E_d*Q*E_d';
% 
% end