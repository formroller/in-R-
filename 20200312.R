# [ ��������� �Լ� ���� ]
# if �������� 3. �� ���ڸ� �Է��ؼ� ù ��° ���ڰ� 
# �� ��° ���ں��� Ŭ ��� ù ��° ���ڿ��� �� ��° ���ڸ� 
# �� ���� ���, �ι�° ���ڰ� ù��° ���ں��� Ŭ ��� 
# �ι�°���� ù��° ���ڸ� �� ���� ����ϴ� �Լ� myf3 ����
myf3 <- function(x,y) {
  if (x >= y) {
    return(x-y)
  } else if (x < y) {
    return(y-x)
  }
}

myf3(1,10) 
myf3(10,1) 

# if �������� 5. ����ڰ� �빮�� 'Y'�� �ҹ���'y'�� �Է��ϸ� 
# ȭ�鿡'Yes'�� ����ϰ� �� �� �ٸ� ���ڸ� �Է��ϸ�'Not Yes'�� 
# ����ϴ� �Լ� ����
myf5 <- function(x) {
  if (x == 'Y' | x == 'y') {  # x %in% c('Y','y')
    return('Yes')
  } else {
    return('Not Yes')
  }
}

myf5('iY')

# [ ���� ���� - �Լ��� ���Ͱ� ���ԵǴ� ��� ]
# emp.csv������ �а� 
# 1. sal�� comm�� ���� ���ϴ� �Լ� ���� �� ����
# f_salcomm(emp$SAL,emp$COMM) ����, 
# COMM�� NA�� ��� 0���� ġȯ
emp <- read.csv('emp.csv', stringsAsFactors = F)

f1 <- function(x,y) {
  return(x + ifelse(is.na(y),0,y))
}

f1(4,5)
f1(emp$SAL,emp$COMM)

# 2. �μ���ȣ�� ���� �μ��� ��� �Լ� ���� �� ����
# 10���̸� �λ��, 20�� �繫��, 30�� �ѹ���
# 2-1) for + if
vname <- c()

for (i in emp$DEPTNO) {
  if (i == 10) {
    vname <- c(vname, '�λ��')
  } else if (i == 20) {
    vname <- c(vname, '�繫��')
  } else {
    vname <- c(vname, '�ѹ���')
  }
}

vname

# 2-1) ����� ���� �Լ�
f2 <- function(x) {
  if (x == 10) {
    return('�λ��')
  } else if (x == 20) {
    return('�繫��')
  } else {
    return('�ѹ���')
  }
}

f2(10)
f2(emp$DEPTNO)          # ���Ϳ��� �Ұ�

# sol1) �����Լ�
sapply(emp$DEPTNO, f2)  # ���Ϳ��� ����

# sol2) ����������Լ��� �ݺ��� ���
f2 <- function(x) {
  vname <- c()
  for (i in x) {
    if (i == 10) {
      vname <- c(vname, '�λ��')
    } else if (i == 20) {
      vname <- c(vname, '�繫��')
    } else {
      vname <- c(vname, '�ѹ���')
    }
  }
  return(vname)
}

f2(emp$DEPTNO)   # for���� ���� ���Ϳ��� ����

# [ ���� ���� ]
f_nvl(NA,0)
f_nvl(emp$COMM,0)

f_nvl <- function(x, replacement=0) {
  if (is.na(x)) {
    return(replacement)
  } else {
    return(x)
  } 
}

f_nvl(NA,100)
f_nvl(emp$COMM,0)
sapply(emp$COMM, f_nvl, 0)

# self call(����Լ�)
# - �Լ� ���ο��� �����Լ��� �� ȣ���ϴ� ����
# - �Լ��� ȣ���� �ݺ����� �ݺ��� ���� �ݺ��۾� ���� ����
# - stop point �ʿ�

# ����) fsum(100) = 1+2+3+...+100 �Լ��� ����Լ��� ����
fsum <- function(x) {
  vsum <- 0
  for (i in 1:x) {
    vsum <- vsum + i
  }
  return(vsum)
}
fsum(100)


i
1  1      = fsum(1)
2  1+2    = fsum(2) = fsum(1) + 2
3  1+2+3  = fsum(3) = fsum(2) + 3       
...
x  1+2+.. = fsum(x) = fsum(x-1) + x

