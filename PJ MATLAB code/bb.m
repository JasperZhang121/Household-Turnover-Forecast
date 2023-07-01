f=@(x) loglike_uc(x,y);
MLE=fminsearch(f,[0.5,0.5]);
disp(MLE)
function ell=loglike_uc(x,y)
phi=x(1);sig=x(2);
T=length(y);
A=speye(T);
B=spdiags(ones(T-1,1),[-1],T,T);
H=A+B*(-phi);
invomega=sparse(1:T,1:T,[1/5 1/0.7*ones(1,T-1)]);
HinvomegaH=H'*invomegaH;
K=speye(T)/sig+HinvomegaH;
tauhat=K\(y/sig);
err=(y-tauhat)'*(y-tauhat)/sig+tauhat'*HinvomegaH*tauhat;
ell=-T/2*log(sig)-(T-1)/2*log(0.7)-0.5*err;
ell=-ell;
end


