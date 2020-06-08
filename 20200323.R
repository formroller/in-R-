# plyr 패키지 
# - apply 계열 함수들과 비슷
# - 출력 결과 주로 데이터 프레임
# - {입력}{출력}ply 형식의 함수 제공
# - adply : array입력 - dataframe 출력
# - ddply : dataframe 입력 - dataframe 출력

install.packages('plyr')
library(plyr)

# 1. adply
# - 2차원 데이터 셋 입력(array, matrix, data.frame 가능)
# - data.frame 출력
# - apply함수와 비슷(행별, 열별 그룹연산 주로 수행)
# 

apply(iris[,-5], 1, mean)
apply(iris[,-5], 2, mean)

adply(iris[,-5], 1, sum) # 컬럼추가 형식은 가능, 
                         # 기존데이터와 함께 출력 
adply(iris[,-5], 2, sum) # 로우추가 형식은 불가
                         # 기존데이터와 함께 출력 불가

# [ 중요 : adply에 mean함수가 NA가 리턴되는 현상 ]
adply(iris[,-5], 1, mean)

# 이유) 데이터프레임 입력시 분리된 데이터 셋이 데이터프레임,
#       즉 데이터프레임 형식으로 함수에 전달(적용)함

v1 <- 1:10
df1 <- data.frame(v1)

sum(v1)
sum(df1)

mean(v1)
mean(df1)

# 해결) 입력 데이터셋의 key형식 탈락, matrix 형식으로 전달
adply(as.matrix(iris[,-5]), 1, mean)


# 2. ddply
# - data.frame 입력, data.frame 출력
# - 그룹연산 수행 함수

# 문법 
# ddply(data,       # 데이터프레임
#       variables,  # group by 컬럼 .(col1, col2)형식 전달)
#       fun,        # ddply 내부함수
#       ...)        # group by 표현식 

# ddply 내부함수
# 1. transform : 원본 데이터프레임에 그룹연산 수행결과 같이 표현
# 2. mutate    : transform과 비슷하나 연산결과 재사용 가능
# 3. summarise : 일반 group by 수행함수, 그룹연산의 요약정보 출력
# 4. subset    : 그룹연산 수행결과에 조건 전달 가능

# [ 예제 - emp데이터에서 부서별 평균연봉 ] 
ddply(emp, DEPTNO, summarise, v1=mean(SAL))
ddply(emp, .(DEPTNO), summarise, v1=mean(SAL))
ddply(emp, .(DEPTNO), transform, v1=mean(SAL))

# [ 예제 - emp데이터에서 부서별 최대 연봉자 출력 ] 
# 1)
df_max <- ddply(emp, .(DEPTNO), transform, sal_max=max(SAL))
df_max[,c(1,2,6,7,8,9)]

df_max[df_max$SAL == df_max$sal_max, ]

# 2) 
ddply(emp, .(DEPTNO), subset, SAL==max(SAL))

# [ 예제 - emp 데이터에서 각 부서별 평균연봉을 구하고, log값 리턴]
ddply(emp, .(DEPTNO), transform, v1=mean(SAL))
ddply(emp, .(DEPTNO), transform, v1=mean(SAL),
                                 v2=log(v1))   # v1 재사용 불가

ddply(emp, .(DEPTNO), mutate, v1=mean(SAL),    # v1 재사용 가능
                              v2=log(v1))

# [ 연습문제 ]
# 1. emp데이터에서 부서별 평균연봉보다 적은 연봉을 받는 사원 출력
ddply(emp, .(DEPTNO), subset, SAL < mean(SAL))

# 1. student 데이터를 읽고 
std <- read.csv('student.csv', stringsAsFactors = F)

# 1) 각 학년별 몸무게의 최대 값 출력
tapply(std$WEIGHT, std$GRADE, max, na.rm=T)
aggregate(WEIGHT~GRADE, data=std, max, na.rm=T)
ddply(std, .(GRADE), summarise, V1=max(WEIGHT, na.rm=T))

# 2) 키가 학년별 평균 키보다 작은 학생 출력
ddply(std, .(GRADE), subset, HEIGHT < mean(HEIGHT))