fsum <- function(x) {
  fsum(x-1) + x
}

fsum(10)
# fsum(10) = fsum(9) + 10
#          = fsum(8) + 9 + 10
#          = fsum(7) + 8 + 9 + 10
#             ....
#          = fsum(2) + 3 + ... + 8 + 9 + 10
#          = fsum(1) + 2 + ... + 10   # stop point �߻�
#          = fsum(0) + 1 + ... + 10

fsum <- function(x) {
  if (x == 1) {
    return(1)
  } else {
    return(fsum(x-1) + x)
  }
}

fsum(10)

# [ �������� - ������ �Ǻ���ġ ������ ����ϴ� �Լ� ���� ]
# f(1) = 1
# f(2) = 1
# f(3) = 1+1 = 2
# f(4) = 1 + 2
# ...
# f(x) = f(x-2) + f(x-1), (f(1)=1, f(2)=1 ����)
# 1 1 2 3 5 8 13

f_fibo <- function(x) {
  if (x==1 | x==2) {
    return(1)
  } else {
    return(f_fibo(x-2) + f_fibo(x-1))
  }
}

f_fibo(1)

# ����������
f1 <- function(...) {
  v_key <- list(...)
  for (i in v_key) {
    ....
  }
}

f1(1,2,3)

# [ ���� ���� ] 
fsum3(1,10,100, .... ) = 111

fsum3 <- function(...) {
  v_key <- c(...)
  for (i in v_key) {
    print(i)
  }
}

fsum3 <- function(...) {
  v_key <- list(...)
  vsum  <- 0
  for (i in v_key) {
    vsum <- vsum + i
  }
  return(vsum)
}

fsum3(1,2,3,10,100)

# ���������� ��������
# - �������� : Ư�� �Լ�, ���α׷� ������ ��ȿ�� ����
# - �������� : Ư�� �Լ�, ���α׷� �ۿ����� ��ȿ�� ����

v1 <- 1   # �������� (�ش� ���ǿ���)

f1 <- function(x) {
  return(v1)
}

f1()  #1

# ----
v1 <- 10     # �������� (�ش� ���ǿ���)

f2 <- function(x) {
  v1 <- 5    # ��������(���������� �켱����)
  return(v1)
}

f2()  #5
v1

# ----
f3 <- function(x) {
  vv1 <- 1
  return(vv1)
}

f4 <- function(x) {
  return(vv1)
}

f3()  # 1
f4()  # vv1 not found error

# ----
f3 <- function(x) {
  vv1 <<- 1          # ��������ȭ 
  return(vv1)
}

f4 <- function(x) {
  return(vv1)
}

f3()  # 1
f4()  # 1
vv1   # 1

f_test <- function(x) {
  vsum5 <- sum(1:x)
  return(vsum5)
}

vsum5
f_test(100)


# ������ �м�
# - �����н� : Y(target) ����
#  1) ȸ�ͱ�� �м� : Y�� ������
#  2) �з���� �м� : Y�� ������
# 
# ex) ������Ż �м�
# ��������(X) : �������̵�, ����, ����, ���ӽð�, kill��, .... , 
# ���Ӻ���(Y) : Ż�𿩺�
# 
# - �������н� : Y(target) ����
# 
# ex) ���� Ư¡ȭ, ���з�
# �������̵�, ����, ����, ���ӽð�, kill��, .... ,



# ���� ����� �Լ�
# 1. read.csv
# - header = FALSE : ù��° ���� �÷�ȭ ���� ����
# - sep = "" : ������ �и� ���� ��ȣ
read.csv('read_test1.txt', skip = 1, sep=':',
         header = T) # �⺻��

read.table('read_test1.txt', skip = 1, sep=':', 
           header = F) # �⺻��

# - na.strings = "NA" : NA ó���� ���ڿ�
# - nrows = -1 : �ҷ��� ���� ����
# - skip = 0 : ��ŵ�� ���� ����
read.csv('read_test1.txt', skip = 1)

# - stringsAsFactors = T : ������ �÷��� factor ���� ����
# - encoding = "unknown" : ���� ���ڵ� 

read.csv('read_test1.txt')





