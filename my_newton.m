function my_newton(fun, x0, TOL, nmax) 
 
 % Implementation of the well known Newton method.
 % 
 % INPUT:  fun     the function to investigate, given as inline function
 %         dfun    the derivative, given as inline function
 %         x0      starting guess
 %         TOL     tolerance for declaration of convergence
 %         DAMPED  = 0 for the standard undamped method
 %                 = 1 for the damped method to achieve global
 %                 convergence
 %         nmax    maximum number of iteration steps
 %         numeric use numerical differentiation
 %
 % OUTPUT: Table giving the iterates and corresponding function values
 %         Plot visualizing the iteration steps
 % Author: B. Flemisch
 
 %clf;
 dfun = fun;
 DAMPED = 1;
 numeric = 1;
 
 small = 1e-8;
 sigma = 0.0001; % parameter for damped method
 rho = 0.5; % parameter for damped method
 
 xvec = x0;
 x = x0;
 err = abs(feval(fun, x0)); 
 errvec = err;
 errvec2 = [err.^2];
 
 nit = 0; 
 while((nit < nmax) & (err > TOL))
   nit = nit + 1; 
   if (numeric)
     dx = max(sqrt(eps)*abs(x), 1e-8); % step width for central difference
     dfx = (feval(fun, x + dx) - feval(fun, x - dx))/(2*dx);
   else
     dfx = feval(dfun,x); % get derivative
   end
 
   if (abs(dfx) < small) % zero derivative -> divergence of the method
     nit
     x
     dfx
     disp('Zero derivative!');
     break;
   else
     d = - feval(fun,x)/dfx; % get search direction
     alpha = 1.0; % damping parameter set to 1
     xold = x;
     x = x + alpha*d; % new iterate
     if (DAMPED),
       f2 = feval(fun,xold).^2;
       f2n = feval(fun,x).^2;
       while (f2n > f2 + sigma*alpha*feval(fun,xold)*d) 
         alpha = rho*alpha; % damping parameter is adjusted
         x = xold + alpha*d; % adjust iterate
         f2n = feval(fun,x).^2;
       end
     end
     xvec = [xvec; x];
     err = abs(feval(fun, x));
     errvec = [errvec; err];
     errvec2 = [errvec2; err.^2];
   end
 end
 
 % plotting stuff:
 
 xmax = max(xvec);
 xmin = min(xvec);
 len = xmax - xmin;
 plotx = linspace(xmin-0.2*len,xmax+0.2*len,200);
 plotfun = feval(fun,plotx);
 
 tangentx = zeros(2*nit+1,1);
 tangenty = zeros(2*nit+1,1);
 for i = 1:nit+1
   tangentx(2*i-1) = xvec(i);
   tangentx(2*i) = xvec(i);
   tangenty(2*i) = feval(fun,xvec(i));
 end
 
 plot(plotx,plotfun, ...
   xvec,feval(fun,xvec),'r+', ...
   xvec,zeros(length(xvec),1),'go', ...
   tangentx,tangenty,'k-.', ...
   plotx,0*plotx,'k-', ...
   'markersize',10, 'linewidth', 2);
 set(gca, 'fontsize', 18);
 xmin = plotx(1);
 xmax = plotx(200);
 ymin = min(0,min(plotfun));
 ymax = max(0,max(plotfun));
 xlim([xmin xmax]);
 ylim([ymin ymax]);
 if feval(fun, x0) > 0
 text(x0, 0, 'x0', 'fontsize', 18, 'HorizontalAlignment', 'center', ...
      'VerticalAlignment', 'top');
 else 
 text(x0, 0, 'x0', 'fontsize', 18, 'HorizontalAlignment', 'center', ...
      'VerticalAlignment', 'bottom');
 end
 text(0.5*(xmin + xmax), ymax - 0.05*(ymax - ymin), ...
      strcat('x = ', num2str(x,12)), ...
      'fontsize', 18, ...
      'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
 
 % print table:
 
 fprintf('\nk\t\tx_k\t\t  |f_k|\t\t|f_k|/f_(k-1)^2\n\n');
 fprintf('0\t%22.15e\t %.2e\n',xvec(1),errvec(1));
 for i=2:min(nit,nmax)
   fprintf('%d\t%22.15e\t %.2e\t   %.2e\n', i-1, xvec(i), errvec(i), ...
 	  errvec(i)/errvec(i-1)^2);
 end
 if (nit < nmax | errvec(nit+1) < TOL)
   fprintf('%d\t%22.15e\t < TOL\t\t\t\t%.2e\n\n', nit, xvec(nit+1));
 else
   fprintf('%d\t%22.15e\t %.2e\t   %.2e\n\n', nit, xvec(nit+1), ...
 	  errvec(nit+1), errvec(nit+1)/errvec(nit)^2);
 end

