load 'Household.csv';
y = Household(:,2);
m = 4; %% the first m points as lags
y0 = y(1:m); y = y(m+1:end); T = length(y);
T0 = 50; h = 1; % h−step−ahead forecast
yhatAR = zeros(T-h-T0+1,1); %% AR(1) forecasts
for t = T0:T-h
    yt = y(h:t);
    zt = [ones(t-h+1,1) [y0(m);y(1:t-h)]];
    betahat1=(zt'*zt)\(zt'*yt);
%% store the forecasts
yhatAR(t-T0+1,:) = [1 y(t)]*betahat1;
end
ytph = y(T0+h:end); % observed y {t+h}
MSFE_AR1 = mean((ytph-yhatAR).^2);


