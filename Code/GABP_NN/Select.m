function ret=Select(individuals,sizepop)
% ��������ÿһ����Ⱥ�е�Ⱦɫ�����ѡ���Խ��к���Ľ���ͱ���
% individuals input  : ��Ⱥ��Ϣ
% sizepop     input  : ��Ⱥ��ģ
% ret         output : ����ѡ������Ⱥ

% ѡ�������Ϊ���������Ŵ��㷨��Ⱥ����Ĺؼ��Բ��裬�Ŵ��㷨��ѡ�����
% ͨ���Խϴ�ĸ��ʱ��������������嵽�Ӵ��У��Դ�ʹ����Ⱥ����Ӧ��ֵ��ѵķ��������

% ͨ�׵Ľ����ǣ������ɸ���ѡ����������ÿ�����������Լ���Ǳ����ֵ��������ѡ���ʱ�򲢲���ȫ���շ�ֵ�ĸߵ���ѡ
% ������һ���ĸ��ʽ��ܣ���ֵ�ߵĽ��ܸ��ʸߣ���ֵ�ϵͽ��ܵĸ���Ҳ�͡�

%���ݸ�����Ӧ��ֵ��������
fitness1=10./individuals.fitness;%10Ϊϵ����ȡ�����õ��µ�����fitness1����ֵԽ����屻ѡ�еĸ��ʾ�Խ��
%.*����./��ʾ�Ծ�����ÿ��Ԫ�ض�ִ��ͬ������
sumfitness=sum(fitness1);
sumf=fitness1./sumfitness;%ÿ�������Ŵ�����һ���ĸ��ʣ�1��sizepop��

index=[]; %������һ���Ǳ꣬�����Ǻż���
%�������̶ķ�ѡ���¸���
for i=1:sizepop   %תsizepop�����̣�%��ѡ��sizepop�����屣�����´�
    pick=rand;    %�������������pick
    while pick==0    %���������0�������²��������
        pick=rand;        
    end
    for j=1:sizepop    %ѭ��ÿ�����壬�ҳ��˴ε�rank�����ĸ����������
        pick=pick-sumf(j);   %Ѱ��rank�����ĸ��������ڵ����䣬���屻ѡ�еĸ���Խ������ռ����Խ��     
        if pick<0        %˵������j�ĸ��ʱȽϴ���Ӧ��ֵ��С��
            index=[index j];        %1��sizepop�еľ��󣬴�ű�ѡ�еĸ�����    
            break;  %Ѱ����������䣬�˴�ת����ѡ����Ⱦɫ��i��ע�⣺��תsizepop�����̵Ĺ����У��п��ܻ��ظ�ѡ��ĳЩȾɫ��
        end
    end
end

%�µ���Ⱥ
individuals.chrom=individuals.chrom(index,:);
individuals.fitness=individuals.fitness(index);
ret=individuals;