function [th1, th2, th3] = DCM2EA313(DCM, i)
th1 = atan2(DCM(3,1),-DCM(3,2));
th2 = acos(DCM(3,3));
th3 = atan2(DCM(1,3),DCM(2,3));

if ((abs(th2) < abs(5*10^-4)) || (abs(abs(th2)-pi) < abs(10^-3)))
    fprintf('\nThe euler angle is singular (Or close to) at %f seconds\n', i);
end

%EA313 = [cos(th3)*cos(th1)-sin(th3)*cos(th2)*sin(th1) cos(th3)*sin(th1)+sin(th3)*cos(th2)*cos(th1) sin(th3)*sin(th2); ...
 %       -sin(th3)*cos(th1)-cos(th3)*cos(th2)*sin(th1) -sin(th3)*sin(th1)+cos(th3)*cos(th2)*cos(th1) cos(th3)*sin(th2); ...
  %      sin(th2)*sin(th1) -sin(th2)*cos(th1) cos(th2)];
end

