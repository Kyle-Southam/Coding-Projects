function [x] = multigrid(xinit, b, h, hmax, nu, relax)
% Solves the system Ax = b using a V-cycle multigrid method
%
% Inputs:       
% xinit - length N array representing the initial guess for x
% b     - length N array of the source terms
% h     - scalar spatial step size
% hmax  - scalar coarsest spatial step size
% nu    - scalar number of relaxation iterations per level
% relax - scalar relaxation factor
%
% Output:
% x     - length N array of the approximate solution for x

% Relax the solution at this level
x = relaxation(xinit,b,h,nu,relax);
% Set step size for the next level
hdown = 2*h;
% Check if step size is valid
if hdown < hmax
    % Compute residual
    r = residual(x,b,h);
    % Set b to -r and restrict
    bdown = restriction(-r);
    % Set the initial guess for the error to zero
    xinitdown = zeros(size(bdown));
    % Solve for error on the coarse grid
    [erdown] = multigrid(xinitdown, bdown, hdown, hmax, nu, relax);
    % Prolongate error back to the fine grid
    erup = prolongation(erdown);
    % Apply the correction
    x = x(:) - erup(:);
    % Relax again
    x = relaxation(x,b,h,nu,relax);
end