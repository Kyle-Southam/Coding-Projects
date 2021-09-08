function [DCM] = CRP2DCM(q1, q2, q3)
Q = [0 -q3 q2; q3 0 -q1; -q2 q1 0];
DCM = (eye(3)-Q)*(eye(3)+Q)^(-1);
end

