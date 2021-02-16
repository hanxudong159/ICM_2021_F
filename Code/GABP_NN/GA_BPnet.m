clear all
clc

temp=xlsread('traindata');

inputnum=3;
hiddennum=8;
outputnum=1;

input_train = temp(1:2:351,1:3)';
input_test  = temp(2:2:350,1:3)';

output_train = temp(1:2:351,4)';
output_test = temp(2:2:350,4)';

[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);

net=newff(inputn,outputn,hiddennum);

maxgen=20;
sizepop=10;
pcross=0.2;
pmutation=0.1;


numsum=inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum;

lenchrom=ones(1,numsum);   
bound=[-3*ones(numsum,1) 3*ones(numsum,1)];

individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);
avgfitness=[];
bestfitness=[];
bestchrom=[];

for i=1:sizepop
    individuals.chrom(i,:)=Code(lenchrom,bound);
    x=individuals.chrom(i,:);
    individuals.fitness(i)=fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn);
end

[bestfitness, bestindex]=min(individuals.fitness);
bestchrom=individuals.chrom(bestindex,:);
avgfitness=sum(individuals.fitness)/sizepop;

trace=[avgfitness bestfitness];

for i=1:maxgen
    individuals=Select(individuals,sizepop); 
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop);
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen,bound);
    for j=1:sizepop
        x=individuals.chrom(j,:);
        individuals.fitness(j)=fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn);
    end
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);

    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness];
end

w1=x(1:inputnum*hiddennum);
B1=x(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);
w2=x(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);
B2=x(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);

net.iw{1,1}=reshape(w1,hiddennum,inputnum);
net.lw{2,1}=reshape(w2,outputnum,hiddennum);
net.b{1}=reshape(B1,hiddennum,1);
net.b{2}=reshape(B2,outputnum,1);
net.trainParam.epochs=100;
net.trainParam.lr=0.1;
net.trainParam.goal=0.00001;

[net,per2]=train(net,inputn,outputn);

inputn_test=mapminmax('apply',input_test,inputps);
an=sim(net,inputn_test);
test_simu=mapminmax('reverse',an,outputps);
error=test_simu-output_test;

figure(1)
[r, c]=size(trace);
plot([1:r]',trace(:,2),'b--');

figure(2)
plot((output_test-test_simu)./test_simu,'-*');

figure(3)
plot(error,'-*')

P_simdata = xlsread('simulatedata');
P_simdata = P_simdata(:,2:4)';
p_simdata = mapminmax('apply',P_simdata,inputps);
t_simdata = sim(net,p_simdata);
T_simdata = mapminmax('reverse',t_simdata,outputps);

T_simdata = roundn(T_simdata',-1)

