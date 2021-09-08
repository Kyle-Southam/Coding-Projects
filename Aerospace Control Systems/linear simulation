%Programmer: Kyle Southam
%Assignment: to simulate the response of a linear system to arbitrary inputs

clc, clear, close all;

%Variables
m = 1;
b = 1;
k = 10;

A = 1/m;
B = [1 b/m k/m];

%Transfer function
G = tf(A,B);

%Time
t = 0:0.1:20;

%Unit impulse
u1 = zeros(length(t), 1);
u1(1) = 1;
y1 = lsim(G,u1,t);

%Step
u2 = ones(length(t), 1);
y2 = lsim(G,u2,t);

figure(1);
plot(t, y1, t, y2);
legend('Impulse', 'Step');
title('Impulse and Step Response');

%sin funct
omega = [1 sqrt(2) sqrt(k/m)];
for i=1:3
    u3(:, i) = sin(omega(i)*t);
    y3(:, i) = lsim(G,u3(:,i),t);
end

figure(2);
plot(t, y3(:,1), t, y3(:,2), t, y3(:,3))
legend('O = 1', 'O = sqrt(2)', 'O = sqrt(k/m)');
title('Sinusoidal Response');
