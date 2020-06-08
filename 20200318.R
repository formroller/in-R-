# [ apply �ǽ� ���� ]
# �������� -> 2.R -> 3.�����ǽ� -> data -> apply_test2.csv
df1 <- read.csv('apply_test2.csv', stringsAsFactors = F)

rownames(df1) <- df1$name
df1$name <- NULL

# 0. �� ���ڿ� ���� ���� : ��ü���� => apply
str_trim(' 1234 ')
str_trim(df1)
df1[,] <- apply(df1, c(1,2), str_trim)

# 1. NA ó�� : ��ü���� => apply
# sol1) ����� ���� �Լ�
f1 <- function(x) {
  if (x=='-' | x=='?' | x=='.') {  # x %in% c('?','.','-')
    return(0)
  } else {
    return(x)
  }
}

f1('-')
f1(2222)
apply(df1, c(1,2), f1)
sapply(df1, f1)

# sol2) ġȯ �Լ�
str_replace_all('a.?b-','[.?-]','0')
str_replace_all(df1,'[.?-]','0')

df1[,] <- apply(df1, c(1,2), str_replace_all, '[.?-]','0')

# 2. õ���� ���б�ȣ ���� �� ���� ���� : ��ü���� => apply
f2 <- function(x) {
  as.numeric(str_remove_all(x,','))
}

apply(df1, c(1,2), f2)
df1[,] <- sapply(df1, f2)
str(df1)

# 3. �⵵�� �б� �и� : �������� => sapply
v_year <- substr(colnames(df1),2,5)
v_qt <- substr(colnames(df1),7,7)

f3 <- function(x,ord) {
  str_remove(str_split(x,'\\.')[[1]][ord],'X')
}

sapply(colnames(df1), f3, 1)
sapply(colnames(df1), f3, 2)

# ����) �� ������ 1�б� ������ �� ��
df1[ , str_detect(colnames(df1), '1$')]
apply(df1[ , v_qt == '1'], 1, sum)


# doBy ��Ű�� : �ַ� �׷쿡 ���� ������ �����ִ� �Լ� ����
install.packages('doBy')
library('doBy')

# ����
# 1. order(...,              # ������(���͵�)
#          na.last = ,       # NA ��ġ ����
#          decreasing = F)   # �������� ���� ����
# - ��°��� ���ĵ� ���Ͱ� �ƴ� ��ġ��
# - ��ġ���� ����� ������ ���ؼ��� ������� ��ġ�� ���� ��� ����

v1 <- c(10,1,3,2,9,5)
order(v1)
v1[order(v1)]

df1[order(df1[,1]), ] # �÷����� ��ġ���� ���� ������������ ���İ���

# 2. sort(x,                 # ������(����)
#         decreasing = F)    # �������� ���� ����
sort(v1)

sort(df1[,1])  # �÷����� �ٷ� ��µǼ� ������������ ���ķ� ���Ұ�

# [ ���� ���� ]
# 1. emp.csv ������ �а� ������ ū ������� �����Ͽ� ���
emp <- read.csv('emp.csv', stringsAsFactors = F)

v_ord <- order(emp$SAL, decreasing = T)  # �� ����
emp[v_ord, ]  # �� ����

# 2. �μ���ȣ ������ ����
# ��, ���� �μ��������� ������ ū ������� �����Ͽ� ���
v_ord <- order(emp$DEPTNO, emp$SAL, decreasing = c(F,T))
emp[v_ord, ]

# 1. doBy::orderBy
orderBy(formula = ,  # Y ~ X1 + X2 , .., -Xn
        data = )     # ������(������������)

orderBy( ~ DEPTNO - SAL, data = emp)
orderBy( ~ DEPTNO + SAL, data = emp)

# [ ���� ���� ] 
# student.csv ������ �а�
# ��,�� ������� �����͸� �����ϰ�, ���� ������������ Ű�� ������
std <- read.csv('student.csv', stringsAsFactors = F)
std$GD <- ifelse(substr(std$JUMIN,7,7)=='1','����','����')

v_ord <- order(std$GD, std$HEIGHT, decreasing = c(F,T))
std[v_ord, ]

orderBy( ~ GD - HEIGHT, data=std)

# 2. doBy::sampleBy
# sampling
1. sample(x,            # ������ 
          size = ,      # ������ ���� ������
          replace = ,   # �������⿩��
          prob = )      # �������

sample(1:150, size = 1)
sample(c(1,2,3,10,11,16), size = 1)

sample(1:2, size=150, replace = T, prob = c(0.7,0.3))
???
  
# [ ���� - iris �����͸� �����ϰ� 70%, 30% �� �׷����� �и� ]
# sol1)
v_rn <- sample(1:nrow(iris), size = nrow(iris) * 0.7)
iris_train <- iris[v_rn, ]
iris_test <- iris[-v_rn, ]


2. sampleBy(formula = , 
            frac = , 
            replace = ) 




# 3. doBy::summaryBy
# �� �÷� ��� �� ���
# 1. summary 
# - �����÷��� �ִ�,�ּ�,�� ������ �� ���
# - �����÷��� �� �׸� count
summary(iris)

# 2. summaryBy(formula = , # ����÷� ~  �׷��÷�
#              data = ,    # ������(������������)
#              FUN= )      # �����Լ�
# - ��ü �÷��� Ư�� �׷����� ������ ���
# - summaryó�� ���� ��� ������ �� ���� �� ���� ����

summaryBy(Sepal.Length ~ Species, data=iris)
summaryBy(Sepal.Length ~ Species, data=iris, FUN = max)
summaryBy(Sepal.Length + Sepal.Width ~ Species, 
          data=iris, 
          FUN=max)




