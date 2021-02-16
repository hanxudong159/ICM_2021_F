clear all;clc;

temp = xlsread('data');

for k=2:1:4
  A = temp(:,k);
  B = diff(A);
  figure(1)
  autocorr(B)
  figure(2)
  parcorr(B)
  x(1:5,k-1) = A;
  w = B;
  n = 3;
  s = 1;
  m1 = length(A);
  for i = s+1:m1
      y(i-s) = x(i) - x(i-s);
  end
  ToEstMd = arima('ARLags',1,'MALags',1:1,'Constant',0);
  [EstMd,EstParamCov,LogL,info] = estimate(ToEstMd,w);
  w_Forecast = forecast(EstMd,n,'Y0',w');
  yhat = y(end) + cumsum(w_Forecast);
  for j = 1:n
     x(m1 + j,k-1) = yhat(j) + x(m1+j-s);
  end
end