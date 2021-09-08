%Kyle Southam
%This program will calculate certain orbital elements (also convert from ECI to perifocal to EPI) after an 
%input of position and velocity vectors,
%as well as initial time and desired final time, with tolerance parameters

clear, clc;

%Setting up variables
r(1, 1) = input('Please input i coordinate of r vector (ECI): '); %r vector in km
r(2, 1) = input('Please input j coordinate of r vector (ECI): ');
r(3, 1) = input('Please input k coordinate of r vector (ECI): ');

v(1, 1) = input('\nPlease input i coordinate of v vector (ECI): '); %v vector in km/s
v(2, 1) = input('Please input j coordinate of v vector (ECI): ');
v(3, 1) = input('Please input k coordinate of v vector (ECI): ');

ti = input('\nPlease input initial time (seconds): '); %seconds
tf = input('Please input later time (seconds): '); 

reltol = input('\nPlease input relative tolerance: '); %tolerances
abstol = input('Please input absolute tolerance: ');
disp(' ');

%Displaying the inputs
disp('The r vector (in km): ');
disp(r);

disp('The v vector (in km/s): ');
disp(v);

fprintf('The initial time is: %f seconds\n', ti);
fprintf('\nThe later time is: %f seconds\n', tf);

fprintf('\nThe relative tolerance is: %f\n', reltol);
fprintf('\nThe absolute tolerance is: %f\n', abstol);

%Constants
mu = 3.986*10^5; %Constant - (km^3/s^2)
i = [1; 0; 0]; %unit vector - i
j = [0; 1; 0]; %unit vector - j
k = [0; 0; 1]; %unit vector - k

%Calculating magnitudes and angular momentum
R = sqrt(r(1,1)^2+r(2,1)^2+r(3,1)^2); %Magnitude of r
V = sqrt(v(1,1)^2+v(2,1)^2+v(3,1)^2); %Magnitude of v
h = cross(r, v); %angular momentum
H = sqrt(h(1,1)^2+h(2,1)^2+h(3,1)^2); %magnitude of angular momentum
p = H^2/mu;
evect = (cross(v, h)/mu) - (r/R); %eccentricity vector
Evect = sqrt(evect(1)^2+evect(2)^2+evect(3)^2); %magnitude of eccentricity vector

%Calculating orbital elements
E = (V^2/2)-(mu/R); %total energy
a = -mu/(2*E); %semi major axis
e = sqrt(1+(2*p*E)/mu); %eccentricity
I = acos(dot(h,k)/H); %Inclination

n = cross(k, h); %node vector
n = n/sqrt(n(1)^2+n(2)^2+n(3)^2); %Unit node vector
N = sqrt(n(1)^2+n(2)^2+n(3)^2); %magnitude of node vector

if (dot(i, n) > 0) %finding Right Ascension of the Ascending Node
    omega = atan(dot(j,n)/dot(i,n));
else
    omega = atan(dot(j,n)/dot(i,n)) + 3.1415;
end

if (dot(evect, k) > 0) %Finding the argument of periapsis
    w = acos(dot(n,evect)/(Evect));
else
    w = -acos(dot(n,evect)/(Evect));
end

%Reporting all the orbital elements
fprintf('\nThe semi major axis is: %f km\n', a);
fprintf('The eccentricity of the orbit is: %f\n', e);
fprintf('The inclination of the orbit is: %f radians\n', I);
fprintf('The Right Ascension of the Ascending Node is: %f radians\n', omega);
fprintf('The argument of periapsis is: %f radians\n\n', w);

DCMO = ThirdRotation(omega); %DCM for omega angle
DCMI = FirstRotation(I); %DCM for inclination angle
DCMW = ThirdRotation(w); %DCM for w angle

%Calculating the DCM that transforms from ECI to perifocal and displaying
%it
CEP = DCMW*DCMI*DCMO;

disp('The DCM that transforms from ECI to perifocal is: ');
disp(CEP);

%Finding initial position and velocity in perifocal, then displaying them
peri_ri = CEP*r;
peri_vi = CEP*v;

disp('The initial perifocal position vector is (in km): ')
disp(peri_ri);
disp('The initial perifocal velocity vector is (in km/s): ');
disp(peri_vi);

%Finding initial true anomaly and eccentric anomaly and displaying
thetai = acosd(((p/R)-1)/e);
fprintf('\nThe initial true anomaly is: %f degrees\n', thetai);

Ei = acos(-(R/a-1)/e);
fprintf('The intial eccentric anomaly is: %f radians\n', Ei);

%Finding time of periapsis passage and displaying it
M = E-e*sin(E);
To = -(M/sqrt(mu/(a^2)));
fprintf('\nThe time of periapsis passage is: %f seconds\n', To);

%Calculating eccentric anomaly at t2 and displaying it
M2 = sqrt(mu/(a^3))*(tf - To);
Eold = M2;
Eerr = 1;
Eabs = 1;

while ((abs(Eerr) >= reltol) || (abs(Eabs) >= abstol))
    Enew = Eold - ((Eold-e*sin(Eold)-M2)/(1-e*cos(Eold)));
    Eerr = Enew - Eold;
    Eabs = (Enew - Eold)/Eold;
    Eold = Enew;
end

fprintf('The eccentric anomaly at %f seconds is: %f radians\n', tf, Enew);

%Calculating true anomaly at t2 and displaying it
thetanew = 2*atan(sqrt((1+e)/(1-e))*tan(Enew/2));
thetanewd = rad2deg(thetanew);
fprintf('\nThe true anomaly at %f seconds is: %f radians, or %f degrees\n', tf, thetanew, thetanewd);

%Finding the position and velocity vectors in perifocal at t2 and displaying it
Rf = p/(1+e*cosd(thetanewd));
peri_rf = [Rf*cosd(thetanewd); Rf*sind(thetanewd); 0];
peri_vf = (mu/H)*[-sind(thetanewd); (e+cosd(thetanewd)); 0];

fprintf('\nThe new perifocal position vector at %f seconds is (in km): \n', tf);
disp(peri_rf);
fprintf('\nThe new perifocal velocity vector at %f seconds is (in km/s): \n', tf);
disp(peri_vf);

%Finding the position and velocity vectors in EPI and displaying it
CPE = CEP';
rf = CPE*peri_rf;
vf = CPE*peri_vf;

fprintf('\nThe new EPI position vector at %f seconds is (in km): \n', tf);
disp(rf);
fprintf('\nThe new EPI velocity vector at %f seconds is (in km/s): \n', tf);
disp(vf);
