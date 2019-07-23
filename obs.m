%% Controlador Variables de estado
%% Controlador Variables de estado
clear
clc

A = [0 1 0 0; 0 -0.5452 -6.2896 0; 0 0 0 1; 0 3.7793 88.158 0];
B = [0; -0.63102; 0; 4.3742];
C = [0 1 0 0];
D = 0;

%% Controlable y observable?
nn= rank(A)
wc = [B A*B A*A*B A*A*A*B]
nwc=rank(wc)

w0 = [C; C*A; C*A*A; C*A*A*A]
nw0=rank(w0)

%%
segway = ss(A,B,C,D);
[num1, den1] = ss2tf(A,B,C,D);
G = tf(num1,den1);

polos = [-9 -9.2 -9.4 -9.6];


k = place(A,B,polos); %acker

An = A - B*k;

nsys = ss(An,B,C,D);

C2 = [0 0 1 0];

tsys = ss(An,B,C2,D);
nnsys = feedback(nsys,1);
tnsys = feedback(tsys,1);

figure(2)
step(nnsys);
hold on;
step(tnsys);
hold off;

legend('v(t)', '\theta(t)');
