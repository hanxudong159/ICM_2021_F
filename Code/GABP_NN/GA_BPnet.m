%�����Ŵ��㷨�Ľ���������
% @ȫ���̲���

%% I. ��ջ�������
clear all
clc
%% II. ѵ����/���Լ�����
%%
% 1. ��������
temp=xlsread('traindata');

%�ڵ����
inputnum=3;
hiddennum=8;
outputnum=1;

%%
% 2. ����ѵ�����Ͳ��Լ�
% ѵ��������176������  1:2:351
input_train = temp(1:2:351,1:3)';
input_test  = temp(2:2:350,1:3)';
% ���Լ�����175������
output_train = temp(1:2:351,4)';
output_test = temp(2:2:350,4)';
%% III. ���ݹ�һ��
[inputn,inputps]=mapminmax(input_train);%��һ����[-1,1]֮�䣬inputps��������һ��ͬ���Ĺ�һ��
[outputn,outputps]=mapminmax(output_train);
%% IV. BP�����紴����ѵ�����������
%%
% 1. ��������
%��һ������
net=newff(inputn,outputn,hiddennum);%�������㣬5����������Ԫ
%% �Ŵ��㷨������ʼ��
maxgen=20;                        %��������������������
sizepop=10;                       %��Ⱥ��ģ
pcross=0.2;                       %�������ѡ��0��1֮��
pmutation=0.1;                    %�������ѡ��0��1֮��

%�ڵ�����������������Ȩֵ��������ֵ�����������Ȩֵ�������ֵ
numsum=inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum;

lenchrom=ones(1,numsum);%���峤�ȣ���ʱ�����ΪȾɫ�峤�ȣ���1��numsum�еľ���      
bound=[-3*ones(numsum,1) 3*ones(numsum,1)];    %��numsum��2�еĴ������󣬵�1����-3����2����3

%------------------------------------------------------��Ⱥ��ʼ��--------------------------------------------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %����Ⱥ��Ϣ����Ϊһ���ṹ�壺10���������Ӧ��ֵ��10��Ⱦɫ�������Ϣ
avgfitness=[];                      %ÿһ����Ⱥ��ƽ����Ӧ��,һά
bestfitness=[];                     %ÿһ����Ⱥ�������Ӧ��
bestchrom=[];                       %��Ӧ����õ�Ⱦɫ�壬���������Ϣ
%��ʼ����Ⱥ
for i=1:sizepop
    %�������һ����Ⱥ
    individuals.chrom(i,:)=Code(lenchrom,bound);    %���루binary�������ƣ���grey�ı�����Ϊһ��ʵ����float�ı�����Ϊһ��ʵ��������
    x=individuals.chrom(i,:);
    %������Ӧ��
    individuals.fitness(i)=fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn);   %Ⱦɫ�����Ӧ��
end
%����õ�Ⱦɫ��
[bestfitness, bestindex]=min(individuals.fitness);%bestindex����Сֵ��������λ��/ĳ�����壩��bestfitness��ֵΪ��С��Ӧ��ֵ
bestchrom=individuals.chrom(bestindex,:);  %��õ�Ⱦɫ�壬��10����������ѡ����
avgfitness=sum(individuals.fitness)/sizepop; %Ⱦɫ���ƽ����Ӧ��(���и�����Ӧ�Ⱥ� / ������)
% ��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
trace=[avgfitness bestfitness]; %trace����1��2�У�avgfitness��bestfitness��������ֵ


%% ���������ѳ�ʼ��ֵ��Ȩֵ
% ������ʼ
for i=1:maxgen
    % ѡ��
    individuals=Select(individuals,sizepop); 
%     avgfitness=sum(individuals.fitness)/sizepop;%��Ⱥ��ƽ����Ӧ��ֵ
    %����
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop);
    % ����
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen,bound);
    
    % ������Ӧ�� 
    for j=1:sizepop
        x=individuals.chrom(j,:); %������Ϣ
        individuals.fitness(j)=fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn);  %����ÿ���������Ӧ��ֵ 
    end
    
    %�ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
    [newbestfitness,newbestindex]=min(individuals.fitness);%�����Ӧ��ֵ
    [worestfitness,worestindex]=max(individuals.fitness);
    
    % ���Ÿ������
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;%ȡ�������ģ��൱����̭
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness]; %��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
end
%% �����ų�ʼ��ֵȨֵ��������Ԥ��
w1=x(1:inputnum*hiddennum);
B1=x(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);
w2=x(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);
B2=x(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);

net.iw{1,1}=reshape(w1,hiddennum,inputnum);
net.lw{2,1}=reshape(w2,outputnum,hiddennum);
net.b{1}=reshape(B1,hiddennum,1);
net.b{2}=reshape(B2,outputnum,1);
%% BP����ѵ��
%�����������
net.trainParam.epochs=100;
net.trainParam.lr=0.1;
net.trainParam.goal=0.00001;

%����ѵ��
[net,per2]=train(net,inputn,outputn);

%% BP����Ԥ��
%���ݹ�һ��
inputn_test=mapminmax('apply',input_test,inputps);
an=sim(net,inputn_test);
test_simu=mapminmax('reverse',an,outputps);
error=test_simu-output_test;

%% V.�Ŵ��㷨������� 
figure(1)
[r, c]=size(trace);
plot([1:r]',trace(:,2),'b--');
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');ylabel('��Ӧ��');
legend('ƽ����Ӧ��','�����Ӧ��');
disp('��Ӧ��                   ����');

figure(2)
plot((output_test-test_simu)./test_simu,'-*');
title('������Ԥ�����ٷֱ�')

figure(3)
plot(error,'-*')
title('BP����Ԥ�����','fontsize',12)
ylabel('���','fontsize',12)
xlabel('����','fontsize',12)

%%�������ֵ
P_simdata = xlsread('simulatedata');
P_simdata = P_simdata(:,2:4)';
p_simdata = mapminmax('apply',P_simdata,inputps);
t_simdata = sim(net,p_simdata); %��������з���
T_simdata = mapminmax('reverse',t_simdata,outputps);

T_simdata = roundn(T_simdata',-1)

