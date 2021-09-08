%{
Programmers: Kyle Southam
Description: Program will aid the design of a pitch motion controller for an aircraft with specific EOMs,
this code will calculate the root locus of the system which was then used to view the characteristics of 
a lead compensator and how the different constants of K affect the system.
%}

clc; clear, close all;

%Part 1 - State space form
A = [-0.313 56.7 0 ; -0.0139 -0.426 0 ; 0 56.7 0]; 
B = [0.232 0.0202 0]'; 
C = [0 0 1];
D = 0;

%Part 2
sys = ss(A, B, C, D); %State space model of system

[ystep, t] = step(sys, 60); %This is the unit step response of our system
u = ones(length(t), 1)*0.2; %This is to find our modified unit step response

[b, a] = ss2tf(A, B, C, D); %This converts the stead state model into a form of a transfer function
G = tf(b, a); %This is the open loop transfer function
disp(G);

%Part 3
p = pole(sys); %Poles of the system
z = zero(sys); %Zeros of the system
[z2, p2, k] = tf2zp(b, a); %Poles, zeros, and gain of the system. These solutions match our previous answers, so this is good!
ylsim = lsim(sys, u, t); %Simulated time response of system with unit step function of 0.2 rad
figure(1);
plot(ylsim, t);
title('Open Loop Response vs. Time');
xlabel('Time');
ylabel('Time response');
%The response is linearly growing because the feedback keeps getting fed
%into the equation
%%
%Part 4
K = 1; %Given
H = feedback(G, K); %This is 
H1 = H*0.2;
figure(2);
step(H1, t); %This is the step response of the system
title('Step response of closed loop system');
disp(H1);

%Part 5
b1 = [0; 0; 0.2291; 0.0351]; %Numerator of TF
a1 = conv([1; 0], [1; 0.7390; 2.0668; 0.1756]); %Denominator of TF
[r1, p1, k1] = residue(b1, a1); %This is the residue function used to find the residue and poles

syms s;
F = (r1(1)/(s-p1(1))+(r1(2)/(s-p1(2)))+(r1(3)/(s-p1(3)))); %The residue and poles of the function
th = ilaplace(F); %Inverse laplace to go back to time domain

figure(3);
fplot(th,[0,80]); %Plot is is the same as the previous plot
title('Theta vs. t');
xlabel('Time(s)');
ylabel('Theta (rads)');
%%
%Part 6
rltool(H);
%%
%Part 7
figure(4)
step(CompK2, 50);
title('Theta vs. Time, K=2');
xlabel('Time(s)');
ylabel('Theta(rads)');

%%
figure(5)
step(CompK50, 50);
title('Theta vs. Time, K=50');
xlabel('Time(s)');
ylabel('Theta(rads)');

%%
figure(6)
step(CompK200, 50);
title('Theta vs. Time, K=200');
xlabel('Time(s)');
ylabel('Theta(rads)');
