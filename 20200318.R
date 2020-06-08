# [ apply 실습 정리 ]
# 공유폴더 -> 2.R -> 3.수업실습 -> data -> apply_test2.csv
df1 <- read.csv('apply_test2.csv', stringsAsFactors = F)

rownames(df1) <- df1$name
df1$name <- NULL

# 0. 각 문자열 공백 제거 : 전체적용 => apply
str_trim(' 1234 ')
str_trim(df1)
df1[,] <- apply(df1, c(1,2), str_trim)

# 1. NA 처리 : 전체적용 => apply
# sol1) 사용자 정의 함수
f1 <- function(x) {
  if (x=='-' | x=='?' | x=='.') {  # x %in% c('?','.','-')
    return(0)
  } else {
    return(x)
  }
}

f1('-')
f1(2222)
apply(df1, c(1,2), f1)
sapply(df1, f1)

# sol2) 치환 함수
str_replace_all('a.?b-','[.?-]','0')
str_replace_all(df1,'[.?-]','0')

df1[,] <- apply(df1, c(1,2), str_replace_all, '[.?-]','0')

# 2. 천단위 구분기호 제거 및 숫자 변경 : 전체적용 => apply
f2 <- function(x) {
  as.numeric(str_remove_all(x,','))
}

apply(df1, c(1,2), f2)
df1[,] <- sapply(df1, f2)
str(df1)

# 3. 년도와 분기 분리 : 벡터적용 => sapply
v_year <- substr(colnames(df1),2,5)
v_qt <- substr(colnames(df1),7,7)

f3 <- function(x,ord) {
  str_remove(str_split(x,'\\.')[[1]][ord],'X')
}

sapply(colnames(df1), f3, 1)
sapply(colnames(df1), f3, 2)

# 문제) 각 지점의 1분기 매출의 총 합
df1[ , str_detect(colnames(df1), '1$')]
apply(df1[ , v_qt == '1'], 1, sum)


# doBy 패키지 : 주로 그룹에 대한 연산을 도와주는 함수 포함
install.packages('doBy')
library('doBy')

# 정렬
# 1. order(...,              # 데이터(벡터들)
#          na.last = ,       # NA 배치 순서
#          decreasing = F)   # 내림차순 정렬 여부
# - 출력값은 정렬된 벡터가 아닌 위치값
# - 위치값을 사용한 색인을 통해서만 순서대로 배치된 벡터 출력 가능

v1 <- c(10,1,3,2,9,5)
order(v1)
v1[order(v1)]

df1[order(df1[,1]), ] # 컬럼정렬 위치값을 통해 데이터프레임 정렬가능

# 2. sort(x,                 # 데이터(벡터)
#         decreasing = F)    # 내림차순 정렬 여부
sort(v1)

sort(df1[,1])  # 컬럼값이 바로 출력되서 데이터프레임 정렬로 사용불가

# [ 연습 문제 ]
# 1. emp.csv 파일을 읽고 연봉이 큰 순서대로 정렬하여 출력
emp <- read.csv('emp.csv', stringsAsFactors = F)

v_ord <- order(emp$SAL, decreasing = T)  # 행 순서
emp[v_ord, ]  # 행 순서

# 2. 부서번호 순으로 정렬
# 단, 같은 부서내에서는 연봉이 큰 순서대로 정렬하여 출력
v_ord <- order(emp$DEPTNO, emp$SAL, decreasing = c(F,T))
emp[v_ord, ]

# 1. doBy::orderBy
orderBy(formula = ,  # Y ~ X1 + X2 , .., -Xn
        data = )     # 데이터(데이터프레임)

orderBy( ~ DEPTNO - SAL, data = emp)
orderBy( ~ DEPTNO + SAL, data = emp)

# [ 연습 문제 ] 
# student.csv 파일을 읽고
# 남,여 순서대로 데이터를 정렬하고, 같은 성별내에서는 키가 높은순
std <- read.csv('student.csv', stringsAsFactors = F)
std$GD <- ifelse(substr(std$JUMIN,7,7)=='1','남자','여자')

v_ord <- order(std$GD, std$HEIGHT, decreasing = c(F,T))
std[v_ord, ]

orderBy( ~ GD - HEIGHT, data=std)

# 2. doBy::sampleBy
# sampling
1. sample(x,            # 데이터 
          size = ,      # 추출할 샘플 사이즈
          replace = ,   # 복원추출여부
          prob = )      # 추출비율

sample(1:150, size = 1)
sample(c(1,2,3,10,11,16), size = 1)

sample(1:2, size=150, replace = T, prob = c(0.7,0.3))
???
  
# [ 예제 - iris 데이터를 랜덤하게 70%, 30% 두 그룹으로 분리 ]
# sol1)
v_rn <- sample(1:nrow(iris), size = nrow(iris) * 0.7)
iris_train <- iris[v_rn, ]
iris_test <- iris[-v_rn, ]


2. sampleBy(formula = , 
            frac = , 
            replace = ) 




# 3. doBy::summaryBy
# 각 컬럼 요약 값 얻기
# 1. summary 
# - 숫자컬럼은 최대,최소,각 분위값 등 출력
# - 문자컬럼은 각 항목별 count
summary(iris)

# 2. summaryBy(formula = , # 요약컬럼 ~  그룹컬럼
#              data = ,    # 데이터(데이터프레임)
#              FUN= )      # 연산함수
# - 전체 컬럼을 특정 그룹으로 나눠서 요약
# - summary처럼 많은 요약 정보를 한 번에 볼 수는 없음

summaryBy(Sepal.Length ~ Species, data=iris)
summaryBy(Sepal.Length ~ Species, data=iris, FUN = max)
summaryBy(Sepal.Length + Sepal.Width ~ Species, 
          data=iris, 
          FUN=max)





