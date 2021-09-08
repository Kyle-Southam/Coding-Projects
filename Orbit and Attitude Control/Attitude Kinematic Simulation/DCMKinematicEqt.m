function xdot = DCMKinematicEqt(t,x)

C = reshape(x,3,3);

w0=20*pi/180; w1=w0*sin(0.01*t); w2=0.01; w3=w0*cos(0.01*t);

wtilda = [0 -w3 w2; w3 0 -w1; -w2 w1 0];

Cdot = -wtilda*C;

xdot = reshape(Cdot, 9, 1);
end

