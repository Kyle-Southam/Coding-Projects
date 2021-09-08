%Programmer: Kyle Southam
%Description: This program will implement a FTCS and upwind scheme for the conservative form of the
%nonlinear viscous Burgers equation

clc, clear, close all

%Problem: Viscous Burgers Eqt
dx = 0.02;
dt = pi/1000;

x = -1:dx:1;
t = 0:dt:pi;

v = 10^-2;

u = @(x) sin(pi*x)^2;
f = @(x) 1/2*(x)^2;

U = zeros(length(x), length(t));
U2 = zeros(length(x), length(t));

%Initial condition
for i=1:length(x)
    U(i,1) = u(x(i));
    U2(i,1) = u(x(i));
end

%Starting loop for FTCS
for j=1:length(t)-1
    for i=2:length(x)-1
        U(i,j+1) = U(i,j) + v*dt/(dx^2)*(U(i+1,j)-2*U(i,j)+U(i-1,j)) - dt/(2*dx)*(f(U(i+1,j))-f(U(i-1,j)));
    end
    U(1,j+1) = U(1,j) + v*dt/(dx^2)*(U(2,j)-2*U(1,j)+U(length(x),j)) - dt/(2*dx)*(f(U(2,j))-f(U(length(x),j)));
    U(length(x),j+1) = U(length(x),j) + v*dt/(dx^2)*(U(1,j)-2*U(length(x),j)+U(length(x)-1,j)) - dt/(2*dx)*(f(U(1,j))-f(U(length(x)-1,j)));
end

%Loop for upwind scheme
for j=1:length(t)-1
    for i=2:length(x)-1
        U2(i,j+1) = U2(i,j) + v*dt/(dx^2)*(U2(i+1,j)-2*U2(i,j)+U2(i-1,j)) - dt/(dx)*(f(U2(i,j))-f(U2(i-1,j)));
    end
    U2(1,j+1) = U2(1,j) + v*dt/(dx^2)*(U2(2,j)-2*U2(1,j)+U2(length(x),j)) - dt/(dx)*(f(U2(1,j))-f(U2(length(x),j)));
    U2(length(x),j+1) = U2(length(x),j) + v*dt/(dx^2)*(U2(1,j)-2*U2(length(x),j)+U2(length(x)-1,j)) - dt/(dx)*(f(U2(length(x),j))-f(U2(length(x)-1,j)));
end

%Graphs
figure(1)
subplot(2,3,1);
plot(x, [U(:,201) U2(:,201)])
title('Solution at t = pi/5s, v=10^-2')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')
ylim([0 1]);

subplot(2,3,2);
plot(x, [U(:,401) U2(:,401)])
title('Solution at t = 2pi/5s, v=10^-2')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')
ylim([0 1]);

subplot(2,3,3);
plot(x, [U(:,601) U2(:,601)])
title('Solution at t = 3pi/5s, v=10^-2')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')
ylim([0 1]);

subplot(2,3,4);
plot(x, [U(:,801) U2(:,801)])
title('Solution at t = 4pi/5s, v=10^-2')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')
ylim([0 1]);

subplot(2,3,5);
plot(x, [U(:,1001) U2(:,1001)])
title('Solution at t = pi s, v=10^-2')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')
ylim([0 1]);

%The solution seems to tend to stop oscillating and converge to a final value.
%The upwind scheme also tends to oscillate slightly less then the FTCS
%scheme. I believe the difference occurs due to on scheme looking at
%forward points while the other is looking at previous. 

%%
%v = 10^-1
clc, clear
dx = 0.02;
dt = pi/1000;

x = -1:dx:1;
t = 0:dt:pi;

v = 10^-1;

u = @(x) sin(pi*x)^2;
f = @(x) 1/2*(x)^2;

U = zeros(length(x), length(t));
U2 = zeros(length(x), length(t));

%Initial condition
for i=1:length(x)
    U(i,1) = u(x(i));
    U2(i,1) = u(x(i));
end

%Starting loop for FTCS
for j=1:length(t)-1
    for i=2:length(x)-1
        U(i,j+1) = U(i,j) + v*dt/(dx^2)*(U(i+1,j)-2*U(i,j)+U(i-1,j)) - dt/(2*dx)*(f(U(i+1,j))-f(U(i-1,j)));
    end
    U(1,j+1) = U(1,j) + v*dt/(dx^2)*(U(2,j)-2*U(1,j)+U(length(x),j)) - dt/(2*dx)*(f(U(2,j))-f(U(length(x),j)));
    U(length(x),j+1) = U(length(x),j) + v*dt/(dx^2)*(U(1,j)-2*U(length(x),j)+U(length(x)-1,j)) - dt/(2*dx)*(f(U(1,j))-f(U(length(x)-1,j)));
end

