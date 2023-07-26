% exploring the error involved in using the trapezoid method for
% integration estimation

% 0-1 interval since we know exact answer, we can see what error converges
a1 = 0;
b1 = 1;
exact_area = 0.74682413281229;

f_prime_a = f_prime(a1);
f_prime_b = f_prime(b1);
% wikipedia value
convergent_value_1 = (f_prime_a - f_prime_b) / 12
% my value
convergent_value_2 = (f_prime_a - f_prime_b) / 4

count = 25;
approx = zeros(count,1);
error = zeros(count,1);
errorh2 = zeros(count,1);
errorh2_conv = zeros(count,1);
n_vals = zeros(count,1);
h_vals = zeros(count,1);
index = 1;
n = 1;
while index < (count + 1)
    h = (b1 - a1) / n;
    n_vals(index) = n;
    h_vals(index) = h;
    % pass function f as additional parameter, function handles
    total_area = trap(h, n, a1);
    approx(index) = total_area;
    error(index) = abs(total_area-exact_area);
    err_h2 = (abs(total_area-exact_area))/(h*h);
    errorh2(index) = err_h2;
    errorh2_conv(index) = abs(err_h2 - convergent_value_1);
    index = index + 1;
    n = n * 2;
end

% data table
T = table;
T.n_values = n_vals;
T.h_values = h_vals;
T.approx_integral = approx;
T.error = error;
T.errorh2 = errorh2;
T.errorh2_conv = errorh2_conv

% trapezoid rule depiction
b = 3;
a = -b;
n = 8;
x = linspace(a, b, 10000);
y = exp(-(x.^2));
plot(x, y)
hold on
x2 = linspace(a, b, n);
y2 = exp(-(x2.^2));
plot(x2, y2)
area(x,y,'Facecolor','r')
area(x2,y2,'Facecolor','b')
alpha(0.4)
ylim([0 1.2])

% functions 
function val = f(xi)
    val = exp(-(xi^2));
end

function val_derivative = f_prime(xi)
    val_derivative = -2*xi*exp(-(xi^2));
end

function total_area = trap(h, n, a1)
    total_area = 0;
    for i = 0:n-1
        total_area = total_area + h*0.5*(f(a1+i*h)+(f(a1+(i+1)*h)));
    end
end