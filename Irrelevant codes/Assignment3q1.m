v1=ones(260,1);
d1=diag(v1);
v2=0.25*ones(259,1);
d2=diag(v2,-1);
v3=0.25*ones(258,1);
d3=diag(v3,-2);
h=d1+d2+d3;
load 'x.csv';
load 'y.csv';
X=transpose(x);
H=transpose(h);
betahat=((X*H*h*x)^(-1))*X*H*h*y;
sigmasquare=(1/211)*(y-x*betahat)'*H*h*(y-x*betahat);

