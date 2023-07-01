%% Running an ARIMA(1,1,1) Model
m = 4; h = 1;
load 'Household.csv';
y = Household(:,6);T0 = 50; 
y0 = y(1:m); y = y(m+1:end);
dely = y(2:end) - y(1:end-1);
dely0 = dely(1:m); dely = dely(m+1:end); T = length(dely);
ytph = y(m+T0+h: end);
ydelhatARIMA111 = zeros(T-h-T0+1, 1);
yhat_ARIMA111 = zeros(T-h-T0+1, 1);
for t = T0:T
 delyt = dely(h:t);
 xt = [ones(t-h+1, 1) [dely0(m); dely(1:t-h)]];
 betahatARIMA111 = (xt'*xt)\(xt'*delyt);
 ydelhatARIMA111(t-T0+1,:) = [1 dely(t) ]*betahatARIMA111;
 yhat_ARIMA111(t-T0+1, :) = ydelhatARIMA111(t-T0+1, :) + y(m+t);
end
MSFE_ARIMA111 = mean((ytph - ydelhatARIMA111).^2);
plot(ytph)
hold on
plot(yhat_ARIMA111)
hold off
% Error Estimates for ARIMA(1,1,1)
m = 3; h = 1;
y = xlsread('DATA.xlsx');
dely = y(2:end) - y(1:end-1); T = length(dely);
T0 = 120 - m;
Y = dely(2:end);
X = [ones(T-1, 1) dely(1:end-1)];
betahatARIMA111 = (X'*X)\(X'*Y);
delyhat = X*betahatARIMA111;
MSE_ARIMA111 = mean((delyhat - Y).^2);
k = 3;
AIC_ARIMA111 = MSE_ARIMA111*T + k*2;
BIC_ARIMA111 = MSE_ARIMA111*T + k*log(T);
