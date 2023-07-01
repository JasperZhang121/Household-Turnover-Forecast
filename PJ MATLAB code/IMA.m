m = 4; %% the first m points as lags
load 'Household.csv';
y = Household(:,2);T0 = 50; h = 1; 
dely = y(m+h:end) - y(m:end-h); T = length(dely);
y0 = y(1:m); y = y(m+1:end);
ytph = y(T0+h: end);
yhat_IMA = zeros(T-h-T0+1, 1);
f = @(x) loglike_MA1(x, dely(1:T0));
thetaMLE = fminsearch(f, [.5, .5]);
for t = T0:T-h
 delyt = dely(1:t);
 f = @(x) loglike_MA1(x, delyt);
 thetaMLE = fminsearch(f, thetaMLE);
 H = speye(t) + spdiags(ones(t-1,1), [-1], t,t)*thetaMLE(2);
 uhat = H\delyt;
 yhat_IMA(t-T0+1,:) = y(t) + uhat(end)*thetaMLE(2);
end
MSFE_IMA1 = mean((ytph - yhat_IMA).^2);
