%Programmer: Kyle Southam
%Description: This program will use taylor series to approximate a
%derivative of a function and implement a numerical solution for a 1D heat
%equation

clc, clear, close all

%Problem 1: Taylor series approximation
f = @(x) sin(x);
x = pi/4;
h = logspace(-1, -15);

for i=1:length(h)
   dfa(i) = backdiff(f, x, h(i));
   dfb(i) = centdiff(f, x, h(i));
   dfc(i) = twoptcentdiff(f, x, h(i));
   dfd(i) = imagdiff(f,x,h(i));
end

df = cos(pi/4);

for i=1:length(h)
    erra(i) = abs(df - dfa(i));
    errb(i) = abs(df - dfb(i));
    errc(i) = abs(df - dfc(i));
    errd(i) = abs(df - dfd(i));
end

figure(1)
loglog(h, [erra; errb; errc; errd])
title('Error Using Different FD Schemes')
legend('Backwards Diff.', 'Cent. Diff', '2-pt Cent. Diff', 'Complex Step')
xlabel('Step Size, h')
ylabel('Error')
set(gca,'Xdir','reverse')

%The error in each case is good until you reach a certain step size, which
%the error starts to go back up. The backwards diff is has consistant
%reduction in error until about step sizes around 10^-7, the central diff
%has better error reduction until step sizes of about 10^-5, and the 2-pt
%central diff has very good error reduction until step siszes about 10^-3.
%
%The complex step has great error reduction and does not go back up at any
%point.

%%Problem 2 - Solving heat equation
alpha = 0.25;
L = 1;
t1 = 1;

%Case 1: 100 time steps and 10 space steps
u = zeros(10, 100);
u(1,:) = 1;

xs = 10;
dx = L/xs;
x = linspace(0,1,xs);

ts = 100;
dt = t1/ts;

for i=2:xs-1
    for m=1:ts-1
        u(i,m+1) = u(i,m) + alpha*dt/(dx^2)*(u(i+1,m)-2*u(i,m)+u(i-1,m));
    end
end

figure(2)
plot(x,[u(:,10) u(:,50) u(:,100)])
title('Solution of u(x,t) for different points in time (Case 1)')
legend('t = 0.1', 't = 0.5', 't = 1')
xlabel('Spacial position')
ylabel('Temperature')

%Case 2: 100 time steps and 20 space steps
u2 = zeros(20, 100);
u2(1,:) = 1;

xs = 20;
dx = L/xs;
x = linspace(0,1,xs);

ts = 100;
dt = t1/ts;

for i=2:xs-1
    for m=1:ts-1
        u2(i,m+1) = u2(i,m) + alpha*dt/(dx^2)*(u2(i+1,m)-2*u2(i,m)+u2(i-1,m));
    end
end

figure(3)
plot(x,[u2(:,10) u2(:,50) u2(:,100)])
title('Solution of u(x,t) for different points in time (Case 2)')
legend('t = 0.1', 't = 0.5', 't = 1')
xlabel('Spacial position')
ylabel('Temperature')

%The solution for the first case converges, while the second case diverges
%and blows up. The difference is due to the stability of the equation that
%we are using which is based on alpha*dt/(dx^2) needing to be under a
%certain value to remain stable. The stability is broken down in the second
%case by dx being smaller. 

%%Functions
function df = backdiff(f, x, h)
df = (f(x)-f(x-h))/h;
end

function df = centdiff(f, x, h)
df = (f(x+h)-f(x-h))/(2*h);
end

function df = twoptcentdiff(f, x, h)
df = (-f(x+2*h)+8*f(x+h)-8*f(x-h)+f(x-2*h))/(12*h);
end

function df = imagdiff(f,x,h)
df = imag(f(x+1i*h))/h;
end
