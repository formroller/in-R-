# ���ڿ� ó���� ���� �Լ� : stringr ��Ű�� ���
install.packages('stringr')
library(stringr)

# 1. str_detect(���, ����) 
# - ���ڿ� ���� Ȯ�� �Լ�
# - ����Ŭ like �����ڱ��
# - ���Խ� ǥ�� ����

v1 <- c('abc', 'Abcd', 'bcd')
v2 <- c('abc', 'Abcd12', 'bcd!@','aaaab')

str_detect(v1, 'a')      # 'a' ���Կ��� Ȯ��(like '%a%')
str_detect(v1, '^a')     # 'a' ���� ���� Ȯ��(like 'a%')
str_detect(v1, 'a$')     # 'a' �������� Ȯ��(like '%a')
str_detect(v1, '^[aAb]') # 'a' �Ǵ� 'A'�� �����ϴ��� Ȯ��
str_detect(v1, '^.b')    # �ι�° ���ڰ� b(like '_a%')

str_detect(v1, '^[aA][bB]')
str_detect(v1, '^[aAbB]')

str_detect(v2, '[0-9]')     # ���ڸ� �����ϴ�
str_detect(v2, '\\d')       # ���ڸ� �����ϴ�
str_detect(v2, '[:digit:]') # ���ڸ� �����ϴ�

str_detect(v2, '[a-zA-Z]')  # ������ �����ϴ�(��ұ���X)
str_detect(v2, '[:alpha:]') # ���ڸ� �����ϴ�
str_detect(v2, '[:punct:]') # Ư�����ڸ� �����ϴ�

str_detect(v2, 'a{4,5}')    # a�� 4ȸ�̻� 5ȸ���� �ݺ��Ǵ�


# [ �������� ]
# student.csv ������ �а� ID�� 'a'�� �����ϴ� �л���
# �̸�, ID, �г� ���
std[str_detect(std$ID,'a'), c('NAME','ID','GRADE')]

# [ ���� : %in% �����ڴ� ���ڿ� ���� Ȯ�� �Ұ� ]
'a' %in% 'abc'
std$NAME %in% c('�����','�蹮ȣ')


# 2. str_count(���, ����)
# - ���ڿ��� ���ԵǾ� �ִ� ������ ����
# - ���Խ� ǥ�� ����

str_count(v2,'a')  # 'a'�� ���Ե� Ƚ��
str_count(v2,'[aA]')  # 'a' �Ǵ� 'A'�� ���Ե� Ƚ��
str_count(v2,'[0-9]')  # ���ڰ� ���Ե� Ƚ��


# 3. str_c(..., sep = , collapse = )
# - ���ڿ� ���� �Լ�
# - ����Ŭ�� ���Ῥ����(||) ���
# - sep �ɼ� : ���ս� ������ ����, ���ͳ��� ����(***)
# - collapse �ɼ� : ���ս� ������ ����, ���ͳ� ����

v3 <- c('a','b','c')
v4 <- c('A','B','C')

str_c('a','b','c',sep = ';')   # "a;b;c"
str_c(v3, sep = ';')           # "a" "b" "c", ���պҰ�
str_c(v3, collapse = ';')      # "a;b;c"
str_c('a','b','c')             # "abc", sep='' �⺻
str_c(v3,v4)                   # "aA" "bB" "cC"
str_c(v3,'is...')              # v3||'is...'

# [ ���� ���� ]
# emp.csv������ �а� �Ʒ��� ���� �������� ���
# 'SMITH�� 10% �λ�� ������ 880�̴�.'
str_c(emp$ENAME, 
      '�� 10% �λ�� ������ ', 
      emp$SAL*1.1, 
      '�̴�.')

# [ ���� ���� ]
# student.csv������ �а� ID�� ���ڰ� 2ȸ�̻� �ݺ��� 
# �л� ������ ����(�����)
v5 <- c('a1b2', 'a123')
str_count(v5,'[0-9]') >= 2   # �Ұ�, �ܼ�����
str_detect(v5, '[0-9]{2}')   # ����, ���ӹݺ�
str_detect(v5, '[0-9][0-9]') # ����

std <- std[!str_detect(std$ID, '[0-9]{2}'), ]


# 4. str_length(���)
# - ���ڿ��� ũ�� ���
# - ����Ŭ length �Լ��� ���
str_length(v1)

