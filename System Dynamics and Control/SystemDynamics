%{
Programmer: Kyle Southam 
Description: Program will compute phase plots and equilibrium points of
a DC Motor with 2 arms attached that is in motion
%}

clc; clear;

%linear - analytical, non-linear - numeric
%Start of Part C
t=linspace(0,10,500);
x0 = 50*pi/180*randn(2,50);
g=9.81; %m/s^2
L1=0.5; %m
L2=0.5; %m
O=(1/2)*sqrt(g/L2);
A=@(t,x)[x(2); O^2*sin(x(1))*cos(x(1))-g/L2*sin(x(1))];

for n = 1:length(x0)
    xn = x0(:,n);
options=odeset('reltol',1e-12,'abstol',1e-12);
[t,x]=ode45(A,t,xn,options);

figure (1)
plot (x(:,1),x(:,2))
hold on
set(gca,'fontsize',20);
    xlabel('Phi');ylabel('Phidot');
end

%End of Part C

%Start of Part D
t=linspace(0,10,500);
x0 = [5*pi/180;5*pi/180];
g=9.81; %m/s^2
L1=0.5; %m
L2=0.5; %m
O=(1/2)*sqrt(g/L2);
A=@(t,x)[x(2); O^2*sin(x(1))*cos(x(1))-g/L2*sin(x(1))];

figure (2)
plot(t,x(:,2),t,x(:,1))
    set(gca,'fontsize',20);
    xlabel('time');ylabel('phidot and phi');
[t,x2]=ode45(A,t,x0,options);

% figure (5)
% plot (x2(:,1),x2(:,2))
% hold on
% set(gca,'fontsize',20);
%     xlabel('x');ylabel('xdot');
    
%Analytical Solution
x0=[5*pi/180;5*pi/180];
A1 = [0 1; -((g/L2)-O^2) 0];
[vec,lam]=eig(A1);
lam=diag(lam);
coeff=inv(vec)*x0;

% Finding coefficients for eigenvector participation
for ct=1:length(t)
    x_anal(:,ct)= coeff(1)*vec(:,1)*exp(lam(1)*t(ct))+coeff(2)*vec(:,2)*exp(lam(2)*t(ct));
    if imag(x_anal(:,ct))<=1e-10    
        x_anal(:,ct)=real(x_anal(:,ct));
        end
end

figure (3)
    subplot 211
    plot(t,x2(:,1),t,x_anal(1,:))
    set(gca,'fontsize',20);
    xlabel('time');ylabel('phi');
    legend({'numerical','analytical'},'Location','southwest')

    subplot 212
    plot(t,x2(:,2),t,x_anal(2,:))
    set(gca,'fontsize',20);
    xlabel('time');ylabel('phidot');
%End of Part D

%%
%Start of Part E
t=linspace(0,10,500);
x0 = 50*pi/180*randn(2,50);
g=9.81; %m/s^2
L1=0.5; %m
L2=0.5; %m
O2=(2)*sqrt(g/L2);

A=@(t,x)[x(2); O2^2*sin(x(1))*cos(x(1))-g/L2*sin(x(1))];

for n = 1:length(x0)
    xn = x0(:,n);
options=odeset('reltol',1e-12,'abstol',1e-12);
[t,x]=ode45(A,t,xn,options);

figure (4)
plot (x(:,1),x(:,2))
hold on
set(gca,'fontsize',20);
    xlabel('phi');ylabel('phidot');
end
%End of E

%Start of F
O2 = 2*sqrt(g/L2);
x0 = [((5*pi)/180)+acos(g/(L2*(O2^2)));(5*pi)/180];
A3=[0 1; -1*((O2^2)-(g^2/((L2^2)*(O2)))) 0];
%A3=[0 1; -((g/L2)-O2^2) 0];
[vec,lam]=eig(A3);
lam=diag(lam);
coeff=inv(vec)*x0;
% Finding coefficients for eigenvector participation
for ct=1:length(t)
    x_anal3(:,ct)= coeff(1)*vec(:,1)*exp(lam(1)*t(ct))+coeff(2)*vec(:,2)*exp(lam(2)*t(ct));
    if imag(x_anal3(:,ct))<=1e-10    
        x_anal3(:,ct)=real(x_anal3(:,ct));
        end
end
figure (5)
plot(t,x(:,2),t,x(:,1))
    set(gca,'fontsize',20);
    xlabel('time');ylabel('phidot and phi');

A=@(t,x)[x(2); -1*O2^2*sin(x(1))*cos(x(1))-g/L2*sin(x(1))];
[t,x2]=ode45(A,t,x0,options);
figure (6)
    subplot 211
    plot(t,x2(:,1),t,x_anal3(1,:))
    set(gca,'fontsize',20);
    xlabel('time');ylabel('phi');
    legend({'numerical','analytical'},'Location','southwest')

    subplot 212
    plot(t,x2(:,2),t,x_anal3(2,:))
    set(gca,'fontsize',20);
    xlabel('time');ylabel('phidot');
