function [q1, q2, q3] = DCM2CRP(DCM)
%Quaternion
B0 = 1/2*sqrt(DCM(1,1)+DCM(2,2)+DCM(3,3)+1);

phi = acos(1/2*(DCM(1,1)+DCM(2,2)+DCM(3,3)-1));
phi = wrapToPi(phi);


if (0 <= phi <= pi)
    B0 = B0;
elseif (-pi <= phi <= 0)
    B0 = -B0;
end

B1 = (DCM(2,3)-DCM(3,2))/(4*B0);
B2 = (DCM(3,1)-DCM(1,3))/(4*B0);
B3 = (DCM(1,2)-DCM(2,1))/(4*B0);

%Find rodriguez parameters
    q1 = B1/B0;
    q2 = B2/B0;
    q3 = B3/B0;
end
