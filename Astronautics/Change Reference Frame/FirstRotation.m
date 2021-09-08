function FirstDCM = FirstRotation(angle)
    %This just does the DCM about the first axis for a certain angle (IN RADIANS)

    c = cos(angle);
    s = sin(angle);

    FirstDCM = [1 0 0; 0 c s; 0 -s c];

   % disp(FirstDCM);
end

