# ������ ���� ���� �Լ�
to_char(1234,'09999') => '01234'
to_char(1234,'99999') => ' 1234'

# sprintf
sprintf(fmt,   # ��������(s:���ڿ�, d:����, f:�Ǽ�)
        data)

sprintf('%2d',2)     # 2�� ���ڸ� ���ڿ��� ����, ��ĭ����
sprintf('%02d',2)    # 2�� ���ڸ� ���ڿ��� ����, 0����
sprintf('%.2f',1234) # ���ڸ� �Ҽ��� ǥ�� 

# ����) movie �������� �� �÷��� ���ڸ��� ǥ��
str_pad(movie$��, 2, 'left', '0')
sprintf('%02d',movie$��) 

v_mon <- sprintf('%02d',movie$��)
v_day <- sprintf('%02d',movie$��)
as.Date(str_c(movie$��, v_mon, v_day), '%Y%m%d')

# [ ���� ���� ]
# movie ������ �а� ���ɴ뺰 �̿���� ���� ���� ������ 
# �̿���� �Բ� ���
library(doBy)
aggregate(�̿�_����... ~ ���ɴ�, data = movie, FUN = mean)

df1 <- aggregate(�̿�_����... ~ ���ɴ� + day, 
                data = movie, 
                FUN = mean)

df2 <- aggregate(�̿�_����... ~ ���ɴ�, data = df1, FUN = max)

merge(df1,df2, by=c('���ɴ�','�̿�_����...'))

# 2. card_history.csv ������ �а� ������ ���� �Ϻ� ���� ������� ���
# (�ķ�ǰ �� 1�� ���� ����, �ķ�ǰ �� 2�� ��������� �ǹ�..)
# ��, ������ ����� �ʿ� ���� Ȯ�θ�..
card <- read.csv('card_history.csv', stringsAsFactors = F)

# NUM   �ķ�ǰ     �Ǻ�    �ܽĺ�      å��  �¶��μҾװ���    �Ƿ��
#    1 2.438718 3.622362  3.056148  3.068783       3.005904 3.0303030
#    2 2.790698 3.049877  2.487562  2.751323       1.771337 2.0517677
#    3 3.092395 2.241812  2.665245  2.328042       4.025765 2.6199495
#    4 2.803268 3.161334  2.736318  8.253968       2.093398 4.4349747
#    
# ����    100      100       100       100 

# step1) õ�������б�ȣ ���� �� ���ں���
f1 <- function(x) {
  as.numeric(str_remove_all(x,','))
}

card[,] <- apply(card, c(1,2), f1)

# step2) �� ���� ���ϱ�
# sol1) �� �÷����� ���� ���
card$�ķ�ǰ / sum(card$�ķ�ǰ) * 100
card$�Ǻ� / sum(card$�Ǻ�) * 100
....
card$�Ƿ�� / sum(card$�Ƿ��) * 100

# sol2) �����Լ� ����Ͽ� ��ü ����
f2 <- function(x) {
  x / sum(x) * 100
}

apply(card[, -1], 2, f2)
card[, -1] <- sapply(card[, -1], f2)

apply(card, 2, sum)

# [ ���� - �� �����͸� �Ϻ� �� ǰ���� ��������� ���� ]
t(apply(card[, -1], 1, f2))


# sqldf
# - R���ο��� sql ������ ���� ������ ó�� �����ϰ� �ϴ� �Լ�
# - ansi ǥ��, oracle ǥ�� ��� ���� ����
# - ��� ���޵��� �ʴ� ǥ���� �־� ����
install.packages('sqldf')
library(sqldf)

install.packages('googleVis')
library(googleVis)

Fruits          # googleVis ��Ű���� ���Ե� ������

# ����1) Fruits �����Ϳ��� 2010�� �������� �����̸�, sales ���
Fruits[Fruits$Year == 2010, c('Fruit','Sales')]            # in R
sqldf('select Fruit, Sales from Fruits where Year = 2010') # in sql

# ����2) Fruits �����Ϳ��� Apples, Oranges �����͸� ���
Fruits[Fruits$Fruit %in% c('Apples','Oranges'), ]
sqldf("select * from Fruits where Fruit in ('Apples','Oranges')")
sqldf('select * from Fruits where Fruit in (\'Apples\',\'Oranges\')')

# ����3) �� ���Ϻ� Sales�� �� ��
tapply(Fruits$Sales, Fruits$Fruit, sum)

v_sql <- 'select Fruit, sum(Sales) AS "Sum_Sales"
            from Fruits
           group by Fruit'

sqldf(v_sql)

# ����4) emp �������� �� �μ��� �ִ뿬���� �̸�, 
# �μ���ȣ, �������
emp <- read.csv('emp.csv', stringsAsFactors = F)

v_sql1 <- 'select *
             from emp
            where (DEPTNO,SAL) in (select DEPTNO, max(SAL)
                                     from emp
                                    group by DEPTNO)'
v_sql2 <- 'select *
             from emp e1, (select DEPTNO, max(SAL) AS MAX_SAL
                             from emp e2
                            group by DEPTNO) e2
            where e1.DEPTNO = e2.DEPTNO
              and e1.SAL = e2.MAX_SAL'

sqldf(v_sql1)
sqldf(v_sql2)

# ����5) emp �����Ϳ��� 3�Ǹ� ���
emp[1:3,]                                    # in R
sqldf('select * from emp where rownum <= 3') # in sql(����Ұ�)
sqldf('select * from emp limit 3')           # in R 







