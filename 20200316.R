# �����Լ� : �ݺ������� �����ִ� �Լ�
# 1. apply(X,
#          MARGIN,
#          FUN,
#          ...)
# - X���� 1����(����) �����Ͱ� �� �� ����(2���� �̻� ���밡��)
# - �ַ� �ະ, ���� �ݺ������� �����ϱ� ���� �Լ�
# - R������ 2���� �������� "���Һ�" ���뵵 ����
# - ��°���� ����, ����, ���, �迭
# - ������������ ��� �Ұ�

# ����) iris �����Ϳ��� �� �÷��� ���
apply(iris[,-5], 2, mean)
apply(iris[,-5], 1, mean)

# ����) ������ ���Ϳ� õ���� ���б�ȣ ����(�����Լ� ���)
v1 <- c('1,100', '2,200')

apply(v1, c(1,2), str_replace_all,',','')  # �������� �Ұ�
sapply(v1,str_replace_all,',','')          # �������� ����

# [ ���� : apply ���� ����� ���� ������ �����ӿ� �����ϴ� ��� ]
df1 <- data.frame(a=c('1,000','2,000'),
                  b=c('3,000','4,000'),
                  stringsAsFactors = F)

rownames(df1) <- c('A','B')

df1 <- apply(df1,c(1,2), str_remove_all,',')
df1[,] <- apply(df1,c(1,2), str_remove_all,',')
class(df1)

# 2. lapply(list, function, ...)
# - ���Һ� ���� ����
# - ��°�� �ַ� ����Ʈ
lapply(df1,str_remove_all,',')

# 3. sapply(list, function, ...)
# - �ַ� ������ ���Һ� �Լ� ����, 2���� ���� ����
# - ��� ��� �ַ� ����
# - �Լ��� �߰��� ���� ���� ����
sapply(df1,str_remove_all,',')

# 4. tapply(vector,    # ������
#           index,     # group by �÷�
#           function)  # �����Լ�

# - oracle group by ��ɰ� ���
# - �׷� �÷�, �׷��� ǥ���ϴ� ���͸� index�� ����
# - ��°�� �ַ� ����

tapply(iris$Sepal.Length, iris$Species, mean)
tapply(iris$Sepal.Length, iris$Species == 'setosa', mean)

tapply(iris[,-1], iris$Species, mean)   # 2���� ���� �Ұ�

iris$Species == 'setosa'

# [ ���� ���� ]
# emp.csv ������ �а�
emp <- read.csv('emp.csv', stringsAsFactors = F)

# 1) �μ��� ��տ���
tapply(emp$SAL, emp$DEPTNO, mean)

# 2) ��/�Ϲݱ� �Ի����� ��տ���
tapply(emp$SAL, 
       as.numeric(substr(emp$HIREDATE,6,7)) < 7, 
       mean)

# 5. mapply(function, ...)
mapply(str_remove_all,df1,',')

# [ ���� ���� ]
# 2000-2013��_���ɺ��Ǿ���_40-49��.csv ������ �а�
# 2005��~2009�⿡ ���� �� ����, �⵵�� �Ǿ��� ���
# ��, �⵵ ������ �⵵�� ����Ͽ� ǥ��, ��) year >= 2005
df2 <- read.csv('2000-2013��_���ɺ��Ǿ���_40-49��.csv')

# �÷��̸� ����
colnames(df2)[-1] <- substr(colnames(df2)[-1],2,5)
colnames(df2)[-1] <- str_remove_all(colnames(df2)[-1],'[X��]')

# �⵵�� ���
apply(df2[,-1], 2, mean)

df2[1,2] <- NA
apply(df2[,-1], 2, mean, na.rm=T)

# �Ϻ� ���
df2[1,2] <- 4
apply(df2[,-1], 1, mean)

# [ �����Լ� �� ]
# 1���� ������ ���� ��
apply - �Ұ�
sapply, lapply, mapply ����

# 2���� ������ ���Һ� ���� ��
df3 <- data.frame(a=1:5,b=6:10)

f1 <- function(x) {
  return(x+10)
}

f2 <- function(x) {
  if (x <= 5) {
    return(x*10)
  } else {
    return(x*20)
  }
}

apply(df3,c(1,2),f1)
sapply(df3,f1)
lapply(df3,f1)
mapply(f1, df3)

apply(df3,c(1,2),f2)  # ���Һ� ����(1:1 ġȯ)
sapply(df3,f2)        # key�� ����
lapply(df3,f2)        # key�� ����
mapply(f2, df3)       # key�� ����

# [ ���� ���� ]
# apply_test.csv ������ �а�
# �μ��� �Ǹŷ��� �� ���� ���ϼ���.
# ��, �� ���� -�� ���� 0���� ġȯ �� ���
# (ġȯ�Լ��� �������� Ǯ��)
df1 <- read.csv('apply_test.csv', stringsAsFactors = F)

# step1) NAġȯ
ifelse(is.na(df1), 0, df1)     
str_replace_all(df1,'-','0')

f1 <- function(x) {
  if (is.na(x) | x == '-') {
    return(0)
  } else {
    return(x)
  }
}

df1[,] <- apply(df1, c(1,2), f1)  # 2������ ���� ���Һ� ���� ����
sapply(df1, f1)                   # 2������ ���� ���Һ� ���� �Ұ�

# step2) 2010~2013 �� ��
str(df1)

as.numeric(df1[,-1])                      # 2���� ���� �Ұ�
df1[,-1] <- sapply(df1[,-1], as.numeric)  # 2���� ���� ����
df1$total <- apply(df1[,-1], 1, sum)

# step3) �μ���ȣ ����
str_split("10-smith",'-')[[1]][1]

f2 <- function(x) {
  str_split(x,'-')[[1]][1]
}

df1$deptno <- sapply(df1$deptno.name,f2)

# step4) �μ��� �� ��
tapply(df1$total, df1$deptno, sum)



# [ ���� : sapply�� 2���� �����ͼ¿� ���� ������ ��� ]
sapply(data.frame, function)

# 1. data.frame�� ù��° �÷��� ������������ function�� ����
# 2. function�� ���͸� ���޹޾� ���͸� �����ϸ� ���డ��
#               ���͸� ���޹޾� ���Ϳ��� �Ұ��ϸ� ����Ұ�

# ex) 
f3 <- function(x) {
  if (x < 1.1) {
    return(1)
  } else {
    return(2)
  }
}

sapply(iris[,-5],sum)  # O
sapply(iris[,-5],f3)   # X












