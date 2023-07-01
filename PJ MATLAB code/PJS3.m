load 'Household.csv';
y = Household(:,2); M = Household (:,3);
T = length(y); t = (1:T)';a=ones(461,1);
%% construct 12 dummy variables
D1 = (M == 1); D2 = (M == 2);
D3 = (M == 3); D4 = (M == 4);
D5 = (M == 5); D6 = (M == 6);
D7 = (M == 7); D8 = (M == 8);
D9 = (M == 9); D10 = (M == 10);
D11 = (M == 11); D12 = (M == 12);
X=[a t D12];
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
    D5t = D5(1:t); D6t = D6(1:t);
    D7t = D7(1:t); D8t = D8(1:t);
    D9t = D9(1:t); D10t = D10(1:t);
    D11t = D11(1:t); D12t = D12(1:t);
    Xt = [ ones(t,1) (1:t)' D12t];
    beta1 = (Xt'*Xt)\(Xt'*yt);
    yhat1 = [1 t+h D12(t+h)]*beta1;
    syhat(t-T0+1) = yhat1;
end
MSFE1 = mean((ytph-syhat).^2);

H=3;
syHat = zeros(T-H-T0+1,1);
ytpH = y(T0+H:end);
for t = T0:T-H
    yt = y(1:t);
    D1t = D1(1:t); D2t = D2(1:t);
    D3t = D3(1:t); D4t = D4(1:t);
    D5t = D5(1:t); D6t = D6(1:t);
    D7t = D7(1:t); D8t = D8(1:t);
    D9t = D9(1:t); D10t = D10(1:t);
    D11t = D11(1:t); D12t = D12(1:t);
    Xt = [ ones(t,1) (1:t)' D12t];
    beta2 = (Xt'*Xt)\(Xt'*yt);
    yhat2 = [1 t+H D12(t+H)]*beta2;
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

