load 'FrenchRetail.csv';
y = FrenchRetail(:,2); Q = FrenchRetail(:,1);
T = length(y); t = (1:T)'; a=ones(342,1);

T0 = 50;
H = 3; % h-step-ahead forecast
s = 12;
syHat = zeros(T-H-T0+1,1);
ytpH = y(T0+H:end); % observed y_{t+h}
alpha = 0.198248961977353; beta = 0.0185768525977068; gamma = 0.676755877799364;
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



    