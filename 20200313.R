# 파일 입출력
# 2. write.csv(x, file = '파일이름', row.names = 'T')
df1 <- data.frame(col1=c('a','b'), col2=1:2)

write.csv(df1, 'write_test.csv')

# 3. 바이너리 입출력
save(..., list = , file = )

v1 <- 1 ; v2 <- 2
save(v1,v2, file = 'save_test') # 변수를 파일로 저장
save(list = ls(), file = 'save_test')

rm(list = c('v1','v2')) 
rm(list = ls()) 

v1   # v1 not found
v2   # v2 not found

load('save_test')               # 저장된 변수 불러오기
v1   # 변수 값 존재
v2   # 변수 값 존재


# [ 참고 : 문자형 컬럼 추가시 factor 변환 여부 ]
df1$col3 <- c('c','d')               # non-factor로 추가
df1 <- cbind(df1, col4 = c('e','f')) # factor로 추가
df1 <- cbind(df1, col5 = c('g','h'),
             stringsAsFactors=F)     # non-factor로 추가

str(df1)

# 4. scan  
# - 외부 파일을 벡터로 불러오기
# - 인자 생략시 사용자로부터 직접 입력 대기
# - 기본은 숫자, what='' 옵션 사용해야 문자 입력 가능

scan()                # 사용자에게 숫자 값 입력대기
v1 <- scan()
v1

v2 <- scan(what = '') # 사용자에게 숫자 값 입력대기
v2

scan(file = 'scan1.txt')
scan(file = 'scan2.txt', what = '')
scan(file = 'scan3.txt', sep=';')

# 5. readLines()
# - 외부파일을 벡터로 불러오기
# - 라인단위로 불러옴

readLines('scan1.txt') 

# 6. readline
# - 사용자로부터 하나의 값 입력대기
# - 문자형으로 저장

v1 <- readline('파일을 삭제할까요?(Y|N) : ')

# [ 연습 문제 ]
# 사용자에게 삭제할 변수명을 입력받은 뒤 해당 변수 삭제
v1 <- 1
v_ans <- readline('삭제할 변수명을 입력하세요 : ')

v_ans2 <- readline('변수를 삭제할까요? (Y|N) : ')

if (v_ans2 == 'Y') {
  rm(list = v_ans)
  print('변수가 삭제되었습니다')
} else {
  print('변수 삭제가 취소되었습니다')
}

v1

# [ 연습 문제 ]
# seoul_new.txt 파일을 불러와서 다음의 형태를 갖는 
# 데이터프레임 생성
# id                       text                  date    cnt
# 305 무료법률상담에 대한 부탁의 말씀 입니다. 2017-09-27  2 
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

# 6. 데이터베이스 연동(oracle)
# 1) 준비사항 
# - target DB ip와 port, DB name 정보
# 192.168.0.115 
# 1521
# orcl

# [ 참고 - 서비스 포트/db name 확인방법 ]
# cmd -> lsnrctl status로 확인

# - 접속할 userid, passwd 정보
# scott/oracle

# - R과 DB 연결할 connection file
#   (oracle DB 기준 : ojdbc6.jar)
# C:\app\KITCOOP\product\11.2.0\client_1\ojdbc6.jar

# - R에서 DB connection 도와주는 패키치설치
install.packages('RJDBC')
library(RJDBC)

# [ 참고 : oracle 설치 ]
# - client : target DB 접속만 가능, local DB 없음
# - server : local DB 존재

# 2) connect
jdbcDriver <- JDBC(driverClass = "oracle.jdbc.OracleDriver", 
classPath = "C:/app/KITCOOP/product/11.2.0/client_1/ojdbc6.jar")

con <- dbConnect(jdbcDriver, 
                 "jdbc:oracle:thin:@192.168.0.115:1521:orcl",
                 "scott",   # userid
                 "oracle")  # passwd

# 3) 쿼리 수행
q1 <- 'select * from r_test'
dbGetQuery(con,  # connection 이름
           q1)   # 수행 쿼리

q2 <- 'select e1.ename, nvl(e2.ename, e1.ename)
         from emp e1, emp e2 
        where e1.mgr = e2.empno(+)'

dbGetQuery(con,  # connection 이름
           q2)   # 수행 쿼리


