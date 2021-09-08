function [p2, v2] = OE2RV(a, e, O, I, w, M)
mu = 0.39860*10^6; %mu of earth, km^3/s^2
reltol = 10^-6;
abstol = 10^-6;

p = a*(1-e^2);
h = sqrt(p*mu);

Eold = M;
Eerr = 1;
Eabs = 1;

while ((abs(Eerr) >= reltol) || (abs(Eabs) >= abstol))
    Enew = Eold - ((Eold-e*sin(Eold)-M)/(1-e*cos(Eold)));
    Eerr = Enew - Eold;
    Eabs = (Enew - Eold)/Eold;
    Eold = Enew;
end
E0 = Eold;

DCMO = [cos(O) sin(O) 0; -sin(O) cos(O) 0; 0 0 1];
DCMI = [1 0 0; 0 cos(I) sin(I); 0 -sin(I) cos(I)];
DCMw = [cos(w) sin(w) 0; -sin(w) cos(w) 0; 0 0 1];

DCM = DCMw*DCMI*DCMO;

f = 2*atan(sqrt((1+e)/(1-e))*tan(Enew/2));

Rf = p/(1+e*cos(f));
pr = [Rf*cos(f); Rf*sin(f); 0];
vr = (mu/h)*[-sin(f); (e+cos(f)); 0];

p2 = (DCM)'*pr;
v2 = (DCM)'*vr;
end

