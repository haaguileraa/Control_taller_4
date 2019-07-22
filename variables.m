%% Controlador Variables de estado
clear
clc

A = [0 1 0 0; 0 -0.5452 -6.2896 0; 0 0 0 1; 0 3.7793 88.158 0];
B = [0; -0.63102; 0; 4.3742];
C = [0 1 0 0];
D = 0;

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




%%
[r,p,k] = residue(num1,den1)

x1 = tf(r(1), [ 1 -p(1)] )
x2 = tf(r(2), [ 1 -p(2)] );
x3 = tf(r(3), [ 1 -p(3)] );
x4 = tf(r(4), [ 1 -p(4)] );

xx = x1 + x2 +x3+x4









%%
n=size(A);
I=eye(n(1));
%s=tf('s');
%kp1-kpn
syms kp1 kp2 kp3 kp4 s
Kj = [kp1 kp2 kp3 kp4];
eqn1 = det(s*I-A+B*Kj);%== 0 
eqn2=simplify(eqn1)
grado_pol=polynomialDegree(eqn2,s);
coefic=coeffs(eqn2,s)

%%
kp1 = vpasolve(eqn1==0,kp1)
kp2 = vpasolve(eqn1==0,kp2)
kp3 = vpasolve(eqn1==0,kp3)
kp4 = vpasolve(eqn1==0,kp4)
%%
raices = root(eqn1,s);

kp1=root(eqn1,s,kp1)

kp2=raices(2);
kp3=raices(3);
kp4=raices(4);



