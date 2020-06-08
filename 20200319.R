# sampling : ������ �м��� �ʿ�
# �ַ� raw data�� 70%�� train data(�� ������ �ʿ��� ������ ��),
# 30%�� test data(�� �򰡿� �ʿ��� ������ ��)���� �и��Ͽ� ���

# 1. sample(x, size,replace, prob)
# - �ַ� row number�� �ش��ϴ� ���ڸ� ����Ͽ� ����, ������ �и�
# - �ݴ� data set ������ ������(train ���� �� test ������ ����)
# - class�� ��Ȯ�� �յ� ���� �Ұ�(���� �յ�)

# [ ����- iris data�� 70,30%�� �и� ]
# 1) row number : sample size ������ ��Ȯ�ϰ� 70%
v_rn <- sample(1:nrow(iris), size = 0.7 * nrow(iris))
iris_train <- iris[v_rn, ]
iris_test <- iris[-v_rn, ]

table(iris_train$Species)    # class�� �յ� ���� ���� Ȯ��
table(iris_test$Species)  

# 2) group number : sample size ������ ���� 70%�� ����ϰ�
v_gn <- sample(1:2, size=nrow(iris), replace=T, prob=c(0.7,0.3))

iris_train2 <- iris[v_gn==1, ]
iris_test2  <- iris[v_gn==2, ]

# �� ������ ���� Ȯ��
nrow(iris_train2)   # 102��(���� �ٸ� != 105)
nrow(iris_test2)    # 48��(���� �ٸ� != 105)

# class�� �յ� ���� ���� Ȯ��
table(iris_train2$Species)    
table(iris_test2$Species)  

# 2. doBy::sampleBy(formula,   #  ~ �յ������� �ʿ��� �÷� 
#                   frac,      # �������
#                   replace,   # �������� ����
#                   data)      # ���� ������
# - �����Ϳ��� ���� frac�� �ش��ϴ� row�� ���� ����
# - row number ������ ���� �߰� ���� ���ʿ�
# - class�� ��Ȯ�� �յ� ���� ����
# - �ݴ� data set ������ ������
library(doBy)
iris_train3 <- sampleBy( ~ Species, data=iris, frac = 0.7)

nrow(iris_train3)           # ��Ȯ�� 70%�� sample size
table(iris_train3$Species)  # ��Ȯ�� �յ� ����

# [ ���� ���� ]
# sampleBy �Լ��� ����Ͽ� iris data�� ���� 70,30%�� �и�
iris_train3 <- sampleBy( ~ Species, data=iris, frac = 0.7)

# 1) 
f_split <- function(x) {
  as.numeric(str_split(x,'\\.')[[1]][2])
}

v_rn3 <- sapply(rownames(iris_train3), f_split)
iris_test3 <- iris[-v_rn3, ]

nrow(iris_test3)   # 45
table(iris_test3$Species)   # 15,15,15

# 2) 
v_rn4 <- as.numeric(str_remove_all(rownames(iris_train3),'\\D'))


# merge : �� �������������� ����
merge(x,           # ���δ��
      y,           # ���δ��
      by = ,       # �����÷�(���� ���� �̸� �÷��� ���)
      by.x = ,     # ù��° �������������� ���� �÷�
      by.y = ,     # �ι�° �������������� ���� �÷�
      all = ,      # full outer join ����
      all.x = ,    # left outer join ����
      all.y = )    # right outer join ����  

# - inner join�� �⺻ ����(���ο��꿡 ���� �ʴ� ������ ����)
# - �� �� ���� �����������Ӹ� ���� ����
# - non equi join �Ұ�
# - �����÷��� ���� ���� ���� ���ͷ� ��� ����

std <- read.csv('student.csv', stringsAsFactors = F)
pro <- read.csv('professor.csv', stringsAsFactors = F)

# [ ���� - �л� �����Ϳ� �������� �̸� �߰� ]
# 1) merge
merge(std, pro, by='PROFNO', all.x = T)

# 2) ����� �����Լ� ������ ���� ����
v_prof <- std[std$STUDNO == 9411, 'PROFNO']
pro[pro$PROFNO == v_prof, 'NAME']

f_name <- function(x) {
  v_prof <- std[std$STUDNO == x, 'PROFNO']
  if (is.na(v_prof)) {
    return(NA)
  } else {
    pro[pro$PROFNO == v_prof, 'NAME']
  }
}

sapply(std$STUDNO, f_name)

# [ ���� - emp.csv ������ �а� �� ������ ���������� �̸� ��� ]
emp <- read.csv('emp.csv', stringsAsFactors = F)
merge(emp, emp, by.x = 'MGR', by.y = 'EMPNO', all.x = T)


# [ �������� ]
# gogak, gift ���̺� �����͸� �����ͺ��̽��κ��� �ҷ��� ��,
# �� ������ ���ɻ�ǰ�� ���(������ R ��������)
library(RJDBC)

# get_query�� func1 ���̳ʸ� ���Ͽ� ����� ����� ���� �Լ���
load('func1')
gogak <- get_query('select * from gogak')
gift <- get_query('select * from gift')

f_gift <- function(x) {
  v_point <- gogak[gogak$GNO == x, 'POINT']
  gift[(gift$G_START <= v_point) & (v_point <= gift$G_END),'GNAME']
}

f_gift(20010020)
f_gift(gogak$GNO)
sapply(gogak$GNO, f_gift)

# �ִ밪 �ּҰ� ����
max(emp$SAL)       # ������ �ִ밪 ���� ����
which.max(emp$SAL) # ������ �ִ밪�� ���� �� ��ȣ ����

# [ ���� - emp.csv ���Ͽ��� �ִ� �������� �̸� ��� ]
emp[emp$SAL == max(emp$SAL), 'ENAME']
emp[which.max(emp$SAL), 'ENAME']

# aggregate 
# - group by ���� ����
# - ��� ��� ������ ������
# - ������ �ΰ��� ����

aggregate(x,   # ������
          by,  # group by �÷�(����Ʈ ����)
          FUN) # �����Լ�

aggregate(formula,  # ���� �÷� ~ group by �÷�
          data,     # ������������
          FUN)      # �����Լ�

# ������ 1��, group by �÷� 1��
# ����) emp ���̺������� �μ���ȣ�� ���� ���
aggregate(emp$SAL, by=list(emp$DEPTNO), FUN=mean)
aggregate(SAL ~ DEPTNO, data=emp, FUN=mean)

as.data.frame(tapply(emp$SAL, emp$DEPTNO, mean))

# ������ 2��, group by �÷� 1��
# ����) student ���̺����� �г⺰ Ű, ������ ���
aggregate(std[,c('HEIGHT','WEIGHT')], 
          by=list(std$GRADE), 
          FUN=mean)

aggregate(HEIGHT + WEIGHT ~ GRADE,      # +�� �÷� �߰��� �ؼ� X
          data=std, 
          FUN=mean)

aggregate(cbind(HEIGHT,WEIGHT) ~ GRADE, 
          data=std, 
          FUN=mean)


# ������ 1��, group by �÷� 2��
# emp ���̺����� �μ���, job�� sal�� ���
aggregate(emp$SAL, 
          by=list(emp$DEPTNO, emp$JOB), 
          FUN=mean)

aggregate(SAL ~ DEPTNO + JOB, 
          data=emp, 
          FUN=mean)


# [ ���� ���� ]
# student.csv ���ϰ� exam_01.csv ������ �а�
exam <- get_query('select * from exam_01')

# 1) �� �г⺰ ���輺���� ����� ���ϼ���.
# 2) �� �г⺰ �ְ������� ���� �л� �̸�, ����, �г� ���













