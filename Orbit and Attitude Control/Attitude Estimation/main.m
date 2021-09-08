%Programmer: Kyle Southam 
%Description: Program will take input of angular velocity vector and
%position vectors, and simulate a star camera

clc; clear;

%Variables
f = 65*10^-3;
r = [-0.1517 -0.9669 0.2050;...
     -0.8397 0.4496 0.3045;...
     -0.0890 -0.5883 0.8037;...
     0.8608 -0.0296 0.5081];
w0 = 1.84*10^-6;
%Part a - Find Rodriguez parameters by numerical integration, then
%converting to dcm, then finding xj and yj
opts = odeset('RelTol',1e-12,'AbsTol',1e-12);
y0 = [0 0 0];
[ta, qa] = ode45(@RPDiffEqt, 0:3600, y0,opts);

%Find DCM from rodriguez
for i = 1:length(qa)
    C = CRP2DCM(qa(i,1), qa(i,2), qa(i,3));
    [B0, B1, B2, B3] = DCM2Quat(C);
    Ca(i,:) = reshape(C, 9, 1);
    Ba(i,:) = [B0 B1 B2 B3];
end

%Finding xj and yj
for i = 1:length(qa)
    for j = 1:4
    C = reshape(Ca(i,:),3,3);
    
    x(j) = -f*(C(1,1)*r(j,1)+C(1,2)*r(j,2)+C(1,3)*r(j,3))/(C(3,1)*r(j,1)+C(3,2)*r(j,2)+C(3,3)*r(j,3));
    y(j) = -f*(C(2,1)*r(j,1)+C(2,2)*r(j,2)+C(2,3)*r(j,3))/(C(3,1)*r(j,1)+C(3,2)*r(j,2)+C(3,3)*r(j,3));
    end
    
xa(i,:) = reshape(x,4,1);
ya(i,:) = reshape(y,4,1);
end

%Random noise
vx = 10^-7*randn(721,4);
vy = 10^-7*randn(721,4);

%Adding measurement and noise
xac = xa + vx;
yac = ya + vy;

%Finding b(j)
for i=1:length(qa)
    for j = 1:4
        b(j,:) = 1/sqrt(xac(i,j)^2+yac(i,j)^2+f^2)*[-xac(i,j);-yac(i,j);f];
        CBNr(j,:) = reshape(Ca(i,:),3,[])*r(j,:)';
    end
    CBNra(i,1:12) = reshape(CBNr, 12, 1);
    ba(i,1:12) = reshape(b, 12, 1);
    ea1(i) = norm(ba(i,1:3) - CBNra(i,1:3));
    ea2(i) = norm(ba(i,4:6) - CBNra(i,4:6));
    ea3(i) = norm(ba(i,7:9) - CBNra(i,7:9));
    ea4(i) = norm(ba(i,10:12) - CBNra(i,10:12));
end

%Plot norm
figure(1)
plot(0:5:3600, [ea1; ea2; ea3; ea4]);
title('Time History of Project Error (Part a)');
xlabel('Time(s)');
ylabel('Position(m)');
legend('Star 1', 'Star 2', 'Star 3', 'Star 4');

%Part B - using OLAE algorithm to compute estimated rodriguez parameters

