function xdot = RPDiffEqt(t,x)

Q = 1/2*[1+x(1)^2 x(1)*x(2)-x(3) x(1)*x(3)+x(2);...
    x(2)*x(1)+x(3) 1+x(2)^2 x(2)*x(3)-x(1);...
    x(3)*x(1)-x(2) x(3)*x(2)+x(1) 1+x(3)^2];

w0=1.84*10^-6; w1=w0*sin(w0*t); w2=w0*cos(w0*t); w3=w0;

w = [w1; w2; w3];

Qdot = Q*w;

xdot = reshape(Qdot, 3, 1);
end


