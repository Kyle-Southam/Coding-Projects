function [a, e, O, I, w, M, E0, f] = RV2OE(r, v)
mu = 0.39860*10^6; %mu of earth, km^3/s^2

hv = cross(r, v);
cv = cross(v,hv) - mu.*r./sqrt(sum(r.^2));

a = 2/sqrt(sum(r.^2)) - sqrt(sum(v.^2))^2/mu;
a = 1/a;

ev = cv./mu;
e = sqrt(sum(ev.^2));

ih = hv./sqrt(sum(hv.^2));
ie = cv./(mu*e);
ip = cross(ih, ie);

ih = ih';
ie = ie';
ip = ip';

C = [ie; ip; ih];

O = atan2(C(3,1),-C(3,2));

I = acos(C(3,3));

w = atan2(C(1,3),C(2,3));

if cv(3) > 0
   % w = wrapToPi(w);
    w = w;
else
    %w = wrapToPi(w);
    w = -w;
end

s0 = dot(r, v)/sqrt(mu);
E0 = atan2((s0/sqrt(a)),(1-sqrt(sum(r.^2))/a));

M = E0 - e*sin(E0);

f = 2*atan(sqrt(1+e)/sqrt(1-e)*tan(E0/2));

end

