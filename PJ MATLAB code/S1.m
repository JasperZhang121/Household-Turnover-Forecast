load 'FrenchRetail.csv';
y = FrenchRetail(:,2); Q = FrenchRetail(:,1);
T = length(y); t = (1:T)'; a=ones(342,1);
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

b=1:342;
c=51:342;
plot(b,y);
hold on
plot(c,syhat);
hold off

m=53:342;
plot(b,y);
hold on
plot(m,syHat);
hold off

ss=(1/(T-3))*sum((y-yhat).^2);
Xn=[1 340 0];
yhatn=Xn*betahat;
fu=yhatn +1.96*sqrt(ss);
fd=yhatn -1.96*sqrt(ss);
u=mean(y);
Z=(110-u)/sqrt(ss);

T0 = 50;
H = 1; % h-step-ahead forecast
s = 12;
syHat = zeros(T-H-T0+1,1);
ytpH = y(T0+H:end); % observed y_{t+h}
alpha = 0.4; beta = 0.4; gamma = 0.4;
St = zeros(T-H,1);
Lt = mean(y(1:s)); bt = 0; St(1:s) = y(1:s)-Lt;

for t= s+1:T-H
    newLt = alpha*(y(t)-St(t-s))+(1-alpha)*(Lt+bt);
    newbt = beta*(newLt-Lt)+(1-beta)*bt;
    St(t) = gamma*(y(t)-newLt)+(1-gamma)*St(t-s);
    yhat = newLt +H*newbt + St(t+H-s);
    Lt = newLt; bt = newbt;
    if t>=T0
        syHat(t-T0+1,:) = yhat;
    end
end
MFSE3 = mean((ytpH - syHat).^2);

plot(b,y);
hold on
plot(m,syHat);
hold off
























