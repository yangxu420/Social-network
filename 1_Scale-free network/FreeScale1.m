function [A, fullmatrix] = FreeScale1(n)
%% ����m = 10��m0 =10���ܽڵ���ΪN�����ޱ�����磬A��ϡ���ڽӾ���
tic       %��¼��ǰʱ�䣬��toc����ͳ�Ƴ�������ʱ��
%����FreeScale1(200)���ɽ���һ����ʼ���Ϊ10�����ս��Ϊ200���ޱ������
m = 10;    %ÿ�μ���ı߸���
m0 =10;    %��ʼ�Ķ������
N = n;    %���մﵽ�Ķ������

A = sparse(N,N);     %�����ڽӾ��� ȫ0���ޱ�
for i=1:m0          %�������1��ʾ�б�
    for j= (i+1):m0
        A(i,j)= round(rand());     %round������������㷨
        A(j,i) =  A(i,j);   %��������ʼ�Գ�       
    end
end   %��ʼ���
%����Ľڵ�Ϊ A(new) , �������ӵĵ�Ϊold  ���� A(new,old)
for new = m0+1:N
    new;       %old vertice ��Խ�������ϵĸ���Խ��
    Degree = sum(A(1:new-1,1:new-1));%ÿ������Ķ�
    DegreeInterval(1) = Degree(1);   %�����һ���ȵķֲ����䣬ģ�����
    for i=2:new-1
        DegreeInterval(i) = Degree(i)+DegreeInterval(i-1);
    end 
    %���� �½ڵ� �� m��old�ڵ�
    AllDegree = sum(sum(A(1:new-1,1:new-1))); %����ͼ���ܶ�
    for i = 1:m 
        while 1
         %�Ը��ʴ�old�ڵ����ҵ����ʵĶ�������
         RandDegree  = fix(AllDegree*rand()+1); %Ҫ����������RandDegree�Ķ�������
         %�ҵ� ���� Ҫ���������������
         Ans = find(RandDegree <= DegreeInterval(1:new-1));
         old = Ans(1);
         if A(new,old) == 0
            A(new,old) = 1;
            A(old,new) = 1;
            break;         %�ɹ�����
         end
        end
    end
end

%��ȷֲ�
    Degree = sum(A);  %��ɺ�������ÿ���ڵ�Ķ�  2 3 2 2 4 3
    UniDegree = unique(Degree);   %ȥ�غ��       2 3 4
    for i = 1:length(UniDegree)
        DegreeNum(i) = sum(Degree==UniDegree(i));
    end
toc
    %��ͼ
    loglog(UniDegree, DegreeNum ./ sum(DegreeNum),'.','markersize',18);
    xlabel('k'),ylabel('P(k)');
end

