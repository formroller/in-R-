# 1. vector
# 2. list
l1 <- list(col1=c(1,2,3), col2=c('a','b'))
l1[1][2]
l1$col1[2]
l1[[1]][2]

# 3. matrix
# 4. array
# - ������
# - ���� ������ Ÿ�Ը� ���

# ������ Ȯ��
#         R       python
# 2���� ��,��      ��,��
# 3���� ��,��,��   ��,��,��

# 1. array ����
# 3X4
a1 <- array(data=1:12, dim=c(3,4))

# 2X2X3
a2 <- array(data=1:12, dim=c(2,2,3))
a2

# 2. ����
a2[1,1,3]   # ù��° ��, ù��° �÷�, ����° �� ����
a2[,,3]
a2[,,3,drop=F]

# 3. ���� Ȯ��
dim(a2)

# 5. data.frame

# vector -> matrix -> array
# list   -> data.frame

# if��
# - ���ǹ�
# - ���ǿ� ���� ġȯ �Ǵ� �ٸ� ���α׷��� ����
# - ���Ϳ��� �Ұ�(���Һ� ����ġȯ �ݺ� �Ұ�)

# [ �⺻ ���� ]
# if (����) {
#   ���϶� ���� ����
# } else if (����) {
#   ���϶� ���� ����
# } else {
#   �����϶� ���� ����
# }

# ����) v1�� ���� 10�̸� 'A' �ƴϸ� 'B'�� ���
v1 <- 20

if (v1==10) {
  'A'
} else {
  'B'
}


# ����) v1�� ���� 30���� ũ�� 'A' 20���� ũ�� 'B',
# ��Ÿ 'C'�� ���
if (v1 > 30) {
  'A'
} else if (v1 > 20) {
  'B'
} else {
  'C'
}


# ����) v2�� ���� 10�̸� 'A' �ƴϸ� 'B'�� ���
v2 <- c(10,20,30)

if (v2==10) {
  'A'
} else {
  'B'
}


# ifelse��
# - ���ǹ�
# - ���ǿ� ���� ġȯ, ���ϸ� ����
# - else ���� ���� �Ұ�
# - ���Ϳ��� ����

# ifelse(����,���϶� ���ϰ�,�����϶� ���ϰ�)

# ����) v2�� ���� 10�̸� 'A' �ƴϸ� 'B'�� ���
ifelse(v2==10,'A','B') # �� : decode(v2,10,'A','B')

# ����) v2�� ���� 30���� ũ�� 'A' 20���� ũ�� 'B',
# ��Ÿ 'C'�� ���
ifelse(v2 > 30,'A',ifelse(v2 > 20,'B','C'))

# [ ���� ���� ]
# emp.csv ������ �а�,
emp <- read.csv('emp.csv', stringsAsFactors = F)

# 1) dname�̶�� �÷� �߰�, 
# 10�� �μ��� �λ��, 20���� �ѹ��� 30���� �繫��
emp$dname <- ifelse(emp$DEPTNO == 10, '�λ��', 
                    ifelse(emp$DEPTNO == 20,'�ѹ���', 
                                            '�繫��'))

# 2) new_sal�̶�� �÷� �߰�,
# sal�� 3000�̻��� ��� 5%�λ�, �̸��� ���� 10%�λ�
emp$new_sal <- ifelse(emp$SAL >= 3000, emp$SAL*1.05, 
                                       emp$SAL*1.1)

# for��
# - �ݺ���
# - �ݺ�Ƚ���� ������ ����
# 
# [ �⺻ ���� ]
# 
# for (�ݺ����� in ��� or Ƚ��) {
#   �ݺ�ó��
# }

for ( i in 1:10 ) {
  print(i)
}

i <- 1 ; print(i)
i <- 2 ; print(i)
...
i <- 10 ; print(i)


for ( i in 1:10 ) {
  print(10)
}


# ����) v2�� ���� 10�̸� 'A' �ƴϸ� 'B'�� ���
# if + for

