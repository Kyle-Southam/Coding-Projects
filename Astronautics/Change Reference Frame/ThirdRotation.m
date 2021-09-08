function ThirdDCM = ThirdRotation(angle)
    %This just does the DCM about a third axis for a certain angle (IN RADIANS)

    c = cos(angle);
    s = sin(angle);

    ThirdDCM = [c s 0; -s c 0; 0 0 1];

   % disp(ThirdDCM);
end

