load 'Household.csv';
y = Household(:,2); 
T = length(y); t = (1:T)';a=ones(461,1);

T0 = 50;
H = 1; % h-step-ahead forecast
s = 12;
syHat = zeros(T-H-T0+1,1);
ytpH = y(T0+H:end); % observed y_{t+h}
alpha =  0.666; beta = 0.0589; gamma = 0.9215;
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
MSFE3 = mean((ytpH - syHat).^2);

ss=(1/(T-3))*sum((ytpH-syHat).^2);
fu=yhat +1.96*sqrt(ss);
fd=yhat -1.96*sqrt(ss);
u=mean(ytpH);
Z=(110-u)/sqrt(ss);