function robot
% ROBOT Example for usage of newton method : Robot arm, two
% dimensional, two arms. Type 'robot' to start. 
	
% Author : Andreas Klimke, Universität Stuttgart
% Version: 1.0 
% Date: June 13, 2003
	
% Define robot arm lengths
l = [4; 2];

% Set the target point
p = [3; 4];

% Perform newton iteration
[x, niter] = newtonsys(@f_robot, [pi/2; pi/2], 1e-5, 20, l, p)
	
% Display results
disp(['Result: alpha = ' num2str(x(1)/pi*180)]);
disp(['        beta  = ' num2str(x(2)/pi*180)]);

% Visualize the solution
y = [0, 0; ...
		l(1)*cos(x(1)), l(1)*sin(x(1)); ...
		l(1)*cos(x(1))-l(2)*cos(x(1)+x(2)), l(1)*sin(x(1))-l(2)* ...
		 sin(x(1)+x(2))]; 
		
plot(y(:,1), y(:,2), '-o', 'LineWidth', 2);
text(0.4, 0.4, '\alpha','FontSize',16);
text(y(2,1)+0.2, y(2,2)-0.3, '\beta','FontSize',16);
axis([-2,5,0,6])
grid


% ---------------------------------------------------------------
function out = f_robot(x, flag, l, p)
% Definition of the two-dimensional function
	
if isempty(flag)
	flag = '';
end
	
switch lower(flag)
 case ''
	out = [l(1)*cos(x(1))-l(2)*cos(x(1)+x(2))-p(1); ...
			 l(1)*sin(x(1))-l(2)*sin(x(1)+x(2))-p(2)];	
 case 'jacobian'
	out = [-l(1)*sin(x(1))+l(2)*sin(x(1)+x(2)), ...
				 l(2)*sin(x(1)+x(2)); ...
				 l(1)*cos(x(1))+l(2)*cos(x(1)+x(2)), ...
				 -l(2)*cos(x(1)+x(2))];
end


