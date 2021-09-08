% Programmer: Kyle Southam
% Date Done: 12/2/2020
%Takes the linearized EOMs of a helicopter near hover, designs a state feedback controller, and designs an observer

%Problem 1
A = [-0.4 0 -0.1; 1 0 0; -1.4 9.8 -0.02];
B = [6.3; 0; 9.8];
C = [0 0 1];

%1.2
c = [B, A*B, A^2*B];
c1 = rank(c);
disp('The rank of the controlability matrix is: ')
disp(c1);

o = [C; C*A; C*A^2];
o1 = rank(o);
disp('The rank of the observability matrix is: ')
disp(o1);

%1.3
p = [-1+1i -1-1i -2];
K = place(A,B,p);
disp('The controller found that places the loops at those locations is:');
disp(K);

%1.4
p = [-4+4*sqrt(3)*i -4-4*sqrt(3)*i -8];
L = place(A',C',p);
disp('The estimater poles I found are: ');
disp(L);
