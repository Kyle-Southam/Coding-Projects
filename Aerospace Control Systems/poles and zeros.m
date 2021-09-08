% Programmer: Kyle Southam
% Date Done: 9/16/2020
%This program will study the effects of additional poles and zeros

clear, clc, close all;

%Variables
z = 0.5;
t = 0:0.01:10;

%Part 1.1
a = [100 10 1 -1 -10];

for i=1:length(a)
    num = [1/(a(i)*z) 1];
    den = [1 2*z 1];
    H = tf(num,den);
    y(i,:)=step(H,t);
end

figure(1)
plot(t,y)
legend('A = 100','A = 10', 'A = 1', 'A = -1', 'A = -10')
title('Extra Zero Plot')

%Part 1.2
a2 = [100 10 1 0.1];

for i=1:length(a2)
    num = [1];
    den = conv([1/(a2(i)*z) 1], [1 2*z 1]);
    
    H2 = tf(num, den);
    y2(i, :) = step(H2, t);
end

figure(2)
plot(t, y2)
legend('A = 100', 'A = 10', 'A = 1', 'A = 0.1')
title('Extra pole')

%Part 2.3
num = [-30 180];
den = [1 4 13 0];
G = tf(num, den);
figure(3)
impulse(G)
title('Impulse response for 2.3');
