m = 4; %% the first m points as lags
load 'Household.csv';
y = Household(:,2);T0 = 50; h = 1; 
y0 = y(1:m); y = y(m+1:end); T = length(y);

yhatMA = zeros(T-h-T0+1,1); 
ytph = y(T0+h:end); 
f = @(psi) loglike_MA1(psi,y);
psihat = fminsearch(f,.5);