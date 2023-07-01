load 'Household.csv';
c = Household(:,2);
y=log(c);
m = 4; %% the first m points as lags
y0 = y(1:m); y = y(m+1:end); T = length(y);
T0 = 50; h = 1; % h−step−ahead forecast
yhatAR = zeros(T-h-T0+1,1);
for t = T0:T-h
    yt = y(h:t);
    zt = [ones(t-h+1,1) [y0(m);y(1:t-h)] [y0(m-1:end);y(1:t-h-1)] [y0(m-2:end);y(1:t-h-2)]];
    betahat2=(zt'*zt)\(zt'*yt);
%% store the forecasts
yhatAR(t-T0+1,:) = [1 y(t) y(t-1) y(t-2) ]*betahat2;
end
ytph = y(T0+h:end); % observed y {t+h}
syHat = exp(yhatAR); ytpH = exp(ytph);
MSFE_logAR3 = mean((ytph-syHat).^2);