v1=ones(260,1);a=1;b=0.712321;
d1=diag(v1);
v2=a*ones(259,1);
d2=diag(v2,-1);
v3=b*ones(258,1);
d3=diag(v3,-2);
h=d1+d2+d3;
load 'x.csv';load 'xf.csv';
load 'y.csv';load 'xFF.csv';
X=transpose(x);
H=transpose(h); T=260;
m=inv(H*h)
betahat=((X*H*h*x)^(-1))*X*m*y;
sig=(1/211)*(y-x*betahat)'*m*(y-x*betahat);
M=-T/2*log(2*pi*sig)-1/(2*sig)*(y-x*betahat)'*m*(y-x*betahat);

T0 = 50;
n = 1; % h-step-ahead forecast
ytph = y(T0+n:end); % observed y_{t+h}
for t = T0:T-n
    yhat1 =xf*betahat;
end
MSFE1 = mean((ytph-yhat1).^2);

N = 3; % h-step-ahead forecast
ytpH = y(T0+N:end); % observed y_{t+h}
for t = T0:T-N
    yhat2 = xFF*betahat;
end
MSFE2 = mean((ytpH-yhat2).^2);