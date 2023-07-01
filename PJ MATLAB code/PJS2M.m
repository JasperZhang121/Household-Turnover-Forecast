load 'Household.csv';
y = Household(:,2); Q = Household(:,1);x=Household(:,4);
T = length(y); t = (1:T)';a=ones(461,1);
%% construct 4 dummy variables
D1 = (Q == 1); D2 = (Q == 2);
D3 = (Q == 3); D4 = (Q == 4);
X=[t D1 D2 D3 D4 x];
betahat=(X'*X)\(X'*y);
yhat=X*betahat;

T0 = 50;
h = 1; % h-step-ahead forecast
syhat = zeros(T-h-T0+1,1);
ytph = y(T0+h:end); % observed y_{t+h}
for t = T0:T-h
    yt = y(1:t);
    D1t = D1(1:t); D2t = D2(1:t);
    D3t = D3(1:t); D4t = D4(1:t);
    xt = x(1:t);
    Xt = [(1:t)' D1t D2t D3t D4t xt];
    beta1 = (Xt'*Xt)\(Xt'*yt);
    yhat1 = [t+h D1(t+h) D2(t+h) D3(t+h) D4(t+h) x(t+h)]*beta1;
    syhat(t-T0+1) = yhat1;
end
MSFE1 = mean((ytph-syhat).^2);

b=1:461;
c=51:461;
plot(b,y);
hold on
plot(c,syhat);
hold off
