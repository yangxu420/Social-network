function [A, fullmatrix] = FreeScale1(n)
%% 生成m = 10，m0 =10，总节点数为N个的无标度网络，A是稀疏邻接矩阵
tic       %记录当前时间，与toc连用统计程序运行时间
%输入FreeScale1(200)，可建立一个初始结点为10，最终结点为200的无标度网络
m = 10;    %每次加入的边个数
m0 =10;    %初始的顶点个数
N = n;    %最终达到的顶点个数

A = sparse(N,N);     %创建邻接矩阵 全0，无边
for i=1:m0          %随机连边1表示有边
    for j= (i+1):m0
        A(i,j)= round(rand());     %round是四舍五入的算法
        A(j,i) =  A(i,j);   %这个网络初始对称       
    end
end   %初始完成
%加入的节点为 A(new) , 与其连接的点为old  生成 A(new,old)
for new = m0+1:N
    new;       %old vertice 度越大连接上的概率越大
    Degree = sum(A(1:new-1,1:new-1));%每个顶点的度
    DegreeInterval(1) = Degree(1);   %制造出一个度的分布区间，模拟概率
    for i=2:new-1
        DegreeInterval(i) = Degree(i)+DegreeInterval(i-1);
    end 
    %连接 新节点 与 m个old节点
    AllDegree = sum(sum(A(1:new-1,1:new-1))); %整个图的总度
    for i = 1:m 
        while 1
         %以概率从old节点中找到合适的顶点连接
         RandDegree  = fix(AllDegree*rand()+1); %要与度区间包含RandDegree的顶点相连
         %找到 符合 要求的区间所属顶点
         Ans = find(RandDegree <= DegreeInterval(1:new-1));
         old = Ans(1);
         if A(new,old) == 0
            A(new,old) = 1;
            A(old,new) = 1;
            break;         %成功连接
         end
        end
    end
end

%求度分布
    Degree = sum(A);  %完成后的网络的每个节点的度  2 3 2 2 4 3
    UniDegree = unique(Degree);   %去重后度       2 3 4
    for i = 1:length(UniDegree)
        DegreeNum(i) = sum(Degree==UniDegree(i));
    end
toc
    %画图
    loglog(UniDegree, DegreeNum ./ sum(DegreeNum),'.','markersize',18);
    xlabel('k'),ylabel('P(k)');
end

