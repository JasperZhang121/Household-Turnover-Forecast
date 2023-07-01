m = 4; %% the first m points as lags
load 'Household.csv';
y = Household(:,2);T0 = 50; h = 1; % h−step−ahead forecast
dely = y(m+h:end) - y(m:end-h);
y0 = y(1:m); y = y(m+1:end); T = length(y);
yhatIAR = zeros(T-h-T0+1,1); %% IMA(1,1) forecasts
ytph = y(T0+h:end); % observed y {t+h}
for t = T0:T-h
    yt = y(h:t);
    zt = [ones(t-h+1,1) [y0(m);y(1:t-h)]];
    betahat1=(zt'*zt)\(zt'*yt);
%% store the forecasts
yhatIAR(t-T0+1,:) = [1 y(t)]*betahat1;
end
ytph = y(T0+h:end); % observed y {t+h}
MSFE_IAR1 = mean((ytph-yhatIAR).^2);