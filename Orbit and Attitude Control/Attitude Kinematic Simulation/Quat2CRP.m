function [q1, q2, q3] = Quat2CRP(B0, B1, B2, B3)
if (abs(B0) > 0.195)
    q1 = B1/B0;
    q2 = B2/B0;
    q3 = B3/B0;
else
    q1 = B1;
    q2 = B2;
    q3 = B3;
end
end