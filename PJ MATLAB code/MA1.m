m = 4; %% the first m points as lags
load 'Household.csv';
T0 = 50; h = 1; % h−step−ahead forecast
y = Household(:,2);
dely = y(m+h:end) - y(m:end-h);
y0 = y(1:m); y = y(m+1:end); T = length(y);
yhatMA = zeros(T-h-T0+1,1); %% IMA(1,1) forecasts
ytph = y(T0+h:end); % observed y {t+h}
f = @(psi) loglike_MA1(psi,dely(1:T0));
psihat = fminsearch(f,.5);

for t = T0:T-h
delyt = dely(1:t);
%% find the MLE
f = @(psi) loglike_MA1(psi,delyt);
psihat = fminsearch(f, psihat);
%% prediction
H = speye(t) + sparse(2:t,1:t-1,ones(1,t-1),t,t)*psihat;
uhat = H\delyt;
%% store the forecasts
yhatMA(t-T0+1,:) = y(t) + psihat*uhat(end);
end
MSFE_MA = mean((ytph-yhatMA).^2);