v1=ones(260,1);
d1=diag(v1); a=0.25,b=0.25;c=[a b];
v2=a*ones(259,1);
d2=diag(v2,-1);
v3=b*ones(258,1);
d3=diag(v3,-2);
h=d1+d2+d3;
load 'x.csv';
load 'y.csv';
X=transpose(x);
H=transpose(h); T=260;
betahat=((X*H*h*x)^(-1))*X*H*h*y;
sig=(1/211)*(y-x*betahat)'*H*h*(y-x*betahat);

%% Grid Search for theta, sigma known
ngrid=260;
c_grid = linspace(0.2,1,ngrid);
ell = zeros(ngrid,1);
for i=1:ngrid
    c = c_grid(1);
    ell(i)=-T/2*log(2*pi*sig)-1/(2*sig)*(y-x*betahat)'*H*h*(y-x*betahat);
end

plot(c_grid,ell)
[Qmax, id]=max(ell);
