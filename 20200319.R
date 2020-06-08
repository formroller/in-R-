# sampling : 데이터 분석시 필요
# 주로 raw data의 70%를 train data(모델 생성에 필요한 데이터 셋),
# 30%를 test data(모델 평가에 필요한 데이터 셋)으로 분리하여 사용

# 1. sample(x, size,replace, prob)
# - 주로 row number에 해당하는 숫자를 사용하여 추출, 데이터 분리
# - 반대 data set 추출이 용이함(train 추출 후 test 추출이 쉬움)
# - class별 정확한 균등 추출 불가(비교적 균등)

# [ 예제- iris data를 70,30%로 분리 ]
# 1) row number : sample size 개수가 정확하게 70%
v_rn <- sample(1:nrow(iris), size = 0.7 * nrow(iris))
iris_train <- iris[v_rn, ]
iris_test <- iris[-v_rn, ]

table(iris_train$Species)    # class별 균등 추출 여부 확인
table(iris_test$Species)  

# 2) group number : sample size 개수가 비교적 70%와 비슷하게
v_gn <- sample(1:2, size=nrow(iris), replace=T, prob=c(0.7,0.3))

iris_train2 <- iris[v_gn==1, ]
iris_test2  <- iris[v_gn==2, ]

# 각 데이터 개수 확인
nrow(iris_train2)   # 102건(위와 다름 != 105)
nrow(iris_test2)    # 48건(위와 다름 != 105)

# class별 균등 추출 여부 확인
table(iris_train2$Species)    
table(iris_test2$Species)  

# 2. doBy::sampleBy(formula,   #  ~ 균등추출이 필요한 컬럼 
#                   frac,      # 추출비율
#                   replace,   # 복원추출 여부
#                   data)      # 원본 데이터
# - 데이터에서 직접 frac에 해당하는 row를 랜덤 추출
# - row number 추출을 통한 추가 색인 불필요
# - class별 정확한 균등 추출 가능
# - 반대 data set 추출이 불편함
library(doBy)
iris_train3 <- sampleBy( ~ Species, data=iris, frac = 0.7)

nrow(iris_train3)           # 정확한 70%의 sample size
table(iris_train3$Species)  # 정확한 균등 추출

# [ 연습 문제 ]
# sampleBy 함수를 사용하여 iris data를 각각 70,30%로 분리
iris_train3 <- sampleBy( ~ Species, data=iris, frac = 0.7)

# 1) 
f_split <- function(x) {
  as.numeric(str_split(x,'\\.')[[1]][2])
}

v_rn3 <- sapply(rownames(iris_train3), f_split)
iris_test3 <- iris[-v_rn3, ]

nrow(iris_test3)   # 45
table(iris_test3$Species)   # 15,15,15

# 2) 
v_rn4 <- as.numeric(str_remove_all(rownames(iris_train3),'\\D'))


# merge : 두 데이터프레임의 조인
merge(x,           # 조인대상
      y,           # 조인대상
      by = ,       # 조인컬럼(양쪽 동일 이름 컬럼일 경우)
      by.x = ,     # 첫번째 데이터프레임의 조인 컬럼
      by.y = ,     # 두번째 데이터프레임의 조인 컬럼
      all = ,      # full outer join 여부
      all.x = ,    # left outer join 여부
      all.y = )    # right outer join 여부  

# - inner join이 기본 연산(조인연산에 맞지 않는 데이터 생략)
# - 단 두 개의 데이터프레임만 조인 가능
# - non equi join 불가
# - 조인컬럼이 여러 개일 경우는 벡터로 묶어서 전달

std <- read.csv('student.csv', stringsAsFactors = F)
pro <- read.csv('professor.csv', stringsAsFactors = F)

# [ 예제 - 학생 데이터에 지도교수 이름 추가 ]
# 1) merge
merge(std, pro, by='PROFNO', all.x = T)

# 2) 사용자 정의함수 생성을 통한 조인
v_prof <- std[std$STUDNO == 9411, 'PROFNO']
pro[pro$PROFNO == v_prof, 'NAME']

f_name <- function(x) {
  v_prof <- std[std$STUDNO == x, 'PROFNO']
  if (is.na(v_prof)) {
    return(NA)
  } else {
    pro[pro$PROFNO == v_prof, 'NAME']
  }
}

sapply(std$STUDNO, f_name)

# [ 예제 - emp.csv 파일을 읽고 각 직원의 상위관리자 이름 출력 ]
emp <- read.csv('emp.csv', stringsAsFactors = F)
merge(emp, emp, by.x = 'MGR', by.y = 'EMPNO', all.x = T)


# [ 연습문제 ]
# gogak, gift 테이블 데이터를 데이터베이스로부터 불러온 후,
# 각 직원의 수령상품을 출력(조인은 R 문법으로)
library(RJDBC)

# get_query는 func1 바이너리 파일에 저장된 사용자 정의 함수임
load('func1')
gogak <- get_query('select * from gogak')
gift <- get_query('select * from gift')

f_gift <- function(x) {
  v_point <- gogak[gogak$GNO == x, 'POINT']
  gift[(gift$G_START <= v_point) & (v_point <= gift$G_END),'GNAME']
}

f_gift(20010020)
f_gift(gogak$GNO)
sapply(gogak$GNO, f_gift)

# 최대값 최소값 리턴
max(emp$SAL)       # 벡터의 최대값 직접 리턴
which.max(emp$SAL) # 벡터의 최대값을 갖는 행 번호 리턴

# [ 예제 - emp.csv 파일에서 최대 연봉자의 이름 출력 ]
emp[emp$SAL == max(emp$SAL), 'ENAME']
emp[which.max(emp$SAL), 'ENAME']

# aggregate 
# - group by 연산 수행
# - 출력 결과 데이터 프레임
# - 문법이 두가지 존재

aggregate(x,   # 연산대상
          by,  # group by 컬럼(리스트 전달)
          FUN) # 적용함수

aggregate(formula,  # 연산 컬럼 ~ group by 컬럼
          data,     # 데이터프레임
          FUN)      # 적용함수

# 연산대상 1개, group by 컬럼 1개
# 예제) emp 테이블에서의 부서번호별 연봉 평균
aggregate(emp$SAL, by=list(emp$DEPTNO), FUN=mean)
aggregate(SAL ~ DEPTNO, data=emp, FUN=mean)

as.data.frame(tapply(emp$SAL, emp$DEPTNO, mean))

# 연산대상 2개, group by 컬럼 1개
# 예제) student 테이블에서 학년별 키, 몸무게 평균
aggregate(std[,c('HEIGHT','WEIGHT')], 
          by=list(std$GRADE), 
          FUN=mean)

aggregate(HEIGHT + WEIGHT ~ GRADE,      # +가 컬럼 추가로 해석 X
          data=std, 
          FUN=mean)

aggregate(cbind(HEIGHT,WEIGHT) ~ GRADE, 
          data=std, 
          FUN=mean)


# 연산대상 1개, group by 컬럼 2개
# emp 테이블에서 부서별, job별 sal의 평균
aggregate(emp$SAL, 
          by=list(emp$DEPTNO, emp$JOB), 
          FUN=mean)

aggregate(SAL ~ DEPTNO + JOB, 
          data=emp, 
          FUN=mean)


# [ 연습 문제 ]
# student.csv 파일과 exam_01.csv 파일을 읽고
exam <- get_query('select * from exam_01')

# 1) 각 학년별 시험성적의 평균을 구하세요.
# 2) 각 학년별 최고성적을 갖는 학생 이름, 성적, 학년 출력














