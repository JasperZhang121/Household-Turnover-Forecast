tic;
load 'FrenchRetail.csv';
y = FrenchRetail(:,2);y = log(y);
FrenchRetailHoltFunction([0.7 0.3 0.5]);%MSFE for aplha = 0.7, beta = 0.3, gamma = 0.5
[parametersstar MSFEstar] = fminsearch(@FrenchRetailHoltFunction, [0.5 0.5 0.5])
toc

function MSFE = FrenchRetailHoltFunction(parameters)  %assumes y is already the variable of interestload 'AUSRetail.csv' ;
load 'FrenchRetail.csv';
y = FrenchRetail(:,2); T = length(y);
T0 = 50; h = 1; s = 12;
syhat = zeros(T-h-T0+1,1);
ytph = y(T0+h:end); % observed y_{t+h}
St = zeros(T-h,1);
alpha = parameters(1); beta = parameters(2); gamma = parameters(3);% input smoothing parameters
% initialize
Lt = mean(y(1:s)); bt = 0; St(1:12) = y(1:s) - Lt;
for t = s+1:T-h
	newLt = alpha*(y(t) - St(t-s)) + (1-alpha)*(Lt+bt);
	newbt = beta*(newLt-Lt) + (1-beta)*bt;
	St(t) = gamma*(y(t)-Lt - bt) + (1-gamma)*St(t-s);
	yhat = newLt + h*newbt + St(t+h-s);
	Lt = newLt; bt = newbt; % update Lt and bt
	if t>= T0
		syhat(t-T0+1,:) = yhat;
	end
end

syhat = exp(syhat); ytph = exp(ytph);
MSFE = mean((ytph-syhat).^2);

end