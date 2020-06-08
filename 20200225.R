# R 환경설정
# 작업 디렉토리 확인 및 변경(임시적)
getwd()
setwd('C:/Users/KITCOOP')

# 작업 디렉토리 고정
# Tools > Global Options > General > Defalut working directory 변경

# 참고 : 여러라인 동시 주석 설정
# Ctrl + Shift + C

# 변수선언
v1 <- 1
a1 <- 1
b1 <- 2
c1 <- 3

v_sum <- a1 + b1 + c1
c2 <- 'a'
c3 <- "a   b" ; c3

# 변수의 데이터 타입 확인
d1 <- Sys.Date()
class(v1)
class(c2)
class(d1)

# 산술연산
c1 <- '10'
a1 + v1    # 숫자변수 산술연산 가능
c1 + a1    # 숫자변수 문자변수 산술연산 불가
d1 + 100   # 날짜변수 숫자변수 연산가능

# 형변환 함수
as.numeric()
as.character()
as.Date()

as.numeric(c1) + a1

# 변수에 연속적 값 할당
seq1 <- 1:10
'a':'f'       # 문자연속적 출력 불가

help(seq)
seq(from = 1, 
    to = 1, 
    by = ((to - from)/(length.out - 1)))
seq(from=1, to=10, by=1)

seq(from=as.Date('2020/01/01'), 
      to=as.Date('2020/12/31'), by='month')

# 날짜의 형변환 및 파싱
d2 <- as.Date('2020/02/05') + 100
as.character(d2, '%A')        # 요일
 
as.character(d2, '%Y/%m/%d')  # 년월일
as.character(d2, '%H:%M:%S')  # 시분초

# 함수의 사용방법
substr('abcde',2,3)
substr(x='abcde',start=2,stop=3)


# [ 연습문제 ]
# 1. 2020년 1월 1일부터 1월 31일까지 날짜를 동시 출력
d3 <- seq(from=as.Date('2020/01/01'), 
            to=as.Date('2020/01/31'), by=1)

as.character(d3,'%A')

# 2. 2020년 6월 8일부터 오늘날짜까지 남은 일수 출력 
as.Date('2020/06/08') - Sys.Date()

sum <- 1
sum(c(1,2,3))

# 변수 관리
objects()  # 선언된 변수 목록
ls()       # 선언된 변수 목록
rm(list = "sum")  # 특정 변수 삭제
rm(list = ls())   # 선언된 모든 변수 삭제

# 산술연산 기호
7 %/% 3  # 몫
7 %% 3   # 나머지
3^2      # 승수
3**3     # 승수
1e1      # 10
1e-1     # 0.1
1e2      # 100
1e3      # 1000

# NA와 NULL
cat(1,NA,2)    # 자리수 고정
cat(1,NULL,2)  # 없는 데이터이므로 자리수 고정불가

sum(1,NA,3)    # NA는 무시될 수 없음
sum(1,NULL,3)  # NULL은 무시됌

NA + 1         # NA 
NULL + 1       # numeric(0)   


# 날짜 관련 외부 패키지 : lubridate
install.packages('lubridate')
library(lubridate)

date1 <- now() ; date1
class(date1)
as.character(date1, '%Y')

year(date1)             # 년
month(date1)            # 월, 숫자형식
month(date1, label = T) # 월, 문자형식
                        # (날짜언어가 영문일때)
day(date1)              # 일
wday(date1)             # 요일 숫자 출력
wday(date1, label = T)  # 요일 이름 출력
hour(date1)             # 시
minute(date1)           # 분
second(date1)           # 초

date1 + months(6)       # 6개월 후
date1 + years(6)        # 6년 후
date1 + days(6)         # 6일 뒤
date1 + hours(6)        # 6시간 뒤

# 날짜 언어 변경
Sys.setlocale('LC_TIME', 'C')       # 영문
Sys.setlocale('LC_TIME', 'KOREAN')  # 한글
month(date1, label = T)

# [연습문제]
# 2020년 2월의 일별 데이터를 출력,
# 그중 v_year라는 컬럼(변수)에 년도만,
# v_month라는 컬럼(변수)에 월만, 
# v_day라는 컬럼(변수)에 일만 분리저장
# v_bonus_date 컬럼에 6개월 후 데이터를 입력

date2 <- seq(as.Date('2020-02-01'),
             as.Date('2020-02-28'),1) 

v_year <- year(date2)
v_month <- month(date2)
v_day <- day(date2)
v_bonus_date <- date2 + months(6)








