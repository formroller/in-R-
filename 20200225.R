# R ȯ�漳��
# �۾� ���丮 Ȯ�� �� ����(�ӽ���)
getwd()
setwd('C:/Users/KITCOOP')

# �۾� ���丮 ����
# Tools > Global Options > General > Defalut working directory ����

# ���� : �������� ���� �ּ� ����
# Ctrl + Shift + C

# ��������
v1 <- 1
a1 <- 1
b1 <- 2
c1 <- 3

v_sum <- a1 + b1 + c1
c2 <- 'a'
c3 <- "a   b" ; c3

# ������ ������ Ÿ�� Ȯ��
d1 <- Sys.Date()
class(v1)
class(c2)
class(d1)

# �������
c1 <- '10'
a1 + v1    # ���ں��� ������� ����
c1 + a1    # ���ں��� ���ں��� ������� �Ұ�
d1 + 100   # ��¥���� ���ں��� ���갡��

# ����ȯ �Լ�
as.numeric()
as.character()
as.Date()

as.numeric(c1) + a1

# ������ ������ �� �Ҵ�
seq1 <- 1:10
'a':'f'       # ���ڿ����� ��� �Ұ�

help(seq)
seq(from = 1, 
    to = 1, 
    by = ((to - from)/(length.out - 1)))
seq(from=1, to=10, by=1)

seq(from=as.Date('2020/01/01'), 
      to=as.Date('2020/12/31'), by='month')

# ��¥�� ����ȯ �� �Ľ�
d2 <- as.Date('2020/02/05') + 100
as.character(d2, '%A')        # ����
 
as.character(d2, '%Y/%m/%d')  # �����
as.character(d2, '%H:%M:%S')  # �ú���

# �Լ��� �����
substr('abcde',2,3)
substr(x='abcde',start=2,stop=3)


# [ �������� ]
# 1. 2020�� 1�� 1�Ϻ��� 1�� 31�ϱ��� ��¥�� ���� ���
d3 <- seq(from=as.Date('2020/01/01'), 
            to=as.Date('2020/01/31'), by=1)

as.character(d3,'%A')

# 2. 2020�� 6�� 8�Ϻ��� ���ó�¥���� ���� �ϼ� ��� 
as.Date('2020/06/08') - Sys.Date()

sum <- 1
sum(c(1,2,3))

# ���� ����
objects()  # ����� ���� ���
ls()       # ����� ���� ���
rm(list = "sum")  # Ư�� ���� ����
rm(list = ls())   # ����� ��� ���� ����

# ������� ��ȣ
7 %/% 3  # ��
7 %% 3   # ������
3^2      # �¼�
3**3     # �¼�
1e1      # 10
1e-1     # 0.1
1e2      # 100
1e3      # 1000

# NA�� NULL
cat(1,NA,2)    # �ڸ��� ����
cat(1,NULL,2)  # ���� �������̹Ƿ� �ڸ��� �����Ұ�

sum(1,NA,3)    # NA�� ���õ� �� ����
sum(1,NULL,3)  # NULL�� ���É�

NA + 1         # NA 
NULL + 1       # numeric(0)   


# ��¥ ���� �ܺ� ��Ű�� : lubridate
install.packages('lubridate')
library(lubridate)

date1 <- now() ; date1
class(date1)
as.character(date1, '%Y')

year(date1)             # ��
month(date1)            # ��, ��������
month(date1, label = T) # ��, ��������
                        # (��¥�� �����϶�)
day(date1)              # ��
wday(date1)             # ���� ���� ���
wday(date1, label = T)  # ���� �̸� ���
hour(date1)             # ��
minute(date1)           # ��
second(date1)           # ��

date1 + months(6)       # 6���� ��
date1 + years(6)        # 6�� ��
date1 + days(6)         # 6�� ��
date1 + hours(6)        # 6�ð� ��

# ��¥ ��� ����
Sys.setlocale('LC_TIME', 'C')       # ����
Sys.setlocale('LC_TIME', 'KOREAN')  # �ѱ�
month(date1, label = T)

# [��������]
# 2020�� 2���� �Ϻ� �����͸� ���,
# ���� v_year��� �÷�(����)�� �⵵��,
# v_month��� �÷�(����)�� ����, 
# v_day��� �÷�(����)�� �ϸ� �и�����
# v_bonus_date �÷��� 6���� �� �����͸� �Է�

date2 <- seq(as.Date('2020-02-01'),
             as.Date('2020-02-28'),1) 

v_year <- year(date2)
v_month <- month(date2)
v_day <- day(date2)
v_bonus_date <- date2 + months(6)







