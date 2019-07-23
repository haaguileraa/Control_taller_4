clear
clc
A = [0 1; 88.158 0];
B = [ 0; 4.3742];
C = [  1 0];
D = 0;

%sistema en lazo abierto es la representacion de estado
sisla = ss(A,B,C,D);
%debido a su integrador va a crecer linealmente con el tiempo
tr= 1;
%polos_controlador
polos_con = [-9.2 -9.6];
K = place(A,B, polos_con);


Alc=A-B*K
sistemaLC=ss(Alc,B,C,D);
f=1/dcgain(sistemaLC)
sistemaLC=f*sistemaLC;


%% Diseño del observador

ra=rank(A)
W0=[C;C*A;];
rw0=rank(W0)  %ra=rw0 entonces es observable

%necesito que sea mucho mas rapido
polos_obs = polos_con*10;
L=place(A',C',polos_obs);
Ltrans= L';

%con el Controlador y el Estimador
ACE = [A -B*K; Ltrans*C A-Ltrans*C-B*K];
BCE = [B;B];
CCE = [C zeros(size(C))];
%

%figure(3)
%step(sislcce)
%grid on

%5 grados 
x0 = [5*pi/180  0];
val_init= [0 0 0 0]; %valores iniciales del observador

t = linspace(0,10,10000);
u=ones(size(t));

y=lsim(sistemaLC, u,t,x0);

sislcce = ss(ACE,BCE,CCE,0);
sislcce = sislcce/dcgain(sislcce);
yc= lsim(sislcce, u, t , val_init);

figure(1)
plot (t,y,t,yc)
legend ('y(t)', 'yc(t)')
grid on

