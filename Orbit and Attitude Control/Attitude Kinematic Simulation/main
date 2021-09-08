%Programmer: Kyle Southam
%Description: Program will take input of angular velocity vector and
%compute DCM, Euler angle, and quaternion

clc; clear;

%Part a - Find DCM CBN by numerically integrating kinematic equations
opts = odeset('RelTol',1e-12,'AbsTol',1e-12);
y0 = eye(3);
[ta, ya] = ode45(@DCMKinematicEqt, 0:0.01:120, y0, opts);

for i=1:length(ya)
    CBN1 = reshape(ya(i,:),3,3);
    y1(i,:) = reshape(CBN1*CBN1'-eye(3),9,1);
end

figure(1)
plot(ta, y1);
title('Orthogonal Constraint violation history of CBN');
xlabel('Time(s)');
ylabel('Angle(Rad)');
legend('DCM(1,1)','DCM(1,2)','DCM(1,3)','DCM(2,1)','DCM(2,2)','DCM(2,3)','DCM(3,1)','DCM(3,2)','DCM(3,3)');

%Part b - estimate dcm using another method and plotting time history
dt1 = 0.01;
w0=20*pi/180;
n = 1;
for i=0:dt1:120
    CBN1 = reshape(ya(n,:),[3,3]);
    if (i == 0)
        CBN2 = eye(3);
    else
        CBN2 = expm(-[0 -w0*cos(0.01*i) 0.01;w0*cos(0.01*i) 0 -w0*sin(0.01*i);-0.01 w0*sin(0.01*i) 0] * dt1) * CBN2;
    end
    dC = CBN1*CBN2';
    e(n) = norm(dC-y0);
    n = n+1;
end

figure(2)
plot(ta, e);
title('Time History Error Comparison of Part a and b with \Delta_{t} = 0.01s');
xlabel('Time(s)');
ylabel('Angle(Rad)');
legend('Norm of DCM');

%Part C - Estimation using bigger timestep and plotting error history
dt2 = 1;
[tc, yc1] = ode45(@DCMKinematicEqt, 0:1:120, eye(3), opts);
n = 1;
for i=0:dt2:120
    CBN1c = reshape(yc1(n,:),3,3);
    if (i == 0)
        CBN2c = eye(3);
    else
        CBN2c = expm(-[0 -w0*cos(0.01*i) 0.01;w0*cos(0.01*i) 0 -w0*sin(0.01*i);-0.01 w0*sin(0.01*i) 0] * dt2) * CBN2c;
    end
    ec(n) = norm(CBN1c*CBN2c'-eye(3));
    n = n + 1;
end

figure(3)
plot(tc, ec);
title('Time History Error Comparison for Part C with \Delta_{t} = 1s');
xlabel('Time(s)');
ylabel('Angle(Rad)');
legend('Norm of DCM');

%Part D - Finding euler angle and plotting time history
n = 1;
for i=0:dt1:120
    CBN1 = reshape(ya(n,:),3,3);
    [th1d, th2d, th3d] = DCM2EA313(CBN1, i);
    yd(n,:) = [th1d th2d th3d];
    n = n+1;
end

figure(4)
plot(ta, yd)
title('Time History of Euler Angle For 3-1-3 Rotation for Part D');
xlabel('Time(s)');
ylabel('Angle(Rad)');
legend('\theta_{1}','\theta_{2}','\theta_{3}');

%Part E - Finding euler angle by numerical integration
[te, ye] = ode45(@(t,x) DCM2EAIntegrate(t,x), [0 120], [0 eps 0], opts);
yewrap = wrapToPi(ye);

figure(5)
plot(te, yewrap);
title('Time History of Numerically Integrated Euler Angle For 3-1-3 Rotation for Part E');
xlabel('Time(s)');
ylabel('Angle(Rad)');
legend('\theta_{1}','\theta_{2}','\theta_{3}');

%Part F - Finding Quaternion from DCM
n = 1;
for i=0:dt1:120
    CBN1 = reshape(ya(n,:),3,3);
    [B0, B1, B2, B3] = DCM2Quat(CBN1, i);
    ef(n) = (B0^2+B1^2+B2^2+B3^2)-1;
    yf(n,:) = [B0 B1 B2 B3];
    n = n+1;
end

figure(6)
plot(ta, yf)
title('Time History of Quaternion for Part F');
xlabel('Time(s)');
ylabel('\beta_{i} for i=0,1,2,3');
legend('\beta_{0}','\beta_{1}','\beta_{2}','\beta_{3}');

figure(7)
plot(ta, ef)
title('Time History of Quaternion Constraint Violation for Part F');
xlabel('Time(s)');
ylabel('Error Magnitude');

%Part g - Finding Quaternion using state transition matrix
n = 1;
Bg = [1; 0; 0; 0];
for i=0:dt1:120
    if i == 0
        Bg = [1; 0; 0; 0];
    else
    Bg = expm((1/2)*[0 -w0*sin(0.01*i) -0.01 -w0*cos(0.01*i);...
              w0*sin(0.01*i) 0 w0*cos(0.01*i) -0.01;...
              0.01 -w0*cos(0.01*i) 0 w0*sin(0.01*i);...
              w0*cos(0.01*i) 0.01 -w0*sin(0.01*i) 0] * dt1) * Bg;
    end
    eg(n) = Bg(1)^2+Bg(2)^2+Bg(3)^2+Bg(4)^2-1;
    yg(n,:) = Bg;
    n = n+1;
end

figure(8)
plot(ta, yg)
title('Time History of Quaternion for Part G with \Delta_{t} = 0.01s');
xlabel('Time(s)');
ylabel('\beta_{i} for i=0,1,2,3');
legend('\beta_{0}','\beta_{1}','\beta_{2}','\beta_{3}');

figure(9)
plot(ta, eg)
title('Time History of Quaternion Constraint Violation for Part G');
xlabel('Time(s)');
ylabel('Error Magnitude');
%Part h - Converting Quaternion to Rodriguez parameters
for n=1:length(yf)
    [q1, q2, q3] = Quat2CRP(yg(n,1), yg(n,2), yg(n,3), yg(n,4));
    yh(n,:) = [q1 q2 q3];
end

figure(10)
plot(ta, yh)
title('Time History of Rodriguez Parameters for Part H');
xlabel('Time(s)');
ylabel('q(i) for i=1,2,3');
legend('q(1)','q(2)','q(3)');

%Part i - Converting Rodriguez parameters to DCM

for n=1:length(yh)
    CBNi = CRP2DCM(yh(n,1), yh(n,2), yh(n,3));
    ei(n, :) = reshape(CBNi*CBNi'-eye(3),9,1);
end

figure(11)
plot(ta, ei);
title('Orthogonal Constraint violation history of Part i');
xlabel('Time(s)');
ylabel('Angle(Rad)');
legend('DCM(1,1)','DCM(1,2)','DCM(1,3)','DCM(2,1)','DCM(2,2)','DCM(2,3)','DCM(3,1)','DCM(3,2)','DCM(3,3)');

