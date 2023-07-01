%%ARMA41 
m = 4; %% the first m points as lags
load 'Household.csv';
y = Household(:,2);
y0 = y(1:m); y = y(m+1:end); T = length(y);
T0 = 50; h = 1; 
yhatMA = zeros(T-h-T0+1,1); %% ARMA(4,1) forecasts
%theta = [phi 1, phi 2, phi 3; mu, psi]
f = @(theta) loglike_ARMA41(theta,y0,y(1:T0));
thetahat = fminsearch(f,[.5;.5;.5;.5;0;.5]);
for t = T0:T-h
yt = y(1:t);
%% find the MLE
f = @(theta) loglike_ARMA41(theta,y0,yt);
thetahat = fminsearch(f, thetahat);
%% make uhat
H = speye(t) + sparse(2:t,1:t-1,ones(1,t-1),t,t)*thetahat(5);
X = [[y0(m);y(1:t-1)] [y0(m-1:end);y(1:t-2)] [y0(m-2:end);y(1:t-3)] [y0(m-3:end);y(1:t-4)] ones(t,1)];
uhat = H\(yt - X*[thetahat(1) thetahat(2) thetahat(3) thetahat(4) thetahat(5)]');
%% store the forecasts
yhatMA(t-T0+1,:) = thetahat(5) + thetahat(1)*y(t)+ thetahat(2)*y(t-1)+ thetahat(3)*y(t-2)+ thetahat(4)*y(t-3) + thetahat(6)*uhat(end);
end
ytph = y(T0+h:end); % observed y {t+h}
MSFE = mean((ytph-yhatMA).^2);