m = 4; h = 1;
load 'Household.csv';
y = Household(:,6);T0 = 50; 
y0 = y(1:m); y = y(m+1:end); T = length(y);
yhatARMA21 = zeros(T-h-T0+1, 1);
 % theta = [phi1 mu psi];
f = @(theta) loglike_ARMA21(theta, y0, y(1:T0));
thetahat = fminsearch(f, [0.5, 0.5, 0, 0.5]);
for t = T0:T-h
 yt = y(1:t);
 % find the MLE
 f = @(theta) loglike_ARMA21(theta, y0, yt);
 thetahat = fminsearch(f, thetahat);
 % make the uhats
 Gam = speye(t) + spdiags(ones(t-1, 1), [-1], t, t)*thetahat(4);
 X = [[y0(m); y(1:t-1)] [y0(m-1:end); y(1:t-2)] ones(t, 1)];
 uhat = Gam\(yt-X*thetahat(1:3)');
 % store the forecasts
 yhat_ARMA21(t-T0+1, :) = thetahat(3) + thetahat(1)*y(t) + thetahat(2)*y(t-1)+thetahat(4)*uhat(end);
end
ytph = y(T0+h:end);
MSFE_ARMA21 = mean((ytph - yhat_ARMA21).^2);