%Loop for upwind scheme
for j=1:length(t)-1
    for i=2:length(x)-1
        U2(i,j+1) = U2(i,j) + v*dt/(dx^2)*(U2(i+1,j)-2*U2(i,j)+U2(i-1,j)) - dt/(dx)*(f(U2(i,j))-f(U2(i-1,j)));
    end
    U2(1,j+1) = U2(1,j) + v*dt/(dx^2)*(U2(2,j)-2*U2(1,j)+U2(length(x),j)) - dt/(dx)*(f(U2(1,j))-f(U2(length(x),j)));
    U2(length(x),j+1) = U2(length(x),j) + v*dt/(dx^2)*(U2(1,j)-2*U2(length(x),j)+U2(length(x)-1,j)) - dt/(dx)*(f(U2(length(x),j))-f(U2(length(x)-1,j)));
end

%Graphs
figure(2)
subplot(2,3,1);
plot(x, [U(:,201) U2(:,201)])
title('Solution at t = pi/5s, v=10^-1')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')


subplot(2,3,2);
plot(x, [U(:,401) U2(:,401)])
title('Solution at t = 2pi/5s, v=10^-1')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')


subplot(2,3,3);
plot(x, [U(:,601) U2(:,601)])
title('Solution at t = 3pi/5s, v=10^-1')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')


subplot(2,3,4);
plot(x, [U(:,801) U2(:,801)])
title('Solution at t = 4pi/5s, v=10^-1')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')


subplot(2,3,5);
plot(x, [U(:,1001) U2(:,1001)])
title('Solution at t = pi s, v=10^-1')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')

%It appears that letting viscosity be equal to 10^-1 blows up the solution.
%This happens due to the stability condition for the schemes. Note that the plots
%appear blank because the solution is blown up.

%%
%v = 10^-3
clc, clear
dx = 0.02;
dt = pi/1000;

x = -1:dx:1;
t = 0:dt:pi;

v = 10^-3;

u = @(x) sin(pi*x)^2;
f = @(x) 1/2*(x)^2;

U = zeros(length(x), length(t));
U2 = zeros(length(x), length(t));

%Initial condition
for i=1:length(x)
    U(i,1) = u(x(i));
    U2(i,1) = u(x(i));
end

%Starting loop for FTCS
for j=1:length(t)-1
    for i=2:length(x)-1
        U(i,j+1) = U(i,j) + v*dt/(dx^2)*(U(i+1,j)-2*U(i,j)+U(i-1,j)) - dt/(2*dx)*(f(U(i+1,j))-f(U(i-1,j)));
    end
    U(1,j+1) = U(1,j) + v*dt/(dx^2)*(U(2,j)-2*U(1,j)+U(length(x),j)) - dt/(2*dx)*(f(U(2,j))-f(U(length(x),j)));
    U(length(x),j+1) = U(length(x),j) + v*dt/(dx^2)*(U(1,j)-2*U(length(x),j)+U(length(x)-1,j)) - dt/(2*dx)*(f(U(1,j))-f(U(length(x)-1,j)));
end

%Loop for upwind scheme
for j=1:length(t)-1
    for i=2:length(x)-1
        U2(i,j+1) = U2(i,j) + v*dt/(dx^2)*(U2(i+1,j)-2*U2(i,j)+U2(i-1,j)) - dt/(dx)*(f(U2(i,j))-f(U2(i-1,j)));
    end
    U2(1,j+1) = U2(1,j) + v*dt/(dx^2)*(U2(2,j)-2*U2(1,j)+U2(length(x),j)) - dt/(dx)*(f(U2(1,j))-f(U2(length(x),j)));
    U2(length(x),j+1) = U2(length(x),j) + v*dt/(dx^2)*(U2(1,j)-2*U2(length(x),j)+U2(length(x)-1,j)) - dt/(dx)*(f(U2(length(x),j))-f(U2(length(x)-1,j)));
end

%Graphs
figure(3)
subplot(2,3,1);
plot(x, [U(:,201) U2(:,201)])
title('Solution at t = pi/5s, v=10^-3')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')


subplot(2,3,2);
plot(x, [U(:,401) U2(:,401)])
title('Solution at t = 2pi/5s, v=10^-3')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')


subplot(2,3,3);
plot(x, [U(:,601) U2(:,601)])
title('Solution at t = 3pi/5s, v=10^-3')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')


subplot(2,3,4);
plot(x, [U(:,801) U2(:,801)])
title('Solution at t = 4pi/5s, v=10^-3')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')


subplot(2,3,5);
plot(x, [U(:,1001) U2(:,1001)])
title('Solution at t = pi s, v=10^-3')
legend('FTCS', 'Upwind')
xlabel('Distance, x')
ylabel('Solution, u')

%It appears that letting viscosity be equal to 10^-3 breaks the stability condition
%for the FTCS scheme, but does not break it for the Upwind scheme. 
