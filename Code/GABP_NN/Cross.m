function ret=Cross(pcross,lenchrom,chrom,sizepop)
%��������ɽ������
% pcorss                input  : �������
% lenchrom              input  : Ⱦɫ��ĳ���
% chrom                 input  : Ⱦɫ��Ⱥ
% sizepop               input  : ��Ⱥ��ģ
% ret                   output : ������Ⱦɫ��
 for i=1:sizepop  %ÿһ��forѭ���У����ܻ����һ�ν��������Ⱦɫ�������ѡ��ģ�����λ��Ҳ�����ѡ��ģ�%������forѭ�����Ƿ���н���������ɽ�����ʾ�����continue���ƣ�
     % ���ѡ������Ⱦɫ����н���
     pick=rand(1,2);   %����1��2�е����������
     while prod(pick)==0   %prod(A)�������Ƿ���0�������������������
         pick=rand(1,2);
     end
     index=ceil(pick.*sizepop);  %ceil(z)����������z�е�Ԫ��ȡ��,2.1��ȡ3
     % ������ʾ����Ƿ���н���
     pick=rand;
     while pick==0
         pick=rand;
     end
     if pick>pcross  
         continue;   %���������Ƚ�����ʴ������»ص�for��䣬��ִ����������
     end
     flag=0;    %������Ƚ������С��˵�����Խ���
     while flag==0
         % ���ѡ�񽻲�λ
         pick=rand;
         while pick==0
             pick=rand;
         end
         pos=ceil(pick.*sum(lenchrom)); %���ѡ����н����λ�ã���ѡ��ڼ����������н��棬ע�⣺����Ⱦɫ�彻���λ����ͬ
         pick=rand; %���濪ʼ
         v1=chrom(index(1),pos);%���ѡ��index(1)��Ⱦɫ���Լ�����λ��pos���������ֵȡ��
         v2=chrom(index(2),pos);
         chrom(index(1),pos)=pick*v2+(1-pick)*v1;%ʵ�����淨�����湫ʽ
         chrom(index(2),pos)=pick*v1+(1-pick)*v2; %�������
         flag1=test(chrom(index(1),:));  %����Ⱦɫ��1�Ŀ�����
         flag2=test(chrom(index(2),:));  %����Ⱦɫ��2�Ŀ�����
         if   flag1*flag2==0   %�������Ⱦɫ�岻�Ƕ����У������½���
             flag=0;
         else flag=1;
         end   
     end
 end
ret=chrom;