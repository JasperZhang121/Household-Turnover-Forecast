%original data series figure:
load 'Household.csv';
x=Household(:,1);
y=Household(:,2);
m = 4; %% the first m points as lags

plot(x,y);
title('Houshold Goods Retailing')
xlabel('periods');
ylabel('Turnover')

[cov_y,lags_y] = xcov(y,100,'coeff');
stem(lags_y,cov_y)

