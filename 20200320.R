# 문자의 포맷 변경 함수
to_char(1234,'09999') => '01234'
to_char(1234,'99999') => ' 1234'

# sprintf
sprintf(fmt,   # 변경포맷(s:문자열, d:정수, f:실수)
        data)

sprintf('%2d',2)     # 2를 두자리 문자열로 변경, 빈칸삽입
sprintf('%02d',2)    # 2를 두자리 문자열로 변경, 0삽입
sprintf('%.2f',1234) # 두자리 소수점 표현 

# 예제) movie 데이터의 월 컬럼을 두자리로 표현
str_pad(movie$월, 2, 'left', '0')
sprintf('%02d',movie$월) 

v_mon <- sprintf('%02d',movie$월)
v_day <- sprintf('%02d',movie$일)
as.Date(str_c(movie$년, v_mon, v_day), '%Y%m%d')

# [ 연습 문제 ]
# movie 파일을 읽고 연령대별 이용률이 가장 높은 요일을 
# 이용률과 함께 출력
library(doBy)
aggregate(이용_비율... ~ 연령대, data = movie, FUN = mean)

df1 <- aggregate(이용_비율... ~ 연령대 + day, 
                data = movie, 
                FUN = mean)

df2 <- aggregate(이용_비율... ~ 연령대, data = df1, FUN = max)

merge(df1,df2, by=c('연령대','이용_비율...'))

# 2. card_history.csv 파일을 읽고 다음과 같이 일별 업종 지출비율 출력
# (식료품 내 1일 지출 비율, 식료품 내 2일 지출비율을 의미..)
# 단, 총합은 출력할 필요 없고 확인만..
card <- read.csv('card_history.csv', stringsAsFactors = F)

# NUM   식료품     의복    외식비      책값  온라인소액결제    의료비
#    1 2.438718 3.622362  3.056148  3.068783       3.005904 3.0303030
#    2 2.790698 3.049877  2.487562  2.751323       1.771337 2.0517677
#    3 3.092395 2.241812  2.665245  2.328042       4.025765 2.6199495
#    4 2.803268 3.161334  2.736318  8.253968       2.093398 4.4349747
#    
# 총합    100      100       100       100 

# step1) 천단위구분기호 제거 및 숫자변경
f1 <- function(x) {
  as.numeric(str_remove_all(x,','))
}

card[,] <- apply(card, c(1,2), f1)

# step2) 각 비율 구하기
# sol1) 각 컬럼별로 따로 계산
card$식료품 / sum(card$식료품) * 100
card$의복 / sum(card$의복) * 100
....
card$의료비 / sum(card$의료비) * 100

# sol2) 적용함수 사용하여 전체 적용
f2 <- function(x) {
  x / sum(x) * 100
}

apply(card[, -1], 2, f2)
card[, -1] <- sapply(card[, -1], f2)

apply(card, 2, sum)

# [ 예제 - 위 데이터를 일별 각 품목의 지출비율로 변경 ]
t(apply(card[, -1], 1, f2))


# sqldf
# - R내부에서 sql 문법을 통해 데이터 처리 가능하게 하는 함수
# - ansi 표준, oracle 표준 모두 적용 가능
# - 몇가지 전달되지 않는 표현식 있어 주의
install.packages('sqldf')
library(sqldf)

install.packages('googleVis')
library(googleVis)

Fruits          # googleVis 패키지에 포함된 데이터

# 예제1) Fruits 데이터에서 2010년 데이터의 과일이름, sales 출력
Fruits[Fruits$Year == 2010, c('Fruit','Sales')]            # in R
sqldf('select Fruit, Sales from Fruits where Year = 2010') # in sql

# 예제2) Fruits 데이터에서 Apples, Oranges 데이터만 출력
Fruits[Fruits$Fruit %in% c('Apples','Oranges'), ]
sqldf("select * from Fruits where Fruit in ('Apples','Oranges')")
sqldf('select * from Fruits where Fruit in (\'Apples\',\'Oranges\')')

# 예제3) 각 과일별 Sales의 총 합
tapply(Fruits$Sales, Fruits$Fruit, sum)

v_sql <- 'select Fruit, sum(Sales) AS "Sum_Sales"
            from Fruits
           group by Fruit'

sqldf(v_sql)

# 예제4) emp 데이터의 각 부서별 최대연봉자 이름, 
# 부서번호, 연봉출력
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

# 예제5) emp 데이터에서 3건만 출력
emp[1:3,]                                    # in R
sqldf('select * from emp where rownum <= 3') # in sql(실행불가)
sqldf('select * from emp limit 3')           # in R 








