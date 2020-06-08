# plyr ��Ű�� 
# - apply �迭 �Լ���� ���
# - ��� ��� �ַ� ������ ������
# - {�Է�}{���}ply ������ �Լ� ����
# - adply : array�Է� - dataframe ���
# - ddply : dataframe �Է� - dataframe ���

install.packages('plyr')
library(plyr)

# 1. adply
# - 2���� ������ �� �Է�(array, matrix, data.frame ����)
# - data.frame ���
# - apply�Լ��� ���(�ະ, ���� �׷쿬�� �ַ� ����)
# 

apply(iris[,-5], 1, mean)
apply(iris[,-5], 2, mean)

adply(iris[,-5], 1, sum) # �÷��߰� ������ ����, 
                         # ���������Ϳ� �Բ� ��� 
adply(iris[,-5], 2, sum) # �ο��߰� ������ �Ұ�
                         # ���������Ϳ� �Բ� ��� �Ұ�

# [ �߿� : adply�� mean�Լ��� NA�� ���ϵǴ� ���� ]
adply(iris[,-5], 1, mean)

# ����) ������������ �Է½� �и��� ������ ���� ������������,
#       �� ������������ �������� �Լ��� ����(����)��

v1 <- 1:10
df1 <- data.frame(v1)

sum(v1)
sum(df1)

mean(v1)
mean(df1)

# �ذ�) �Է� �����ͼ��� key���� Ż��, matrix �������� ����
adply(as.matrix(iris[,-5]), 1, mean)


# 2. ddply
# - data.frame �Է�, data.frame ���
# - �׷쿬�� ���� �Լ�

# ���� 
# ddply(data,       # ������������
#       variables,  # group by �÷� .(col1, col2)���� ����)
#       fun,        # ddply �����Լ�
#       ...)        # group by ǥ���� 

# ddply �����Լ�
# 1. transform : ���� �����������ӿ� �׷쿬�� ������ ���� ǥ��
# 2. mutate    : transform�� ����ϳ� ������ ���� ����
# 3. summarise : �Ϲ� group by �����Լ�, �׷쿬���� ������� ���
# 4. subset    : �׷쿬�� �������� ���� ���� ����

# [ ���� - emp�����Ϳ��� �μ��� ��տ��� ] 
ddply(emp, DEPTNO, summarise, v1=mean(SAL))
ddply(emp, .(DEPTNO), summarise, v1=mean(SAL))
ddply(emp, .(DEPTNO), transform, v1=mean(SAL))

# [ ���� - emp�����Ϳ��� �μ��� �ִ� ������ ��� ] 
# 1)
df_max <- ddply(emp, .(DEPTNO), transform, sal_max=max(SAL))
df_max[,c(1,2,6,7,8,9)]

df_max[df_max$SAL == df_max$sal_max, ]

# 2) 
ddply(emp, .(DEPTNO), subset, SAL==max(SAL))

# [ ���� - emp �����Ϳ��� �� �μ��� ��տ����� ���ϰ�, log�� ����]
ddply(emp, .(DEPTNO), transform, v1=mean(SAL))
ddply(emp, .(DEPTNO), transform, v1=mean(SAL),
                                 v2=log(v1))   # v1 ���� �Ұ�

ddply(emp, .(DEPTNO), mutate, v1=mean(SAL),    # v1 ���� ����
                              v2=log(v1))

# [ �������� ]
# 1. emp�����Ϳ��� �μ��� ��տ������� ���� ������ �޴� ��� ���
ddply(emp, .(DEPTNO), subset, SAL < mean(SAL))

# 1. student �����͸� �а� 
std <- read.csv('student.csv', stringsAsFactors = F)

# 1) �� �г⺰ �������� �ִ� �� ���
tapply(std$WEIGHT, std$GRADE, max, na.rm=T)
aggregate(WEIGHT~GRADE, data=std, max, na.rm=T)
ddply(std, .(GRADE), summarise, V1=max(WEIGHT, na.rm=T))

# 2) Ű�� �г⺰ ��� Ű���� ���� �л� ���
ddply(std, .(GRADE), subset, HEIGHT < mean(HEIGHT))

