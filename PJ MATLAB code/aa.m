%%produce MA(1) data into y
T=1000;
y=zeros(T,1);
theta=.8;sig=1;
e=sig*randn(T,1);
y(1)=e(1);
for t =2:T
    y(t)=e(t-1)+theta*e(t);
end
plot(y);

%% Grid Search for theta, sigma known
ngrid=300;
theta_grid = linspace(.2,1,ngrid);
%construct A and B so that Gam = A+B*theta
A=speye(T);
B=sparse(2:T,1:T-1,ones(1,T-1),T,T);
ell = zeros(ngrid,1);
for i=1:ngrid
    theta = theta_grid(1);
    Gam=A+B*theta;
    Gam2=Gam*Gam';
    ell(i)=-T/2*log(2*pi)-.5*log(det(Gam2))-.5*y'*(Gam2\y);
end

plot(theta_grid,ell)

[Qmax id]=max(ell);

disp(theta_grid(id));
%% fminbond
f = @(theta) loglike_MA1([1 theta],y);
fminbnd(f,0,1)

%% Fminsearch

g=@(x) loglike_MA1(x,y);
[thetaMLE Qmax]=fminsearch(g,[.9 .7]);
disp(thetaMLE)
