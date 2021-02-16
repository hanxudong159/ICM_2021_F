function error = fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn)
%�ú�������������Ӧ��ֵ
%x          input     Ⱦɫ����Ϣ
%inputnum   input     �����ڵ���
%outputnum  input     ������ڵ���
%net        input     ����
%inputn     input     ѵ����������
%outputn    input     ѵ���������
%error      output    ������Ӧ��ֵ

%��ȡ
w1=x(1:inputnum*hiddennum);%ȡ������������������ӵ�Ȩֵ����Code�������Ѿ���ֵ
B1=x(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);%��������Ԫ��ֵ
w2=x(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);%ȡ������������������ӵ�Ȩֵ
B2=x(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);%�������Ԫ��ֵ

%����Ȩֵ��ֵ
net.iw{1,1}=reshape(w1,hiddennum,inputnum);%��w1��1��inputnum*hiddennum��תΪhiddennum��inputnum�еĶ�ά����
net.lw{2,1}=reshape(w2,outputnum,hiddennum);%���ľ���ı����ʽ
net.b{1}=reshape(B1,hiddennum,1);%1��hiddennum�У�Ϊ���������Ԫ��ֵ
net.b{2}=reshape(B2,outputnum,1);

%�����������
net = newff(inputn,outputn,hiddennum);
net.trainParam.epochs=20;%��������
net.trainParam.lr=0.1;%ѧϰ��
net.trainParam.goal=0.00001;%��СĿ��ֵ���
net.trainParam.show=100;
net.trainParam.showWindow=0;

%����ѵ��
net=train(net,inputn,outputn);

an=sim(net,inputn);
error=sum(abs(an-outputn));%Ⱦɫ���Ӧ����Ӧ��ֵ
