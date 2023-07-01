load 'x.csv';load 'y.csv';load 'xf.csv';load 'xFF.csv';
X=transpose(x);T = length(y);
betahat=((X*x)^(-1))*X*y;
T0 = 50;
h = 1; % h-step-ahead forecast
ytph = y(T0+h:end); % observed y_{t+h}
for t = T0:T-h
    yhat1 = xf*betahat;
end
MSFE1 = mean((ytph-yhat1).^2);

H = 3; % h-step-ahead forecast
ytpH = y(T0+H:end); % observed y_{t+h}
for t = T0:T-H
    yhat2 = xFF*betahat;
end
MSFE2 = mean((ytpH-yhat2).^2);
