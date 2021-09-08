%Programmer: Kyle Southam
%Description: This program will use fourier stabiltiy analysis to analyze
%the stability of certain methods

clc, clear, close all

%Problem 1: Amplitude vs Phase and phase error
%Part a
C = [0.1 0.2 0.5 1 2 5 10];
sig1 = @(x) 1-C.*(1-cos(x))-1i*C.*sin(x);

x = linspace(0,pi,100);
 for i=1:length(x)
     amp1(i,:) = abs(sig1(x(i)));
 end
 
figure(1)
plot(x', [amp1(:,1) amp1(:,2) amp1(:,3) amp1(:,4) amp1(:,5) amp1(:,6) amp1(:,7)])
title('Phase vs. Amplitude, Varying CFL')
legend('C = 0', 'C = 0.333', 'C = 0.667', 'C = 1', 'C = 1.333', 'C = 1.667', 'C = 2')
xlabel('Phase, k*dx')
ylabel('Amplitude')

er = @(x) -C.*x - angle(sig1(x));
 for i=1:length(x)
     er1(i,:) = er(x(i));
 end
 
figure(2)
plot(x', [er1(:,1) er1(:,2) er1(:,3) er1(:,4) er1(:,5) er1(:,6) er1(:,7)])
title('Phase vs. Phase error, Second Iteration, Varying Fourier')
legend('C = 0.1', 'C = 0.2', 'C = 0.5', 'C = 1', 'C = 2', 'C = 5', 'C = 10')
xlabel('Phase, k*dx')
ylabel('Phase error')

%Part b
sig2 = @(x) 1-C.*(1i*sin(x));

 for i=1:length(x)
     amp2(i,:) = abs(sig2(x(i)));
 end
 
figure(3)
plot(x', [amp2(:,1) amp2(:,2) amp2(:,3) amp2(:,4) amp2(:,5) amp2(:,6) amp2(:,7)])
title('Phase vs. Amplitude, part b')
legend('C = 0.1', 'C = 0.2', 'C = 0.5', 'C = 1', 'C = 2', 'C = 5', 'C = 10')
xlabel('Phase, k*dx')
ylabel('Amplitude')

er = @(x) -C.*x - angle(sig2(x));
 for i=1:length(x)
     er2(i,:) = er(x(i));
 end
 
figure(4)
plot(x', [er2(:,1) er2(:,2) er2(:,3) er2(:,4) er2(:,5) er2(:,6) er2(:,7)])
title('Phase vs. Phase error, part b')
legend('C = 0.1', 'C = 0.2', 'C = 0.5', 'C = 1', 'C = 2', 'C = 5', 'C = 10')
xlabel('Phase, k*dx')
ylabel('Phase error')

%Part c
sig3 = @(x) 1./((1+C.*1i*sin(x)).^2);

 for i=1:length(x)
     amp3(i,:) = abs(sig3(x(i)));
 end
 
figure(5)
plot(x', [amp3(:,1) amp3(:,2) amp3(:,3) amp3(:,4) amp3(:,5) amp3(:,6) amp3(:,7)])
title('Phase vs. Amplitude, part c')
legend('C = 0.1', 'C = 0.2', 'C = 0.5', 'C = 1', 'C = 2', 'C = 5', 'C = 10')
xlabel('Phase, k*dx')
ylabel('Amplitude')

er = @(x) -C.*x - angle(sig3(x));
 for i=1:length(x)
     er3(i,:) = er(x(i));
 end
 
figure(6)
plot(x', [er3(:,1) er3(:,2) er3(:,3) er3(:,4) er3(:,5) er3(:,6) er3(:,7)])
title('Phase vs. Phase error, part c')
legend('C = 0.1', 'C = 0.2', 'C = 0.5', 'C = 1', 'C = 2', 'C = 5', 'C = 10')
xlabel('Phase, k*dx')
ylabel('Phase error')

%Problem 1 - Bonus
sige = @(x) 1./((1+C.*(1-(cos(x)-1i*sin(x)))).^2);

 for i=1:length(x)
     ampe(i,:) = abs(sige(x(i)));
 end
 
figure(7)
plot(x', [ampe(:,1) ampe(:,2) ampe(:,3) ampe(:,4) ampe(:,5) ampe(:,6) ampe(:,7)])
title('Phase vs. Amplitude, extra credit')
legend('C = 0.1', 'C = 0.2', 'C = 0.5', 'C = 1', 'C = 2', 'C = 5', 'C = 10')
xlabel('Phase, k*dx')
ylabel('Amplitude')

er = @(x) -C.*x - angle(sige(x));
 for i=1:length(x)
     ere(i,:) = er(x(i));
 end
 
figure(8)
plot(x', [ere(:,1) ere(:,2) ere(:,3) ere(:,4) ere(:,5) ere(:,6) ere(:,7)])
title('Phase vs. Phase error, extra credit')
legend('C = 0.1', 'C = 0.2', 'C = 0.5', 'C = 1', 'C = 2', 'C = 5', 'C = 10')
xlabel('Phase, k*dx')
ylabel('Phase error')

%%Problem 2 - Integration of ODE
%Euler-Cauchy method
dx = 0.2;
x1 = 0:dx:1;
f = @(x) x^3-3*x^2+6*x+6*exp(-x)-6;

for i=1:length(x1)
    ft(i) = f(x1(i));
end

f1 = @(x,u) x^3-u;
u0 = 0;

u1 = Euler(f1,x1,u0);
u2 = EulerImproved(f1,x1,u0);
u3 = rk4(f1,x1,u0);

%Plotting all functs vs. real solution
figure(9)
plot(x1, [ft; u1; u2; u3]);
title('Various Methods vs. exact solution')
legend('Real Soln', 'Euler-Cauchy', 'Improved Euler', 'Runge Kutta')
xlabel('x value')
ylabel('function value')

%Plotting error
err1 = abs(ft - u1);
err2 = abs(ft - u2);
err3 = abs(ft - u3);

figure(10)
plot(x1, [err1; err2; err3]);
title('Error from methods vs. solution')
legend('Euler-Cauchy', 'Improved Euler', 'Runge Kutta')
xlabel('x value')
ylabel('Error')

%The error seen here shows that rk4 is 4th order accurate, improved euler
%is 2nd order accurate, and euler-cauchy is 1st order accurate

function u = Euler(f,x,u0)
dx = x(2)-x(1);
u = zeros(size(x));
u(1) = u0;
n = length(u);

for i=1:n-1
    u(i+1) = u(i) + dx*f(x(i),u(i));
end
end

function u = EulerImproved(f,x,u0)
dx = x(2)-x(1);
u = zeros(size(x));
u(1) = u0;
n = length(u);

for i=1:n-1
    u(i+1) = u(i) + dx*f(x(i),u(i));
    u(i+1) = u(i) + dx/2*(f(x(i),u(i)+f(x(i+1),u(i+1))));
end
end

function u = rk4(f,x,u0)
dx = x(2)-x(1);
u = zeros(size(x));
u(1) = u0;
n = length(u);

for i=1:n-1
    ai = dx*f(x(i),u(i));
    bi = dx*f(x(i)+dx/2,u(i)+ai/2);
    ci = dx*f(x(i)+dx/2,u(i)+bi/2);
    di = dx*f(x(i)+dx,u(i)+ci);
    
    u(i+1) = u(i)+1/6*(ai+2*bi+2*ci+di);
end
end
