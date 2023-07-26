% trying different loop orderings

t = zeros(1, 3);
n = 1000;
tic;
Ar = zeros(n,n);
[nrows,ncols] = size(Ar);

% outer = row, inner = col
tic;
for rows = 1:nrows
    for col = 1:ncols
        Ar(rows, col) = rows * (rows + col^3) + 17;
    end
end
t(1) = toc;

% outer = col, inner = row
tic;
Ac = zeros(n,n);
[nrows,ncols] = size(Ac);
for col = 1:ncols
    for rows = 1:nrows
        Ac(rows, col) = rows * (rows + col^3) + 17;
    end
end
t(2) = toc;

% vectorized solution
tic;
% can't figure out why the . is included, doesn't seem to need to be
temp = (1:nrows).'; 
% 1) . does element by element operation
% 2) temp (col vec) and the row vector add to make matrix with 
% element-wise addition without a .
% 3) 17 is added to every vector element by implicit vectorization
% 4) Matlab doesn't like commands like "temp .+ 17" (dot = bad)
Av = temp .* (temp + (1:ncols).^3) + 17;
t(3) = toc;

% look at the time differences
t


% Messing around on my own
% a = b
row = [1 3 5 7];
col = [2 4 6 8]';
% makes matrix
a = row + col
b = col + row
b2 = col * row
% makes col vector
c = col + col
c2 = col .* col
d = row' + col
% makes row vector
e = row + col'
% makes scalar
f = sum(row)

Ar1 = zeros(3,3);
Ar2 = zeros(3,3);
Ar2 = Ar2 + 1;
Ar1 - Ar2