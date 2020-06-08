# ���� �����
# 2. write.csv(x, file = '�����̸�', row.names = 'T')
df1 <- data.frame(col1=c('a','b'), col2=1:2)

write.csv(df1, 'write_test.csv')

# 3. ���̳ʸ� �����
save(..., list = , file = )

v1 <- 1 ; v2 <- 2
save(v1,v2, file = 'save_test') # ������ ���Ϸ� ����
save(list = ls(), file = 'save_test')

rm(list = c('v1','v2')) 
rm(list = ls()) 

v1   # v1 not found
v2   # v2 not found

load('save_test')               # ����� ���� �ҷ�����
v1   # ���� �� ����
v2   # ���� �� ����


# [ ���� : ������ �÷� �߰��� factor ��ȯ ���� ]
df1$col3 <- c('c','d')               # non-factor�� �߰�
df1 <- cbind(df1, col4 = c('e','f')) # factor�� �߰�
df1 <- cbind(df1, col5 = c('g','h'),
             stringsAsFactors=F)     # non-factor�� �߰�

str(df1)

# 4. scan  
# - �ܺ� ������ ���ͷ� �ҷ�����
# - ���� ������ ����ڷκ��� ���� �Է� ���
# - �⺻�� ����, what='' �ɼ� ����ؾ� ���� �Է� ����

scan()                # ����ڿ��� ���� �� �Է´��
v1 <- scan()
v1

v2 <- scan(what = '') # ����ڿ��� ���� �� �Է´��
v2

scan(file = 'scan1.txt')
scan(file = 'scan2.txt', what = '')
scan(file = 'scan3.txt', sep=';')

# 5. readLines()
# - �ܺ������� ���ͷ� �ҷ�����
# - ���δ����� �ҷ���

readLines('scan1.txt') 

# 6. readline
# - ����ڷκ��� �ϳ��� �� �Է´��
# - ���������� ����

v1 <- readline('������ �����ұ��?(Y|N) : ')

# [ ���� ���� ]
# ����ڿ��� ������ �������� �Է¹��� �� �ش� ���� ����
v1 <- 1
v_ans <- readline('������ �������� �Է��ϼ��� : ')

v_ans2 <- readline('������ �����ұ��? (Y|N) : ')

if (v_ans2 == 'Y') {
  rm(list = v_ans)
  print('������ �����Ǿ����ϴ�')
} else {
  print('���� ������ ��ҵǾ����ϴ�')
}

v1

# [ ���� ���� ]
# seoul_new.txt ������ �ҷ��ͼ� ������ ���¸� ���� 
# ������������ ����
# id                       text                  date    cnt
# 305 ���������㿡 ���� ��Ź�� ���� �Դϴ�. 2017-09-27  2 
v_data <- readLines('seoul_new.txt')

vid <- c() ; vname <- c() ; vdate <- c() ; vcnt <- c()

for (i in 1:length(v_data)) {
  vtext <- str_split(v_data[i],' ')[[1]]
  vid <- c(vid, vtext[1])
  v_c <- str_c(vtext[2:(length(vtext) - 3)], collapse = ' ')
  vname <- c(vname, v_c)
  vdate <- c(vdate, vtext[length(vtext) - 2])
  vcnt <- c(vcnt, vtext[length(vtext) - 1])
}

data.frame(id=vid, text=vname, date=vdate, cnt <- vcnt)

# 6. �����ͺ��̽� ����(oracle)
# 1) �غ���� 
# - target DB ip�� port, DB name ����
# 192.168.0.115 
# 1521
# orcl

# [ ���� - ���� ��Ʈ/db name Ȯ�ι�� ]
# cmd -> lsnrctl status�� Ȯ��

# - ������ userid, passwd ����
# scott/oracle

# - R�� DB ������ connection file
#   (oracle DB ���� : ojdbc6.jar)
# C:\app\KITCOOP\product\11.2.0\client_1\ojdbc6.jar

# - R���� DB connection �����ִ� ��Űġ��ġ
install.packages('RJDBC')
library(RJDBC)

# [ ���� : oracle ��ġ ]
# - client : target DB ���Ӹ� ����, local DB ����
# - server : local DB ����

# 2) connect
jdbcDriver <- JDBC(driverClass = "oracle.jdbc.OracleDriver", 
classPath = "C:/app/KITCOOP/product/11.2.0/client_1/ojdbc6.jar")

con <- dbConnect(jdbcDriver, 
                 "jdbc:oracle:thin:@192.168.0.115:1521:orcl",
                 "scott",   # userid
                 "oracle")  # passwd

# 3) ���� ����
q1 <- 'select * from r_test'
dbGetQuery(con,  # connection �̸�
           q1)   # ���� ����

q2 <- 'select e1.ename, nvl(e2.ename, e1.ename)
         from emp e1, emp e2 
        where e1.mgr = e2.empno(+)'

dbGetQuery(con,  # connection �̸�
           q2)   # ���� ����

