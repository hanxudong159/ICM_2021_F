function flag=test(code)
%�ж���ֵ��Ȩֵ�Ƿ񳬽�
% lenchrom   input : Ⱦɫ�峤��
% bound      input : ������ȡֵ��Χ
% code       output: Ⱦɫ��ı���ֵ
% x=code; %�Ƚ��룬x��1��numsum�еľ���
% flag=1;
f1=isempty(find(code>3, 1));%isempty(A)��AΪ�գ��򷵻�1�����򷵻�0�����3��ʵ��bound�ı߽�ֵ��
f2=isempty(find(code<-3, 1));%find����������������򷵻�Ԫ��λ�ã�������1��Ϊ���ó������Ѱ��Ч��
%fine(code<-3)�ܹ��ҳ���������������Ԫ��λ�ã�������ֻ��Ҫ���code<-3�ͺ���û��Ҫ�ҵ�ȫ���������find(code<-3,1)
if f1*f2==0     %�л���Ȩֵ������ֵ�����磬����0�ó������±���
    flag=0;
else
    flag=1;%�����������������1��������
end
% if (x(1)<0)&&(x(2)<0)&&(x(3)<0)&&(x(1)>bound(1,2))&&(x(2)>bound(2,2))&&(x(3)>bound(3,2))
%     flag=0;
% end 