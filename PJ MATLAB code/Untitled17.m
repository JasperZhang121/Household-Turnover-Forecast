%original data series figure:
load 'Household.csv';
x=Household(:,7);
y=Household(:,2);
m = 4; %% the first m points as lags

plot(x,y);