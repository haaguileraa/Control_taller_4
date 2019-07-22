%% Controlador Variables de estado
clear
clc

A = [0 1 0 0; 0 -0.5452 -6.2896 0; 0 0 0 1; 0 3.7793 88.158 0];
B = [0; -0.63102; 0; 4.3742];
C = [0 1 0 0];
D = 0;

sis = ss(A,B,C,D);
polos = [-9.1 -9.2 -9.4 -9.6];
K=place(A,B,polos); %acker
Alc=A-B*K
sistemaLC=ss(Alc,B,C,D);

%f=1/dcgain(sistemaLC) %no se utiliza porque el límite tiende a cero y
%el precompensador sería f=inf
%sistemaLCn=f*sistemaLC;
Ts=minreal(zpk(sistemaLC)) %se comprueba
figure(1)
step(sistemaLC)
grid on

%%
C_ang = [0 0 1 0];  %revisar

tsys = ss(Alc,B,C_ang,D);

figure(2)
step(sistemaLC);
hold on;
step(tsys);
hold off;
grid on
legend('v(t)', '\theta(t)');

