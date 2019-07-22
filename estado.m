A = [-1 0 0; 1 -2 0; 0 1 0];
B = [1; 0; 0];
C = [0 0 1];
d = 0;
sisla = ss(A,B,C,d);
polos_con = [-5 -6 -7];
K = place(sisla, polos_con);
T = ss(A-B*K, B, C,0);
f = 1/dcgain(T);
T =f*T;

%diseño observador
polos_obs = [-50 -60 -70];
L = place(A',C',polos_obs);
L=L';

ACE = [A -B*K; L*C A-L*C-B*K];
BCE = [B; B];
CCE = [C 0 0 0];
sislcce = f*ss(ACE,BCE,CCE, 0);
% step(sislcce)

t = linspace(0,1,10000);
u = ones(size(t));
[y,t,x] = lsim(sislcce,u,t,[-.05 -.02 .01 0 0 0] );
plot(t,x(:,1),t,x(:,4))













