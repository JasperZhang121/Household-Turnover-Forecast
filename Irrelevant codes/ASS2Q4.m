load 'macrodata.csv';
y = macrodata(:,2);
m=4;
dely = y(m+h:end) - y(m:end-h);
y0 = y(1:m);y = y(m+1:end);T = length(y);
T0 = 50;h = 1;
yhatMA = zeros(T-h-T0+1,1);
ytph = y(T0+h:end);
f = @(psi) loglike_MA1(psi,dely(1:T0));
psihat=fminsearch(f,.5);
for t=T0:T-h
    delyt = dely(1:t);
    f=@(psi) loglike_MA1(psi,delyt);
    psihat = fminsearch(f, psihat);
    H = speye(t) + sparse(2:t,1:t-1,ones(1,t-1),t,t)*psihat;
    uhat=H\delyt;
    yhatMA(t-T0+1,:) = y(t) + psihat*uhat(end);
end
MSFE_MA = mean((ytph-yhatMA).^2);

