function EAdot = DCM2EAIntegrate(t,x)
B = 1/(sin(x(2)))*[sin(x(3)) cos(x(3)) 0; ...
        sin(x(2))*cos(x(3)) -sin(x(2))*sin(x(3)) 0; ...
        -cos(x(2))*sin(x(3)) -cos(x(2))*cos(x(3)) sin(x(2))];
    
w0=20*pi/180; w1=w0*sin(0.01*t); w2=0.01; w3=w0*cos(0.01*t);
w = [w1; w2; w3];

THDot = B*w;
EAdot = reshape(THDot,3,1);
end

