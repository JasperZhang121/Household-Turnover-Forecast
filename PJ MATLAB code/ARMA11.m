%%ARMA11 
m = 4; %% the first m points as lags
load 'Household.csv';
y = Household(:,2);
y0 = y(1:m); y = y(m+1:end); T = length(y);
T0 = 50; h = 1; 
yhatMA = zeros(T-h-T0+1,1); %% ARMA(1,1) forecasts
%theta = [phi 1,mu, psi]
f = @(theta) loglike_ARMA11(theta,y0,y(1:T0));
thetahat = fminsearch(f,[.5;0;.5]);
for t = T0:T-h
yt = y(1:t);
%% find the MLE
f = @(theta) loglike_ARMA11(theta,y0,yt);
thetahat = fminsearch(f, thetahat);
%% make uhat
H = speye(t) + sparse(2:t,1:t-1,ones(1,t-1),t,t)*thetahat(3);
X = [[y0(m);y(1:t-1)] ones(t,1)];
uhat = H\(yt - X*[thetahat(1) thetahat(2)]');
%% store the forecasts
yhatMA(t-T0+1,:) = thetahat(2) + thetahat(1)*y(t) + thetahat(3)*uhat(end);
end
ytph = y(T0+h:end); % observed y {t+h}
MSFEMA = mean((ytph-yhatMA).^2);

