%Programmer: Kyle Southam 
%Description: Program will take input of initial conditions and determine
%position vector and velocity, plus orbit elements of a satellite in orbit
%also uses F and G solutions method for comparison

clc; clear; close all;

%Variables
mu = 0.39860*10^6; %mu of earth, km^3/s^2
y0 = [5.4209*10^-13 7.6414*10^3 4.4118*10^3 -8.7634 0 0];

opts = odeset('RelTol',1e-12,'AbsTol',1e-12);

[ta, ya] = ode45(@NewtonsLaw, 0:1:172800, y0, opts);

p1 = ya(:, 1);
p2 = ya(:, 2);
p3 = ya(:, 3);
p = [p1 p2 p3]';

v1 = ya(:, 4); 
v2 = ya(:, 5);
v3 = ya(:, 6);
v = [v1 v2 v3]';

for i = 1:length(ta)
    E(i) = sqrt(sum(v(:,i).^2))^2/2 - mu/(sqrt(sum(p(:,i).^2)));
    ha(:,i) = cross(p(:,i), v(:,i));
    h(i) = sqrt(sum(ha(:,i).^2));
end

%Plotting stuff
figure(1)
plot(ta, p);
title('Position Vector Plot')
xlabel('Time(s)');
ylabel('Position (km)');
legend('x','y','z');

figure(2)
plot(ta, v);
title('Velocity Vector Plot')
xlabel('Time(s)');
ylabel('Position (km/s)');
legend('x','y','z');

figure(3)
plot(ta, E);
title('Specific Energy Plot')
xlabel('Time(s)');
ylabel('Energy (km^2/s^2)');

figure(4)
plot(ta, ha);
title('Angular Momentum Plot')
xlabel('Time(s)');
ylabel('Angular Momentum (km^2/s)');
legend('x','y','z');

figure(5)
plot3(p1, p2, p3);
title('3D Orbit Plot')

%Finding orbit elements
tb = 1:60:length(ta);
for i=1:1:length(tb)
    [a(i), e(i), O(i), I(i), w(i), M(i), E0(i), f(i)] = RV2OE(p(:,tb(i)), v(:,tb(i)));
end

%Plotting
figure(6)
plot(tb,a)
title('Plot of a (Semi-Major Axis)')
xlabel('Time(min)');
ylabel('Semi-Major Axis (km)');

figure(7)
plot(tb,e)
title('Plot of e (Eccentricity)')
xlabel('Time(min)');
ylabel('Eccentricity');

figure(8)
plot(tb,O)
title('Plot of O (Ascending node)')
xlabel('Time(min)');
ylabel('Omega (rad)');

figure(9)
plot(tb,I)
title('Plot of I (Inlination)')
xlabel('Time(min)');
ylabel('I (rad)');

figure(10)
plot(tb,w)
title('Plot of w (Arguement of Periapsis)')
xlabel('Time(min)');
ylabel('W (rad)');

figure(11)
plot(tb,M)
title('Plot of M (Mean Anomaly)')
xlabel('Time(min)');
ylabel('M (rad)');

figure(12)
plot(tb,E0)
title('Plot of E (Eccentric Anomaly)')
xlabel('Time(min)');
ylabel('E (rad)');

figure(13)
plot(tb,f)
title('Plot of f (True Anomaly)')
xlabel('Time(min)');
ylabel('f (rad)');

%Finding r and v from orbit elements
for i=1:1:length(tb)
    [pe(:,i), ve(:,i)] = OE2RV(a(i), e(i), O(i), I(i), w(i), M(i));
end

figure(14)
plot(tb, pe);
title('Position Vector Plot from OE')
xlabel('Time(min)');
ylabel('Position (km)');
legend('x','y','z');

figure(15)
plot(tb, ve);
title('Velocity Vector Plot from OE')
xlabel('Time(min)');
ylabel('Position (km/s)');
legend('x','y','z');

%Using F and G solution
r0v = [5.4209*10^-13; 7.6414*10^3; 4.4118*10^3];
v0v = [-8.7634; 0; 0];

r0 = sqrt(sum(r0v(:,1).^2));
v0 = sqrt(sum(v0v(:,1).^2));

ad = 2/r0 - v0^2/mu;
ad = 1/ad;

DCMO = [cos(O(1)) sin(O(1)) 0; -sin(O(1)) cos(O(1)) 0; 0 0 1];
DCMI = [1 0 0; 0 cos(I(1)) sin(I(1)); 0 -sin(I(1)) cos(I(1))];
DCMw = [cos(w(1)) sin(w(1)) 0; -sin(w(1)) cos(w(1)) 0; 0 0 1];

DCM = DCMw*DCMI*DCMO;

s0 = dot(r0v,v0v)/sqrt(mu);

for i=1:1:length(M)
    Eh = E0(i) - E0(1);
    
    r = ad + (r0-ad)*cos(Eh) + sqrt(ad)*s0*sin(Eh);
    
    F = 1 - (ad/(r0)*(1-cos(Eh)));
    G = ad^(3/2)/sqrt(mu)*(sin(Eh) - e(1)*(sin(E0(i))-sin(E0(1))));
    
    Fd = -sqrt(mu*ad)/(r*r0)*sin(Eh);
    Gd = 1 - ad/r*(1-cos(Eh));
    
    rd(:,i) = F*r0v + G*v0v;
    vd(:,i) = Fd*r0v + Gd*v0v;
end

figure(16)
plot(tb, rd);
title('Position Vector Plot from F and G Soln.')
xlabel('Time(s)');
ylabel('Position (km)');
legend('x','y','z');

figure(17)
plot(tb, vd);
title('Velocity Vector Plot from F ang G Soln.')
xlabel('Time(s)');
ylabel('Position (km/s)');
legend('x','y','z');
