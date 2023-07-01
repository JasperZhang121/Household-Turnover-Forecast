load 'macrodata.csv';
y = macrodata(:,2);
m=4;T0 = 50;h = 1;
dely = y(m+h:end) - y(m:end-h);
y0 = y(1:m);y = y(m+1:end);T = length(y);
yhatMA = zeros(T-h-T0+1,1);
ytph = y(T0+h:end);
f = @(theta) loglike_MA1(theta,dely(1:T0));
thetahat=fminsearch(f,.5);
for t=T0:T-h
    delyt = dely(1:t);
    f = @(theta) loglike_MA2(theta,delyt);
    thetahat = fminsearch(f, [.5;.5;.5]);
    Gamma = speye(t) + sparse(2:t,1:t-1,ones(1,t-1),t,t)*psihat;
    uhat=Gamma\delyt;
    yhatMA(t-T0+1,:) = y(t) + psihat*uhat(end);
end
MSFE_MA = mean((ytph-yhatMA).^2);


