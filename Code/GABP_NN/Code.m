function ret=Code(lenchrom,bound)
%���������������룬���������ʼ��һ����Ⱥ
% lenchrom   input : Ⱦɫ�峤�ȣ���ʵ����1��21�еľ���
% bound      input : ������ȡֵ��Χ
% ret        output: Ⱦɫ��ı���ֵ
flag=0;
while flag==0
    pick=rand(1,length(lenchrom));%length�õ�һ��������ϴ����������������lenchrom��1��numsum�о���ʷ���numsum����pick��1��numsum�е����������
    %bound(:,1)'Ϊȡ1��numsum�е�ֵ����-3��bound(:,2)Ϊȡnumsum�е�2�е�ֵ����3��(bound(:,2)-bound(:,1))'�õ�1��numsum�о���Ϊ6����pick���Ԫ�����
    ret=bound(:,1)'+(bound(:,2)-bound(:,1))'.*pick; %���Բ�ֵ����������ʵ����������ret�У�ret��1��numsum�еľ���
    flag=test(ret);     %����Ⱦɫ��Ŀ�����
end