# 3) 각 학년별 몸무게, 키의 최대 값 출력
# (그룹연산 컬럼 두개 이상인 경우)
aggregate(cbind(HEIGHT,WEIGHT)~GRADE, data=std, max)
ddply(std, .(GRADE), summarise, V1=max(HEIGHT),
                                V2=max(WEIGHT))

# [참고 - 서로 다른 그룹 연산함수 전달 ]
aggregate(cbind(HEIGHT,WEIGHT)~GRADE, data=std, c(max,min)) # 불가
ddply(std, .(GRADE), summarise, V1=max(HEIGHT),
                                V2=min(WEIGHT))             # 가능

# [ 연습문제 ] 
# delivery.csv 파일을 읽고
# 각 읍면동별 통화건수의 총 합을 구하되, 
# (단, 각 동은 숫자를 포함하고 있는 경우 
# 숫자를 제외한 동까지 표현하도록 함 (ex 을지로6가 => 을지로))
library(stringr)
unique(de$읍면동)

str_remove_all(de$읍면동,'[0-9가]')
str_split(de$읍면동[990],'[0-9]')[[1]][1]

f1 <- function(x) {
  str_split(x,'[0-9]')[[1]][1]
}

de$읍면동 <- sapply(de$읍면동, f1)
unique(de$읍면동)

ddply(de, .(읍면동), summarise, CNT=sum(통화건수))


# 데이터 구조 변경 : stack, unstack
# 1. stack(x) : wide -> long 데이터로 변경
# 2. unstack(data, formular) : long -> wide 데이터로 변경

# 예) 각 지점별 분기별 판매량 데이터
# wide data
# - 교차 테이블
# - 행별, 컬럼별 그룹연산 수행 가능
# - 조인불가

#     1  2  3  4
# A  10 11 ...
# B
# C
# D

# long data(tidy data)
# - database에서 선호하는 데이터 형식
# - 새로운 데이터(관찰대상)에 대한 추가가 비교적 용이
# - group by 연산 가능
# - 조인 연산 가능

# 지점 분기 판매량
# A    1     10      
# A    2     11  
# ....
# D    4     20


# [ 예제 - 다음의 데이터 프레임에 대해 stack, unstack 처리 ]
df1 <- data.frame(apple=c(10,20,30), 
                  banana=c(11,9,8), 
                  mango=c(3,4,5))
df2 <- stack(df1)
unstack(df2, values ~ ind)

# [ 연습 문제 ]
# melt_ex.csv 파일을 읽고 라떼의 수량에 대해 아래의 교차 테이블 완성
#         1   2   3  4  5 ....   12
# 2000  400 401 402  .
# 2001  412

df2 <- read.csv('melt_ex.csv')
df3 <- unstack(df2, latte ~ mon)
rownames(df3) <- c(2000,2001)
colnames(df3) <- str_c(1:12,'월')

# reshape2 : melt, dcast처럼 데이터 형식 변경을 위해 필요한 패키지
# 1. melt 
# - wide -> long 데이터 변경
# - stack과 비슷
# - 전체 컬럼이 아닌 일부컬럼 선택 및 제외 가능
install.packages('reshape2')
library(reshape2)

melt(data,            # 데이터프레임
     id.vars,         # 쌓지 않을 고정 컬럼
     measure.vars,    # 쌓을 컬럼, 생략시 id.vars 제외 모두 선택
     value.name = ,   # value 컬럼 이름
     variable.name =) # ind 컬럼 이름         

# [ 예제 - 위 melt_ex.csv 파일을 다음과 같은 형식으로 변경 ]
# year mon  name qty
# 2000   1 latte 400 
melt(df2, id.vars = c('year','mon'),
     variable.name = 'name',
     value.name = 'qty')

# [ 연습 문제 ] 
# 2000-2013년_연령별실업율_40-49세.csv 파일을 읽고
# 해당 데이터를 년도별 월별 정리된 형태(tidy)로 출력
df4 <- read.csv('2000-2013년_연령별실업율_40-49세.csv')
melt(df4, id.vars = '월', variable.name = '년도',
                          value.name = '실업률')