for i=1:length(qa)
    b1 = reshape(ba(i,1:3),3,1);
    b2 = reshape(ba(i,4:6),3,1);
    b3 = reshape(ba(i,7:9),3,1);
    b4 = reshape(ba(i,10:12),3,1);
    n1 = r(1,:)';
    n2 = r(2,:)';
    n3 = r(3,:)';
    n4 = r(4,:)';
    
    s1 = b1+n1; 
    s2 = b2+n2;
    s3 = b3+n3;
    s4 = b4+n4;
    
    d1 = b1-n1;
    d2 = b2-n2;
    d3 = b3-n3;
    d4 = b4-n4;
    
    d = [d1; d2; d3; d4];
    S1 = [TildeMatrix(s1); TildeMatrix(s2); TildeMatrix(s3); TildeMatrix(s4)];
    W = eye(3*4);
    
    qb(i,:) = inv(S1'*S1)*S1'*d;
end

%Plot time history of estimate rodriguez parameters and true parameters
figure(2)
plot(0:5:3600, [qa(:,1) qa(:,2) qa(:,3)]);
title('Time History of True Rodriguez Parameters (Part b)');
xlabel('Time(s)');
ylabel('Rodriguez Parameter');
legend('q1', 'q2', 'q3');

figure(3)
plot(0:5:3600, [qb(:,1) qb(:,2) qb(:,3)]);
title('Time History of Estimated Rodriguez Parameters (Part b)');
xlabel('Time(s)');
ylabel('Rodriguez Parameter');
legend('q1', 'q2', 'q3');

%Part C - Find estimated direction cosine matrix
for i = 1:length(qb)
    CBN = CRP2DCM(qb(i,1), qb(i,2), qb(i,3));
    dC = CBN*reshape(Ca(i,:),3,3)';
    [q1(i), q2(i), q3(i)] = DCM2CRP(dC);
    qc(i,:) = reshape([q1(i), q2(i), q3(i)],3,1);
end

figure(4)
plot(0:5:3600, [qc(:,1) qc(:,2) qc(:,3)]);
title('Time History of Error Rodriguez Parameters (Part c)');
xlabel('Time(s)');
ylabel('Rodriguez Parameter');
legend('q1', 'q2', 'q3');

%Part D - Finding estimated Quaternion
for i=1:length(qa)
    b1 = reshape(ba(i,1:3),3,1);
    b2= reshape(ba(i,4:6),3,1);
    b3= reshape(ba(i,7:9),3,1);
    b4= reshape(ba(i,10:12),3,1);
    n1 = r(1,:)';
    n2 = r(2,:)';
    n3 = r(3,:)';
    n4 = r(4,:)';
    
    B = b1*n1'+b2*n2'+b3*n3'+b4*n4';
    S = B+B';
    
    sigma = trace(B);
    Z = [B(2,3)-B(3,2); B(3,1)-B(1,3);B(1,2)-B(2,1)];
    K = [[sigma, Z'];[Z, S-sigma*eye(3)]];
    
    [eigenve, eigenva] = eig(K);
    Beta = -eigenve(:,end);
    B0 = Beta(1);
    B1 = Beta(2);
    B2 = Beta(3);
    B3 = Beta(4);
    
    Bd(i,:) = [B0 B1 B2 B3];
end

%Plot time history of estimate Quaternion and true parameters
figure(5)
plot(0:5:3600, [Ba(:,1) Ba(:,2) Ba(:,3) Ba(:,4)]);
title('Time History of True Quaternion (Part d)');
xlabel('Time(s)');
ylabel('Quaternions');
legend('B0', 'B1', 'B2', 'B3');

figure(6)
plot(0:5:3600, [Bd(:,1) Bd(:,2) Bd(:,3) Bd(:,4)]);
title('Time History of Estimated Quaternion (Part d)');
xlabel('Time(s)');
ylabel('Quaternion');
legend('B0', 'B1', 'B2', 'B3');

%Part e - Compute error DCM from quaternion
for i = 1:length(qb)
    CBN = Quat2DCM(Bd(i,1), Bd(i,2), Bd(i,3), Bd(i,4));
    dCe = CBN*reshape(Ca(i,:),3,3)';
    [B0, B1, B2, B3] = DCM2Quat(dCe);
    Be(i,:) = [B0 B1 B2 B3];
end

%Quaternion multiplication
for i =1:length(qb)
    dBe(i,:) = quatmultiply(Bd(i,:), Ba(i,:));
end

figure(7)
plot(0:5:3600, [Be(:,1) Be(:,2) Be(:,3) Be(:,4)]);
title('Time History of Error Quaternion through DCM (Part e)');
xlabel('Time(s)');
ylabel('Quaternions');
legend('B0', 'B1', 'B2', 'B3');

figure(8)
plot(0:5:3600, [dBe(:,1) dBe(:,2) dBe(:,3) dBe(:,4)]);
title('Time History of error Quaternion through Quaternion Multiplication (Part e)');
xlabel('Time(s)');
ylabel('Quaternion');
legend('B0', 'B1', 'B2', 'B3');
