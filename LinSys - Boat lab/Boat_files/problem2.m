%% 5.2 - Identification of wave spectrum model

%% a
load('wave.mat', 'psi_w');
window = 4096;
fs = 10;
x = psi_w(2,:)*pi/180;
[pxx,f] = pwelch(x,window,[],[],fs);

fig1 = figure(1);
hold on;
plot(f*2*pi, pxx/(2*pi), 'b');
grid on;
xlabel('Frequency [rad/s]');
ylabel('Power [s/rad]');
axis([0 2 0 0.0016]);

%% c
indexmax = find(max(pxx) == pxx);
y_max = pxx(indexmax)/(2*pi);
x_max = f(indexmax)*2*pi;
omega_0 = x_max;

%% d
sigma = sqrt(y_max);
for lambda = 0.14: -0.05: 0.04
    P = (2*sigma*lambda*omega_0.*f).^2 ./ ((omega_0^2 - f.^2).^2 + (2.*f*omega_0*lambda).^2);
    plot(f, P); 
end
legend('PSD estimate', '\lambda = 0.14', '\lambda = 0.09', '\lambda = 0.04');
%%