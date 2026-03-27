%%
% Nume si prenume: Ilban Alessandro
%

clearvars
clc

%% Magic numbers (replace with received numbers)
m = 3; 
n = 15; 

%% Process data (fixed, do not modify)
c1 = (1000+n*300)/10000;
c2 = (1.15+2*(m+n/10)/20);
a1 = 2*c2*c1;
a2 = c1;
b0 = (1.2+m+n)/5.5;

rng(m+10*n)
x0_slx = [2*(m/2+rand(1)*m/5); m*(n/20+rand(1)*n/100)];

%% Experiment setup (fixed, do not modify)
Ts = 10*c2/c1/1e4*1.5; % fundamental step size
Tfin = 30*c2/c1; % simulation duration

gain = 10;
umin = 0; umax = gain; % input saturation
ymin = 0; ymax = b0*gain/1.5; % output saturation

whtn_pow_in = 1e-6*5*(((m-1)*8+n/2)/5)/2*6/8; % input white noise power and sampling time
whtn_Ts_in = Ts*3;
whtn_seed_in = 23341+m+2*n;
q_in = (umax-umin)/pow2(10); % input quantizer (DAC)

whtn_pow_out = 1e-5*5*(((m-1)*25+n/2)/5)*6/80*(0.5+0.3*(m-2)); % output white noise power and sampling time
whtn_Ts_out = Ts*5;
whtn_seed_out = 23342-m-2*n;
q_out = (ymax-ymin)/pow2(9); % output quantizer (ADC)

u_op_region = (m/2+n/5)/2; % operating point

%% Input setup (can be changed/replaced/deleted)
u0 = 0;        % fixed
ust = 3;     % must be modified (saturation)
t1 = 10*c2/c1; % recommended 

%% Data acquisition (use t, u, y to perform system identification)
out = sim("ILBAN_Alessandro_circuit_hidraulic_regresie_R2022b.slx");

t = out.tout;
u = out.u;
y = out.y;

plot(t,u,t,y)
shg

%% System identification
i1=4201;
i2=4247;
i3=13001;
i4=13103;

y_0=mean(y(i1:i2));
y_st=mean(y(i3:i4));
u_0=mean(u(i1:i2));
u_st=mean(u(i3:i4));
K=(y_st-y_0)/(u_st-u_0)

%% T1 dominant
i5=6787;
i6=8863;

t_reg=t(i5:i6);
y_reg=log(y_st-y(i5:i6));
figure
plot(t_reg,y_reg)

A_reg=[sum(t_reg.^2),sum(t_reg);
    sum(t_reg),length(t_reg)];
B_reg=[sum(y_reg.*t_reg);
    sum(y_reg)];
theta=inv(A_reg)*B_reg
T1=-1/theta(1)

%% T2 nedominant
i7=6867;
i8=7201;


Ti=t(i8)-t(i7);
T2vec=0.1:0.1:3.5; %domeniul de afisare
Y_functie=T1*T2vec.*log(T2vec)-T2vec*(Ti+T1*log(T1))+T1*Ti;
figure
plot(T2vec,Y_functie)
grid

T2=0.6% la figura 3 iau valoarea lui x pt y=0
K=3.5 %% eu am obtinut K=3.42 si eroarea este 9 asa ca am impus eu K pt rafinare
%% Validare
H=tf(K,conv([T1,1],[T2,1]));
ysim=lsim(H,u,t);
figure
plot(t,u,t,y,t,ysim)


A=[0,1;-1/T1/T2,-(1/T1+1/T2)];
B=[0;K/T1/T2];
C=[1,0];
D=0;
sys=ss(A,B,C,D);
ysim2=lsim(sys,u,t,[y(1),9]); %%conditii initiale (pozitia,viteza) 
figure
plot(t,u,t,y,t,ysim2)

J=1/sqrt(length(t))*norm(y-ysim2)
eMPN=norm(y-ysim2)/norm(y-mean(y))*100 %sub 10
