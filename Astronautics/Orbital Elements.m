%Kyle Southam
%This program will calculate certain orbital parameters with a specific input

clear, clc;

%Setting up variables
r = 10859.1; %km
rdot = 2.484; %km/s
rthetadot = 6.502; %km/s
mu = 3.986*10^5; %Constant - mu (km^3/s^2)
tnew = 15000; %seconds
relerr = 10^-4;
abserr = 10^-6;

%Finding magnitude of velocity
R = [r; 0; 0];
V = [rdot; rthetadot; 0];
v = sqrt(rdot^2+rthetadot^2);

%Calculating orbital energy and displaying it
E = (v^2/2)-(mu/r);
fprintf('The value of orbital energy is: %f km^2/sec^2\n\n', E);

%Calculating angular momentum and displaying it
h = cross(R, V);
disp('The angular momentum vector is (km^2/sec): ');
disp(h);
H = h(3);

%Calculating semi major axis and displaying it
a = -mu/(2*E);
fprintf('\nThe semi major axis a is: %f km\n', a);

%Calculating and displaying eccentricity
p = H^2/mu;
e = sqrt(1+(2*p*E)/mu);
fprintf('\nThe eccentricity of the orbit is: %f\n', e);

%Calculating initial true anomaly and displaying it
thetai = acosd(((p/r)-1)/e);
fprintf('\nThe initial true anomaly is: %f degrees\n', thetai);

%Calculating initial eccenric anomaly and displaying it
Ei = acos(-(r/a-1)/e);
fprintf('\nThe intial eccentric anomaly is: %f radians\n', Ei);

%Calculating time of periapsis passage and displaying it
M = E-e*sin(E);
To = -(M/sqrt(mu/(a^2)));
fprintf('\nThe time of periapsis passage is: %f seconds\n', To);

%Calculating eccentric anomaly at t=15000 sec and displaying it
M1 = sqrt(mu/(a^3))*(tnew - To);
Eold = M1;
Eerr = 1;
Eabs = 1;

while ((abs(Eerr) >= relerr) || (abs(Eabs) >= abserr))
    Enew = Eold - ((Eold-e*sin(Eold)-M1)/(1-e*cos(Eold)));
    Eerr = Enew - Eold;
    Eabs = (Enew - Eold)/Eold;
    Eold = Enew;
end

fprintf('\nThe eccentric anomaly at t = 15000 is: %f radians\n', Enew);

%Calculating true anomaly at t = 15000 sec and displaying it
thetanew = 2*atan(sqrt((1+e)/(1-e))*tan(Enew/2));
thetanewa = rad2deg(thetanew);
thetanewd = 360+thetanewa;
fprintf('\nThe true anomaly at t = 15000 sec is: %f radians, or %f degrees\n', thetanew, thetanewd);








