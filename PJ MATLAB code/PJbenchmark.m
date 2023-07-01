load 'Household.csv';
y = Household(:,2); Q = Household(:,1);
T = length(y); t = (1:T)';a=1;

T0 = 50;
h = 1; % h-step-ahead forecast
syhat = zeros(T-h-T0+1,1);
ytph = y(T0+h:end); % observed y_{t+h}
for t = T0:T-h
    yhat1 = a*y(t-1);
    syhat(t-T0+1) = yhat1;
end
MSFE1 = mean((ytph-syhat).^2);

H = 3;
syHat = zeros(T-H-T0+1,1);
ytpH = y(T0+H:end); % observed y_{t+h}
for t = T0:T-H
    yhat2 = a*y(t-1);
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
