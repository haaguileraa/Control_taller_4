%% Controlador PI vectorial
clear
clc

A = [-0.5452 -6.2896 0;  0 0 1; 3.7793 88.158 0];
B = [ -0.63102; 0; 4.3742];
C = [ 1 0 0];
D = 0;

sis = ss(A,B,C,D);
polos = [-9.2 -9.4 -9.6 -15];

Ala = [A zeros(3, 1); -C 0]
Bla = [B; 0]
Kt = place(Ala, Bla, polos)
k = Kt(1 : end -1)
ka=Kt(4) ;
Ai=[A-B*k -B*ka;-C 0]
Bi=[zeros(3,1); 1]
Ci=[C 0]
Di=0
sislc = ss(Ai, Bi, Ci, Di)
step(sislc)



C_ang = [ 0 1 0];  
C_angi=[C_ang 0]
tsys = ss(Ai, Bi, C_angi, Di)

figure(2)
step(sislc);
hold on;
step(tsys,'r--');
hold off;
grid on
legend('v(t)', '\theta(t)');



%%
%pasos: 1. Diseño el controlador K, 2. diseño L dp


g=tf([10 1],[1 7 7 -15])
sis=ss(g)
A=sis.a

B=sis.b
C=sis.c
d=sis.d
polos = [-1 -30 -40 -50]
Ala = [A zeros(3, 1); -C 0]
Bla = [B; 0]
Kt = place(Ala, Bla, polos)
k = Kt(1 : end -1)
ka=Kt(4) ;
Ai=[A-B*k -B*ka;-C 0]
Bi=[zeros(3,1); 1]
Ci=[C 0]
Di=0
sislc = ss(Ai, Bi, Ci, Di)
step(sislc)