# 5. str_locate(���,����)
# - ���ڿ��̳� ������ ��ġ ���
# - ����Ŭ instr �Լ��� ���
v6 <- c('a#b#c','a##b##c##') 
str_locate(v6,'#')     # ù��° #�� ��ġ ���
str_locate_all(v6,'#') # #�� ��� ��ġ ���
str_locate('abc','ab') # ã�� ���ڿ��� ����,�� ��ġ �ٸ����

# 6. stringr::str_sub(���, ������ġ, ����ġ)
# = substr
# - ��ġ��� ���ڿ� ���� �Լ�
# - ����Ŭ substr�̶� ����ϳ� ����° ���� �ǹ� ����
str_sub(v6,2,3)  # �� ���Һ� 2���� 3 ��ġ���� ���ڿ�����
substr(v6,2,3)   

# [ ���� ���� ]
# '031-356-1234'���� ������ȣ ����, �� ��ġ �������
v_end <- str_locate('031-356-1234','-')[1,1] - 1
substr('031-356-1234',1, v_end)


# 7. stringr::str_replace(���,ã�����ڿ�,�ٲܹ��ڿ�)
# - = replace
# - ���ڿ� ġȯ �Լ�
# - oracle replace �Լ��� ���

str_replace('abc','a','A')
str_replace('abca','ab','AB')  # translate ��� ����
str_replace('abca','ab','')    # ���� ���

str_replace_all('abca','a','') # �߰ߵ� ���� ��� ����/ġȯ

# ** ���ǻ���
v7 <- c('ab',NA,'bc')
str_replace(v7,NA,0)       # NA�� ġȯ�Ұ�
str_replace(v7,'ab',NA)    # NA�� ġȯ�Ұ�
str_replace('ab','a',0)    # �����̿ܰ����� ġȯ�Ұ�

str_remove_all('ab','a')   # ���� �Լ��� ��ü ����

# [ ���� ���� ]
# ������ ������ 10%�λ�� �� ���
# v_sal <- c('1,200','5,000','3,300')
v_sal <- c('1,200','5,000','3,300')

v_sal <- as.numeric(str_replace_all(v_sal,',',''))
v_sal * 1.1

# 8. str_split(���, ����)
# - �и��Լ�
# - ��°���� ����Ʈ

str_split('a#b#c','#')[[1]][2]

# [ ���� ���� ]
# professor.csv ������ �а�
pro <- read.csv('professor.csv', stringsAsFactors = F)

# 1) ������ȣ�� 40���� �����ϴ� ������ �̸�, ������ȣ, 
# pay ���
pro[str_detect(pro$PROFNO, '^40'), c('NAME','PROFNO','PAY')]

# 2) email_id��� �� ������ �̸��� ���̵� ��� �÷� ����
# 2-1) ��ġ��� : substr + str_locate
# 1) '@' ��ġȮ��
v_lo <- str_locate(pro$EMAIL,'@')[,1]

# 2) ����
pro$email_id <- substr(pro$EMAIL, 1, v_lo - 1)

# 2-2) �и���� : str_split
str_split('captain@abc.net','@')[[1]][1]

str_split(pro$EMAIL,'@')[[1]][1]
str_split(pro$EMAIL,'@')[[2]][1]
...

for (i in 1:nrow(pro)) {
  pro$email_id2[i] <- str_split(pro$EMAIL,'@')[[i]][1]
}

v_id <- c()
for (i in 1:nrow(pro)) {
  v_id <- c(v_id, str_split(pro$EMAIL,'@')[[i]][1])
}


# �ݺ� ��� : �ݺ����� �帧�� �����ϴ� ����
# 1. next : �ݺ����� next �ڿ� ����Ǵ� ���彺ŵ

for (i in 1:10) {
  cmd1          # 10�� ����
  cmd2          # 10�� ����
  if (i==5) {
    next
  }
  cmd3          # skip ���, 9�� ����
}
cmd4            # 1�� ����

# 2. break : �ݺ��� ��� ����
for (i in 1:10) {
  cmd1          # 5
  cmd2          # 5
  if (i==5) {
    break
  }
  cmd3          # 4
}
cmd4            # 1

# 3. exit : ���α׷� ��� ����
for (i in 1:10) {
  cmd1          # 5
  cmd2          # 5
  if (i==5) {
    exit(0)
  }
  cmd3          # 4
}
cmd4            # 0

# [ ���� ���� ] 
# 1���� 10���� �� ¦���� ���
for (i in 1:10) {
  if (i %% 2 != 0) {
    next
  }
  print(i)
}


