# 3) �� �г⺰ ������, Ű�� �ִ� �� ���
# (�׷쿬�� �÷� �ΰ� �̻��� ���)
aggregate(cbind(HEIGHT,WEIGHT)~GRADE, data=std, max)
ddply(std, .(GRADE), summarise, V1=max(HEIGHT),
                                V2=max(WEIGHT))

# [���� - ���� �ٸ� �׷� �����Լ� ���� ]
aggregate(cbind(HEIGHT,WEIGHT)~GRADE, data=std, c(max,min)) # �Ұ�
ddply(std, .(GRADE), summarise, V1=max(HEIGHT),
                                V2=min(WEIGHT))             # ����

# [ �������� ] 
# delivery.csv ������ �а�
# �� ���鵿�� ��ȭ�Ǽ��� �� ���� ���ϵ�, 
# (��, �� ���� ���ڸ� �����ϰ� �ִ� ��� 
# ���ڸ� ������ ������ ǥ���ϵ��� �� (ex ������6�� => ������))
library(stringr)
unique(de$���鵿)

str_remove_all(de$���鵿,'[0-9��]')
str_split(de$���鵿[990],'[0-9]')[[1]][1]

f1 <- function(x) {
  str_split(x,'[0-9]')[[1]][1]
}

de$���鵿 <- sapply(de$���鵿, f1)
unique(de$���鵿)

ddply(de, .(���鵿), summarise, CNT=sum(��ȭ�Ǽ�))


# ������ ���� ���� : stack, unstack
# 1. stack(x) : wide -> long �����ͷ� ����
# 2. unstack(data, formular) : long -> wide �����ͷ� ����

# ��) �� ������ �б⺰ �Ǹŷ� ������
# wide data
# - ���� ���̺�
# - �ະ, �÷��� �׷쿬�� ���� ����
# - ���κҰ�

#     1  2  3  4
# A  10 11 ...
# B
# C
# D

# long data(tidy data)
# - database���� ��ȣ�ϴ� ������ ����
# - ���ο� ������(�������)�� ���� �߰��� ���� ����
# - group by ���� ����
# - ���� ���� ����

# ���� �б� �Ǹŷ�
# A    1     10      
# A    2     11  
# ....
# D    4     20


# [ ���� - ������ ������ �����ӿ� ���� stack, unstack ó�� ]
df1 <- data.frame(apple=c(10,20,30), 
                  banana=c(11,9,8), 
                  mango=c(3,4,5))
df2 <- stack(df1)
unstack(df2, values ~ ind)

# [ ���� ���� ]
# melt_ex.csv ������ �а� ���� ������ ���� �Ʒ��� ���� ���̺� �ϼ�
#         1   2   3  4  5 ....   12
# 2000  400 401 402  .
# 2001  412

df2 <- read.csv('melt_ex.csv')
df3 <- unstack(df2, latte ~ mon)
rownames(df3) <- c(2000,2001)
colnames(df3) <- str_c(1:12,'��')

# reshape2 : melt, dcastó�� ������ ���� ������ ���� �ʿ��� ��Ű��
# 1. melt 
# - wide -> long ������ ����
# - stack�� ���
# - ��ü �÷��� �ƴ� �Ϻ��÷� ���� �� ���� ����
install.packages('reshape2')
library(reshape2)

melt(data,            # ������������
     id.vars,         # ���� ���� ���� �÷�
     measure.vars,    # ���� �÷�, ������ id.vars ���� ��� ����
     value.name = ,   # value �÷� �̸�
     variable.name =) # ind �÷� �̸�         

# [ ���� - �� melt_ex.csv ������ ������ ���� �������� ���� ]
# year mon  name qty
# 2000   1 latte 400 
melt(df2, id.vars = c('year','mon'),
     variable.name = 'name',
     value.name = 'qty')

# [ ���� ���� ] 
# 2000-2013��_���ɺ��Ǿ���_40-49��.csv ������ �а�
# �ش� �����͸� �⵵�� ���� ������ ����(tidy)�� ���
df4 <- read.csv('2000-2013��_���ɺ��Ǿ���_40-49��.csv')
melt(df4, id.vars = '��', variable.name = '�⵵',
                          value.name = '�Ǿ���')


