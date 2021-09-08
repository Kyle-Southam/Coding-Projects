%Programmer: Kyle Southam
%Description: This program uses relaxation method to relax a 1D Poisson Equation

clc, clear, close all

%Problem 1: Relaxation Function to 1D Poisson Equation
a = 0; 
b = 1;
ua = 1;
ub = 3;

N = 257; %Number of points

h = (b-a)/N; %Step

x = linspace(a,b,N);
dx = x(2)-x(1);
u = zeros(1,N);

phi = @(x) 20*pi*x^3;
phid = @(x) 60*pi*x^2;
phidd = @(x) 120*pi*x;

for i=1:length(x)
f(i) = -20+1/2*phidd(x(i))*cos(phi(x(i)))-1/2*(phid(x(i)))^2*sin(phi(x(i)));
end

for i=1:length(x)
    u(i) = 1+2*x(i);
end

for i=1:length(x)
    uexac(i) = 1+12*x(i)-10*x(i)^2+1/2*sin(phi(x(i)));
end

%Iterations: 10
niter = 10;
u_num = relaxation(u,f,h,niter);

figure(1)
plot(x,[uexac; u_num])
title('Exact/Numerical Solution of u(x)(Case 1)')
legend('uexac', 'unumerical')
xlabel('Position')
ylabel('Function')

err1 = norm(uexac-u_num);

%Iterations: 10^2
niter = 10^2;
u_num = relaxation(u,f,h,niter);

figure(2)
plot(x,[uexac; u_num])
title('Exact/Numerical Solution of u(x)(Case 2)')
legend('uexac', 'unumerical')
xlabel('Position')
ylabel('Function')

err2 = norm(uexac-u_num);

%Iterations: 10^3
niter = 10^3;
u_num = relaxation(u,f,h,niter);

figure(3)
plot(x,[uexac; u_num])
title('Exact/Numerical Solution of u(x)(Case 3)')
legend('uexac', 'unumerical')
xlabel('Position')
ylabel('Function')

err3 = norm(uexac-u_num);

%Iterations: 10^4
niter = 10^4;
u_num = relaxation(u,f,h,niter);

figure(4)
plot(x,[uexac; u_num])
title('Exact/Numerical Solution of u(x)(Case 4)')
legend('uexac', 'unumerical')
xlabel('Position')
ylabel('Function')

err4 = norm(uexac-u_num);

%Iterations: 10^5
niter = 10^5;
u_num = relaxation(u,f,h,niter);

figure(5)
plot(x,[uexac; u_num])
title('Exact/Numerical Solution of u(x)(Case 5)')
legend('uexac', 'unumerical')
xlabel('Position')
ylabel('Function')

err5 = norm(uexac-u_num);

%Error comparison
err = [err1 err2 err3 err4 err5];
num = logspace(1,5,5);

figure(6)
semilogx(num,err)
title('Error vs. Number of Iterations')
xlabel('Number of iterations')
ylabel('Error')

%The method's error reduces as the number of iterations increases. The
%method converges to a solution with larger iterations.

%%
%Problem 1: Bonus
h = (b-a)/N;
h = h^2/(dx^2);

for i=1:5
    niter = 10^(i);
    u_num = relaxation2(u,f,h,niter);
    errec1(i) = norm(uexac-u_num);
end

figure(7)
semilogx(num,errec1)
title('Error vs. Number of Iterations, BONUS')
xlabel('Number of iterations')
ylabel('Error')
%I tried to use the Gauss-Seidel method for this one. I seemed to have
%implemented it wrong, since it should converge much quicker than Jacobi. 

%%
%Problem 2 - Multigrid problem
h = (b-a)/N;
hmax = 0.5;
v = 3;
relax = 1;
%First V-cycle
um1 = multigrid(u,f,h,hmax,v,relax);

figure(8)
plot(x,[uexac; um1'])
title('Exact/Numerical Solution of u(x)(Multigrid)')
legend('uexac', 'unumerical')
xlabel('Position')
ylabel('Function')

%It appears 1 relaxation iteration occured. 

%Using 10 V-cycles
for i = 1:10
u = multigrid(u,f,h,hmax,v,relax);
err(i) = norm(uexac-u);
end

figure(9)
plot(1:10,err)
title('Error vs. Number of relaxation iterations (Multigrid)')
xlabel('Relaxation iteration')
ylabel('Error')

%Convergence is very slow for this relaxation.

%%
%Problem 2: Bonus
hmax = 0.5;
relax = [0.5 1 1.5 2];
v = [1000 2500 5000 10000];

for i=1:4
umec = multigrid(u,f,h,hmax,v(i),relax(i));
errec2(i) = norm(uexac-umec);
end

figure(10)
plot([1000 2500 5000 10000],errec2)
title('Error vs. Number of relaxation iterations (BONUS) (Multigrid)')
xlabel('Relaxation iteration')
ylabel('Error')

%It seems as v increases, the error decreases. Changing relaxation factor did not seem
%to change anything, since I did not implement it in my relaxation method.
%It appears that having a very high relaxation iterations per level changed error the most.

%%
%Functions
function u = relaxation2(u_initial,f,h,niter,~)
%This method will be Gauss-Seidel
u = u_initial;
for i=1:niter
    for j=2:length(u_initial)-1
        u(j) = h*(u(j+1)+u(j-1));
    end
end
end

function unew = relaxation(u_initial,f,h,niter,~)
%This method will be Jacobi iteraion
unew = u_initial;
for i=1:niter
    for j=2:length(u_initial)-1
        uold = unew;
        unew(j) = -h^2/2*f(j) + (uold(j+1)+uold(j-1))/2;
    end
end
end

function [x] = multigrid(xinit, b, h, hmax, nu, relax)
% Solves the system Ax = b using a V-cycle multigrid method
%
% Inputs:       
% xinit - length N array representing the initial guess for x
% b     - length N array of the source terms
% h     - scalar spatial step size
% hmax  - scalar coarsest spatial step size
% nu    - scalar number of relaxation iterations per level
% relax - scalar relaxation factor
%
% Output:
% x     - length N array of the approximate solution for x
z = 0;
% Relax the solution at this level
x = relaxation(xinit,b,h,nu,relax);
% Set step size for the next level
hdown = 2*h;
% Check if step size is valid
if hdown < hmax
    % Compute residual
    r = residual(x,b,h);
    % Set b to -r and restrict
    bdown = restriction(-r);
    % Set the initial guess for the error to zero
    xinitdown = zeros(size(bdown));
    % Solve for error on the coarse grid
    [erdown] = multigrid(xinitdown, bdown, hdown, hmax, nu, relax);
    % Prolongate error back to the fine grid
    erup = prolongation(erdown);
    % Apply the correction
    x = x(:) - erup(:);
    % Relax again
    x = relaxation(x,b,h,nu,relax);
end
end

function r = residual(x,b,h)
r = x;

for i=2:length(b)-1
    r(i) = b(i)-1/(h^2)*(x(i+1)-2*x(i)+x(i-1));
end

end

function bdown = restriction(r)
for i=1:length(r)
    if mod(i,2)==0
        
    else
        bdown = r(i);
    end
end
end

function erup = prolongation(erdown)
for i=1:length(erdown)
    if mod(i,2)==0
        erup(i) = 1/2*(erdown(i/2)+erdown((i+1)/2));
    else
        erup(i)=erdown((i+1)/2);
    end
end
end
