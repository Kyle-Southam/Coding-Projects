function xdot = NewtonsLaw(t,x)
mu = 0.39860*10^6; %mu of earth, km^3/s^2

rx = x(1);
ry = x(2);
rz = x(3);
vx = x(4);
vy = x(5);
vz = x(6);

r  = sqrt(rx.^2+ry.^2+rz.^2);

xdot(1,1) = vx;
xdot(2,1) = vy;
xdot(3,1) = vz;
xdot(4,1) = -mu*rx/r.^3;
xdot(5,1) = -mu*ry/r.^3;
xdot(6,1) = -mu*rz/r.^3;
end

