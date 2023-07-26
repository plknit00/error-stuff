% exploring the error involved in using the trapezoid method for
% integration estimation

a1 = -8;
b1 = 8;
exact_area = sqrt(pi);
% exact_area_L = sqrt(pi) * erf(b1);

%0-1 interval in chapter 6 notes to compare code to to make sure correct
% a1 = 0;
% b1 = 1;
% exact_area = 0.74682413281229;

count = 22;
approx = zeros(count,1);
error = zeros(count,1);
errorh2 = zeros(count,1);
n_vals = zeros(count,1);
h_vals = zeros(count,1);
index = 1;
n = 1;
while index < (count + 1)
    h = (b1 - a1) / n;
    n_vals(index) = n;
    h_vals(index) = h;
    total_area = trap(h, n, a1);
    approx(index) = total_area;
    error(index) = abs(total_area-exact_area);
    errorh2(index) = (abs(total_area-exact_area))/(h*h);
    index = index + 1;
    n = n * 2;
end

% data table
T = table;
T.n_values = n_vals;
T.h_values = h_vals;
T.approx_integral = approx;
T.error = error;
T.errorh2 = errorh2

% error plot
loglog(h_vals,error,h_vals,error,'o');
xlabel('h'); 
ylabel('error');
title('Error in trapezoid method of integration, by changing h');

% function 
function val = f(xi)
    val = exp(-(xi^2));
end

function total_area = trap(h, n, a1)
    total_area = 0;
    for i = 0:n-1
        total_area = total_area + h*0.5*(f(a1+i*h)+(f(a1+(i+1)*h)));
    end
end