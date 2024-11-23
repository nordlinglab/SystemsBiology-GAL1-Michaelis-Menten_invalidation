function [R_2,aR_2,FPE,AIC,FIT] = Residual(y,OUT,m) 
%y = model output 
%OUT = real output
%m = number of estimated parameters

% FPE&AIC
 y_i = y; %model output
 y_m = OUT; %measured output
 y_ava = mean(y_m); %mean of measure data
 y_ava_model = mean(y); %mean of model output
 N = length(OUT); %dimension of the estimation dataset
 RSS = sum((y_i-y_m).^2); %model-OUT
 ESS = sum((y_i-y_ava).^2); %model-mean
 TSS = sum((y_m-y_ava).^2); %OUT-mean
 R_2 = 1-RSS/TSS;
 aR_2 = 1-(1-R_2)*((N-1)/(N-m-1));
 FPE = ((1+m/N)/(1-m/N))*(1/N)*RSS;
 AIC = log((1/N)*(RSS))+2*m/N;
 FIT = 100*(1-sqrt(RSS/TSS));
 
fprintf('RSS: %3.4f \nESS: %3.4f \nTSS %3.4f \nR_2: %3.4f \naR_2: %3.6f\nFPE: %3.6f \nAIC: %3.4f \nFIT: %3.4f \nmodel mean: %3.4f \nmean of output %3.4f  \n\n',...
    RSS, ESS, TSS, R_2, aR_2, FPE, AIC, FIT, y_ava_model, y_ava)