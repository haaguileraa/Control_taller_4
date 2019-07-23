A=[0,0,0;0,-2,0;0,0,-1];
B=[1;1;-2];
C=[1 1 1];
polos=[-2.5 -20 -25];
K_matlab=place(A,B,polos);
Alc_matlab=A-B*K_matlab;
sys_matlab=ss(Alc_matlab,B,C,0);
sys_matlab=sys_matlab/dcgain(sys_matlab);
step(sys_matlab)

%%
W0=[C;C*A;C*A*A];
rank(W0)
polos_obs=[-30 -35 -40]; % polos del observador
L=place(A',C',polos_obs)';  
x0=[2 -3 4]; % valores iniciales estados
t=[0:0.01:10];
u= ones(length(t),1);
Alc=[A -B*K_matlab; L*C A-L*C-B*K_matlab]; 
Blc=[B;B]; 
Clc=[C zeros(size(C))]; 
Dlc=0; 
y=lsim(sys_matlab,u,t,x0);
o0=[0 0 0 0 0 0]; % valores iniciales observador
planta_lc=ss(Alc,Blc,Clc,Dlc);
planta_lc=planta_lc/dcgain(planta_lc);
yo=lsim(planta_lc,u,t,o0); 
plot(t,y,'--k',t,yo,'b','LineWidth',2) 
legend('y(t)','yo(t)'), grid on 
sys_lc=tf(planta_lc)