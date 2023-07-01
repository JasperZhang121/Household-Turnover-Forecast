load 'Household.csv';
y = Household(:,2); Q = Household(:,1);
T = length(y); t = (1:T)';a=ones(461,1);
%% construct 4 dummy variables
D1 = (Q == 1); D2 = (Q == 2);
D3 = (Q == 3); D4 = (Q == 4);
X=[a t D4];
betahat=(X'*X)\(X'*y);
yhat=X*betahat;
MSE=mean((y-yhat).^2);
AIC=T*MSE+3*2;
BIC=T*MSE+3*log(T);

T0 = 50;
h = 1; % h-step-ahead forecast
syhat = zeros(T-h-T0+1,1);
ytph = y(T0+h:end); % observed y_{t+h}
for t = T0:T-h
    yt = y(1:t);
    D1t = D1(1:t); D2t = D2(1:t);
    D3t = D3(1:t); D4t = D4(1:t);
    Xt = [ones(t,1) (1:t)' D4t];
    beta1 = (Xt'*Xt)\(Xt'*yt);
    yhat1 = [1 t+h D4(t+h)]*beta1;
    syhat(t-T0+1) = yhat1;
end
MSFE1 = mean((ytph-syhat).^2);

H = 3;
syHat = zeros(T-H-T0+1,1);
ytpH = y(T0+H:end); % observed y_{t+h}
for t = T0:T-H
    yt = y(1:t);
    D1t = D1(1:t); D2t = D2(1:t);
    D3t = D3(1:t); D4t = D4(1:t);
    Xt = [ones(t,1) (1:t)' D4t];
    beta2 = (Xt'*Xt)\(Xt'*yt);
    yhat2 = [1 t+H D4(t+H)]*beta2;
    syHat(t-T0+1) = yhat2;
end
MSFE2 = mean((ytpH-syHat).^2);

b=1:461;
c=51:461;
plot(b,y);
hold on
plot(c,syhat);
hold off

m=53:461;
plot(b,y);
hold on
plot(m,syHat);
hold off



