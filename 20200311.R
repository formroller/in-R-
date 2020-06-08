for (i in 1:10) {
  print(i)
}

for (i in 1:10) {
  if (i==5) {
    next 
  }
  print(i)
}

for (i in 1:10) {
  if (i%%2!=0) {
    next 
  }
  print(i)
}

# [ ���� ���� ]
# 1���� 100���� ���ϵ�, ¦���� ���ϸ�?
# sol1) for
vsum <- 0

for (i in 1:100) {
  if (i%%2 != 0) {
    next
  }
  vsum <- vsum + i
}

vsum

# sol2) while
i <- 1
vsum <- 0

while (i <= 100) {
  if (i%%2 !=0) {
    next
  }
  vsum <- vsum + i
  i <- i + 1         # i=1�϶� ��ŵ�Ǹ鼭 �������� ����
}

vsum

# --------
i <- 0
vsum <- 0

while (i <= 100) {
  i <- i + 1         
  if (i%%2 !=0) {
    next
  }
  vsum <- vsum + i
}

vsum


# [ ���� ���� ]
# �Ʒ� ���͸� ����ϵ�, NA���������� ���
v1 <- c(1,2,3,NA,4,5,6)

for (i in v1) {
  if (is.na(i)) {
    break
  }
  print(i)
}


# �������
sum(..., na.rm = F)
mean(x, ...)

sum(1,2,3)     # 1,2,3�� �� ����
mean(1,2,3)    # 1�� ��ո� ����, ������ ���� ����
mean(c(1,2,3)) # 1,2,3�� ��� ����

v1 <- c(1,2,3,NA)
sum(v1, na.rm = T)
mean(v1, na.rm = T)           # 3���� ���
mean(ifelse(is.na(v1),0,v1))  # 4���� ���

# [ ���� : NA ġȯ �Լ� ]
str_replace(v1,NA,0)   # NA ġȯ �Ұ�
str_replace_na(v1,0)   # NA ġȯ ����, ���ڷ� ����

# [ �������� ]
# 1) ������ ���Ϳ� �ݺ����� ����Ͽ� 10% �λ�� ������ 
# �� ���� ���Ͽ���
v1 <- c(1000,1500,NA,3000,4000)

sum(v1 * 1.1, na.rm = T)
sum(ifelse(is.na(v1), 0, v1*1.1))

vsum <- 0
for (i in v1) {
  if (is.na(i)) {
    next
  }
  vsum <- vsum + i*1.1
}

# ����� ���� �Լ� : ����ڰ� ���� ����� �Լ�, ���ϴ���ʿ�
�Լ��� <- function(...) {
  cmd1
  cmd2
  ...
  return(��ü)
}

# ����) abs ����� �����ϴ� ����� �����Լ� ����
abs(-2)

f_abs <- function(x) {
  if (x >= 0) {
    return(x)
  } else {
    return(-1 * x)
  }
}

f_abs(10)
f_abs(-10)
f_abs(0)


# [ ���� ���� ] 
# �� ���� �Է� �޾� �� ���� ���� ����ϴ� �Լ�����
f_sum <- function(x,y) {
  return(x+y)
}

f_sum <- function(x,y=0) {
  return(x+y)
}

f_sum(x=10, y=11)
f_sum(10,11)
f_sum(10)

# [ ���� ���� ]
# ������ �Լ� ����
# f_split('a#b#c','#',2) => b

f_split <- function(x,sep=' ',ord=1) {
  str_split(x,sep)[[1]][ord]
}

str_split('a#b#c','#')
f_split('a#b#c','#',3)

# ����) ������ ���Ϳ��� ���� b, B ����ǵ���?
v1 <- c('a#b#c#','A#B#C#')
str_split(v1,'#')  # �ܵ����� �Ұ�, �ݺ��� �ʿ�
f_split(v1,'#',2)  # ���Ϳ��� �Ұ�

sapply(v1, f_split,'#',2)


# [ ���� ���� ]
# f_sum2(100) = 1+2+3+...+100





