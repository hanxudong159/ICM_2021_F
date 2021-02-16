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

for j = 2:2:30
net = newff(p_train,t_train,j);
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-4;
net.trainParam.lr = 0.01;
net = train(net,p_train,t_train);
t_sim = sim(net,p_test);
T_sim = mapminmax('reverse',t_sim,ps_output);
error = abs(T_sim - T_test)./T_test;
R2 = corrcoef(T_sim,T_test);
R2 = R2(1,2)^ 2;
er(j/2) = 1-R2;
end

plot(2:2:30,er','Linewidth',2);
xlabel('Numbers of hidden layers')
ylabel('Error')
box on;
set(gca,'FontSize',18,'fontname','Times New Roman');