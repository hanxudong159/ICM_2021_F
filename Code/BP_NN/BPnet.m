clear all
clc

temp=xlsread('traindata');

P_train = temp(1:2:351,1:3)';
T_train = temp(1:2:351,4)';

P_test = temp(2:2:350,1:3)';
T_test = temp(2:2:350,4)';
N = size(P_test,2);

[p_train, ps_input] = mapminmax(P_train,0,1);
p_test = mapminmax('apply',P_test,ps_input);
[t_train, ps_output] = mapminmax(T_train,0,1);

net = newff(p_train,t_train,2);

net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-4;
net.trainParam.lr = 0.01;

net = train(net,p_train,t_train);

t_sim = sim(net,p_test);

T_sim = mapminmax('reverse',t_sim,ps_output);

error = abs(T_sim - T_test)./T_test;

R2 = corrcoef(T_sim,T_test);
R2 = R2(1,2)^ 2;

result = [T_test' T_sim' error']

figure
plot(1:N,T_test,'b:*',1:N,T_sim,'r-o')
handle=legend('Real Value','Predicted Value')
xlabel('Predicted')
ylabel('Level')
string = {'Comparison';['R^2=' num2str(R2)]};
title(string)

set(handle,'FontSize',18,'fontname','STFangSong');
set(gca,'FontSize',15,'fontname','Times New Roman');

P_simdata = xlsread('simulatedata');
P_simdata = P_simdata(:,2:4)';
p_simdata = mapminmax('apply',P_simdata,ps_input);
t_simdata = sim(net,p_simdata);
T_simdata = mapminmax('reverse',t_simdata,ps_output);

T_simdata = roundn(T_simdata',-1)


