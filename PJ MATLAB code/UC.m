load 'Household.csv';
y = Household(:,2);
m = 4; %% the first m points as lags
y0 = y(1:m); y = y(m+1:end);
T = length(y);
Vtau = 9; %% initial condition
omega = 1; %% fix omega
%% recursive forecast exercise
T0 = 50; 
h = 1; % h−step−ahead forecast
yhatUC = zeros(T-h-T0+1,1);
ytph = y(T0+h:end); % observed y {t+h}
sighat = 1;
for t = T0:T-h
yt = y(1:t);
f = @(sig) loglike_UC(sig,omega,yt,Vtau);
sighat = fminsearch(f,sighat);
H = speye(t) - spdiags(ones(t-1,1),-1,t,t);
invOmega =sparse(1:t,1:t,[1/Vtau 1/omega*ones(1,t-1)],t,t);
HinvOmegaH = H'*invOmega*H;
K = speye(t)/sighat + HinvOmegaH;
tauhat = K\(yt/sighat);
yhatUC(t-T0+1) = tauhat(end); %store the forecasts
end
ytph = y(T0+h:end); % observed y {t+h}
MSFEuc = mean((ytph-yhatUC).^2);

