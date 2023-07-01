load 'Household.csv';
y = Household(:,2);T = length(y);
f = @(w) trend_cycle_lc(w,y); %% define f(w)
%% find the min of f from 2*pi/40 to 2*pi/4
omega = fminbnd(f,2*pi/40,2*pi/4);
t = (1:T)';
X = [ones(T,1) t cos(omega*t) sin(omega*t)];
beta = (X'*X)\(X'*y);
err = y-X*beta;
sig2 = err'*err/T;

T0 = 50;
h = 1; % h-step-ahead forecast
syhat = zeros(T-h-T0+1,1);
ytph = y(T0+h:end); % observed y_{t+h}
for t = T0:T-h
    yt = y(1:t);
    yhat1 = [1 t+h cos(omega*(t+h)) sin(omega*(t+h))]*beta;
    syhat(t-T0+1) = yhat1;
end
MSFE1 = mean((ytph-syhat).^2);