if (v2 == 10) {
  'A'
} else {
  'B'
}

for (i in v2) {
  if (v2 == 10) {
    'A'
  } else {
    'B'
  }
}

step1) i <- 10
step2)   
if (10 == 10) {
  'A'
} else {
  'B'
}
step3) i <- 20
step4)
if (20 == 10) {
  'A'
} else {
  'B'
}

for (i in v2) {
  if (i == 10) {
    print('A')     # for���� ���ϰ��� �ƴ� ���๮�� �ʿ�
  } else {
    print('B')
  }
}


v3 <- for (i in v2) {
  if (i == 10) {
    print('A')     # for���� ���ϰ��� �ƴ� ���๮�� �ʿ�
  } else {
    print('B')
  }
}


for (i in v2) {
  if (i == 10) {
    v_3 <- 'A'    # v_3 ���Ϳ� ���ϰ� ���
  } else {
    v_3 <- 'B' 
  }
}

i <- 10 ; v_3 <- 'A'
i <- 20 ; v_3 <- 'B'
i <- 30 ; v_3 <- 'B'

v4 <- c()           # ���� ����

for (i in v2) {
  if (i == 10) {
    v4 <- c(v4,'A') # ������ ������ ���� ó��
  } else {
    v4 <- c(v4,'B') 
  }
}
 
i <- 10 ; v_3 <- 'A'
i <- 20 ; v_3 <- 'A', 'B'
i <- 30 ; v_3 <- 'A', 'B', 'B'


# ����) 1~10�� ���� ���Ϳ��� 5���� �۰ų� ���� ����
# ���ϱ� 1��, 6�̻��� ���� ���ϱ� 2�� ����
# 1) ifelse
v6 <- 1:10

ifelse(v6 <= 5, v6, v6*2)

# 2) for + if : if���� �� �ϳ��� ���� ��������, ���α׷��� 
if (v6 <= 5) {
  v6
} else {
  v6 * 2
}

v_result <- c()

for (i in v6) {
  if (i <= 5) {
    v_result <- c(v_result, i)
  } else {
    v_result <- c(v_result, i * 2)
  }
}


# [ ���� ���� - for + if ]
# emp.csv ������ �а�,
emp <- read.csv('emp.csv', stringsAsFactors = F)

# 1) dname�̶�� �÷� �߰�, 
# 10�� �μ��� �λ��, 20���� �ѹ��� 30���� �繫��
v_dname <- c()

for (i in emp$DEPTNO) {
  if (i == 10) {
    v_dname <- c(v_dname, '�λ��')
  } else if (i == 20) {
    v_dname <- c(v_dname, '�ѹ���')
  } else {
    v_dname <- c(v_dname, '�繫��')
  }
}

emp$dname <- v_dname

# 2) new_sal�̶�� �÷� �߰�,
# sal�� 3000�̻��� ��� 5%�λ�, �̸��� ���� 10%�λ�
v_sal <- c()

for (i in emp$SAL) {
  if (i >= 3000) {
    v_sal <- append(v_sal, i * 1.05)
  } else {
    v_sal <- append(v_sal, i * 1.1)
  }
}

emp$new_sal <- v_sal



# while��
# - ���� ��� �ݺ���(for���� ������ ���/Ƚ�� �� �ݺ�)
# - for��ó�� ���� �ܰ�� �ڵ����� �Ѿ�� ����
# - ������ ���ΰ�� ���� �ݺ� ����
# 
# [�⺻ ����]
# while (����) {
#   �ݺ�����
# }

# ����) 1~10���� ���
j <- 1   # �ʱⰪ��

while (j <= 10) {
  print(j)
  j <- j + 1
}

# [��������]
# 1 ~ 100�� ���� ��� : 5050
step1) 1
step2) ������ + 2  ; 1+2
step3) ������ + 3  ; 1+2+3
.... �ݺ�

i <- 1
vsum <- 0

while (i <= 100) {
  vsum <- vsum + i
  i <- i + 1
}

vsum








