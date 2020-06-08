# [ ���� - �������� ������ ������ ����� ]
install.packages('xlsx')
library(xlsx)

# 1. read.xlsx(���ϸ�, ��Ʈ��ȣ)
read.csv('emp_1.xlsx')    # ���� �߻�
read.xlsx('emp_1.xlsx',1) # ���� �ε� 

# 2. write.xlsx(�����������Ӹ�, ���������ϸ�)



# reshape2
# 1. melt : stack ó��
# 2. dcast : unstack ó��**

help("dcast")

dcast(data,                 # ������������          
      formula,              # ����� ~ �÷� ���� 
      fun.aggregate = NULL, # ����Լ�
      ...
      value.var = )         # value �÷�

d1 <- read.csv('dcast_ex1.csv')
d2 <- read.csv('dcast_ex2.csv')
d3 <- read.csv('dcast_ex3.csv')

# case1) �������̺� ����
dcast(d1, year + name ~ info, value.var = 'value')

# case2) value �÷��� �������� ���
dcast(d2, year ~ name ) # value.var ������ �� ������ �����÷�
dcast(d2, year ~ name, value.var = 'qty')

# case3) �������̺� ������ ���� �� ���� �������� ���
# ����) dcast_ex3.csv ������ �а� �⵵�� �̸��� �������̺�
dcast(d3, �⵵ ~ �̸�)      # fun.aggregate ������ count ���
dcast(d3, �⵵ ~ �̸�, sum) # ��� �ʿ�� fun.aggregate ����

# [ ���� - �ະ, �÷��� ����� ]
dcast(d3, �⵵ ~ �̸�, sum, margins=T)
dcast(d3, �⵵ ~ �̸�, mean, margins=T)

# [ ���� ���� ]
# ��ݱ���������������Ȳ_new.csv ������ 
# ������ ���� �������̺��� ǥ��
#       1     2     3     4     5     6
#�ڵ��� 1     0.85 0.75  0.98  0.92  0.97
#�ְ�� 0.90 0.92  0.68  0.87  0.89  0.89

df_new <- read.csv('��ݱ���������������Ȳ_new.csv', 
                   stringsAsFactors=F)
df_new2 <- dcast(df_new, �̸� ~ ��)

# [ ���� - �� �����Ϳ��� ����� ���뵵 ��� ]
apply(df_new2[,-1],1,mean)
rowSums(df_new2[,-1])
rowMeans(df_new2[,-1])
colSums(df_new2[,-1])
colMeans(df_new2[,-1])

# [ ���� ���� ]
# subway2.csv ������ �а� ����, �ð��뺰 �������� �� ���� ���

sub <- read.csv('subway2.csv', skip = 1, 
                stringsAsFactors = F,
                na.strings = '')

# [ ���� - ���̽� fillna ��ü �Լ� in R ]
install.packages('zoo')
library(zoo)
zoo::na.locf(����)

na.locf(sub$��ü)

# step1) ���̸� ������ ��������
sub$��ü <- na.locf(sub$��ü)

# step2) õ���� ���б�ȣ ���� �� ���� ����
f2 <- function(x) {
  as.numeric(str_remove_all(x,','))
}

sub[, -c(1,2)] <- apply(sub[, -c(1,2)], c(1,2), f2)


# step3) �ð��� ���� �÷� stack ó��
ddply(sub, .(��ü), summarise, v1=sum(X05.06), 
                               v2=sum(X06.07))  # �׷쿬�� ����

sub2 <- melt(sub, id.vars = c('��ü','����'),
                  variable.name='�ð�', value.name='��')

sub2$�ð� <- as.numeric(substr(sub2$�ð�,2,3))

# step4) ����, �ð��뺰 ������ �� ��
ddply(sub2, .(��ü,�ð�), summarise, CNT=sum(��))
dcast(sub2, ��ü ~ �ð�, sum)


# [ dplyr ��Ű�� : �������� �Լ��� ���, ����ȭ�� ��ó�� ]
install.packages('dplyr')
library(dplyr)

# 1. select : �÷� ����        
# 2. mudate : �÷� ����
# 3. filter : �� ����
# 4. group_by : �׷쿬��(�׷��θ�)
# 5. arrange : ����
# 6. summarise_each : �׷쿬���� ���� ��������

emp <- read.csv('emp.csv', stringsAsFactors = F)


# ����1) emp ���̺����� �̸�, ����, �μ���ȣ�� ���
emp %>%
  select(ENAME, SAL, DEPTNO)

# ����2) emp ���̺����� 10�� �μ� �������� ���
emp %>%
  select(ENAME, SAL, DEPTNO) %>%
  filter(DEPTNO==10)


# ����2) emp ���̺����� comm�� NA�� �ƴ�
emp %>%
  select(ENAME, SAL, DEPTNO) %>%
  filter(!is.na(COMM)) # select ���� ����� COMM�� ���Ե���
                       # �ʾұ� ������ ���� ����

emp %>%
  select(ENAME, SAL, DEPTNO, COMM) %>%  # select�� ����
  filter(!is.na(COMM))

emp %>%
  filter(!is.na(COMM)) %>%   # filter�� ���� �����ϵ��� 
  select(ENAME, SAL, DEPTNO)
  

# ����3) emp ���̺����� 10�� ������ 10% �λ�� ���� ���
emp %>%
  select(ENAME, SAL, DEPTNO) %>%
  filter(DEPTNO==10) %>%
  mutate(v1=SAL*1.1)

# [ ���� ���� ]
# student.csv ������ �а�
std <- read.csv('student.csv', stringsAsFactors = F)

# 1. �� �л��� �̸�, �г�, ������ȣ ���
std %>%
  select(NAME, GRADE, PROFNO)

# 2. �� ������ ������ȣ�� ���� �л��� ����
std %>%
  select(NAME, GRADE, PROFNO) %>%
  filter(!is.na(PROFNO))

# 3. �� ������ �� �л��� ���� �÷� �߰��Ͽ� ���
std %>%
  select(NAME, GRADE, PROFNO, JUMIN) %>%
  filter(!is.na(PROFNO)) %>%
  mutate(V1=ifelse(substr(JUMIN,7,7)=='1','��','��'))


# ����4) �� �����Ϳ��� �г⺰ ���� 
std %>%
  select(NAME, GRADE, PROFNO, JUMIN) %>%
  filter(!is.na(PROFNO)) %>%
  mutate(V1=ifelse(substr(JUMIN,7,7)=='1','��','��')) %>%
  arrange(desc(GRADE), V1)

# ����5) �г⺰ Ű ���
std %>%
  select(NAME, GRADE, HEIGHT) %>%
  group_by(GRADE) %>%
  summarise_each(mean, HEIGHT)
  
# [ ���� ���� ]
# 1. crime.csv ������ �а�, 
# 1) ���� �⵵�� �߻� ��Ȳ ���(�������̺�)
# 2) ���� �⵵�� �˰����� ��Ȳ ���(�������̺�)

# 2. kimchi_test.csv ������ �а�
# 1) 1�� �Ѱ���ġ�� ������Ʈ �Ǹŷ��� �Ǹűݾ� ���(dplyr)
# 2) �⵵�� ���� ��ü �Ǹŷ��� �� �� ���(dplyr)





