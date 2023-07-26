% exploring the error involved in using the trapezoid method for
% integration estimation changing L and h

count = 5;
n_vec = [10 20 40 80 160];
L_vec = [1 2 3 4];
n_end = size(n_vec,2);
L_end = size(L_vec,2);
approx = zeros(L_end,n_end);
error = zeros(L_end,n_end);
error_h2 = zeros(L_end,n_end);
for i = 1:L_end
    L = L_vec(i); 
    a1 = -L;
    b1 = L;
    exact_area = sqrt(pi);
    exact_area_L = sqrt(pi) * erf(L);
    for j = 1:n_end
        n = n_vec(j);
        h = (b1 - a1) / n;
        approx_area = trap(h, n, a1);
        approx(i,j) = approx_area;
        err = exact_area_L - approx_area;
        error(i,j) = err;
        error_h2(i,j) = err/h^2;
    end
end

% data table of error for changing L and h
% get exact value from -L to L and make sure to converge with h^2 accuracy
T = table;
T.('L') = L_vec';
T.('h = 1/10') = error(1:L_end,1);
T.('h = 1/20') = error(1:L_end,2);
T.('h = 1/40') = error(1:L_end,3);
T.('h = 1/80') = error(1:L_end,4);
T.('h = 1/160') = error(1:L_end,5)

% why does this table go down by the amounts in each row?
T2_h2 = table;
T2_h2.('L') = L_vec';
T2_h2.('h = 1/10') = error_h2(1:L_end,1);
T2_h2.('h = 1/20') = error_h2(1:L_end,2);
T2_h2.('h = 1/40') = error_h2(1:L_end,3);
T2_h2.('h = 1/80') = error_h2(1:L_end,4);
T2_h2.('h = 1/160') = error_h2(1:L_end,5)

% we want to know for a given L, how big n has to be st error < truncation error
L_val = [1 2 3 4 8 16];
j_end2 = size(L_val,2);
n_val = zeros(j_end2,1);
for j = 1:j_end2
    L = L_val(j);
    a1 = -L;
    b1 = L;
    truncation_error = exp(-(b1^2));
    exact_area = sqrt(pi);
    error_val = truncation_error + 1;
    n = 10;
    while error_val >= truncation_error
        h = (b1 - a1) / n;
        total_area = trap(h, n, a1);
        error_val = abs(total_area-exact_area);
        if error_val >= truncation_error
            n = n + 10;
        end
    end
    n_val(j) = n;
end

% data table of h for changing L st error < domain truncation error
T3 = table;
T3.L_values = L_val';
T3.n_values = n_val

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