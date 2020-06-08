# 적용함수 : 반복연산을 도와주는 함수
# 1. apply(X,
#          MARGIN,
#          FUN,
#          ...)
# - X에는 1차원(벡터) 데이터가 올 수 없음(2차원 이상 적용가능)
# - 주로 행별, 열별 반복연산을 연산하기 위한 함수
# - R에서는 2차원 데이터의 "원소별" 적용도 가능
# - 출력결과는 벡터, 리슽, 행렬, 배열
# - 데이터프레임 출력 불가

# 예제) iris 데이터에서 각 컬럼별 평균
apply(iris[,-5], 2, mean)
apply(iris[,-5], 1, mean)

# 예제) 다음의 벡터에 천단위 구분기호 제거(적용함수 사용)
v1 <- c('1,100', '2,200')

apply(v1, c(1,2), str_replace_all,',','')  # 벡터적용 불가
sapply(v1,str_replace_all,',','')          # 벡터적용 가능

# [ 참고 : apply 적용 결과를 원본 데이터 프레임에 전달하는 방법 ]
df1 <- data.frame(a=c('1,000','2,000'),
                  b=c('3,000','4,000'),
                  stringsAsFactors = F)

rownames(df1) <- c('A','B')

df1 <- apply(df1,c(1,2), str_remove_all,',')
df1[,] <- apply(df1,c(1,2), str_remove_all,',')
class(df1)

# 2. lapply(list, function, ...)
# - 원소별 적용 가능
# - 출력결과 주로 리스트
lapply(df1,str_remove_all,',')

# 3. sapply(list, function, ...)
# - 주로 벡터의 원소별 함수 적용, 2차원 적용 가능
# - 출력 결과 주로 벡터
# - 함수의 추가적 인자 전달 가능
sapply(df1,str_remove_all,',')

# 4. tapply(vector,    # 연산대상
#           index,     # group by 컬럼
#           function)  # 적용함수

# - oracle group by 기능과 비슷
# - 그룹 컬럼, 그룹을 표현하는 벡터를 index에 전달
# - 출력결과 주로 벡터

tapply(iris$Sepal.Length, iris$Species, mean)
tapply(iris$Sepal.Length, iris$Species == 'setosa', mean)

tapply(iris[,-1], iris$Species, mean)   # 2차원 적용 불가

iris$Species == 'setosa'

# [ 연습 문제 ]
# emp.csv 파일을 읽고
emp <- read.csv('emp.csv', stringsAsFactors = F)

# 1) 부서별 평균연봉
tapply(emp$SAL, emp$DEPTNO, mean)

# 2) 상/하반기 입사자의 평균연봉
tapply(emp$SAL, 
       as.numeric(substr(emp$HIREDATE,6,7)) < 7, 
       mean)

# 5. mapply(function, ...)
mapply(str_remove_all,df1,',')

# [ 연습 문제 ]
# 2000-2013년_연령별실업율_40-49세.csv 파일을 읽고
# 2005년~2009년에 대해 각 월별, 년도별 실업률 평균
# 단, 년도 선택은 년도만 사용하여 표현, 예) year >= 2005
df2 <- read.csv('2000-2013년_연령별실업율_40-49세.csv')

# 컬럼이름 변경
colnames(df2)[-1] <- substr(colnames(df2)[-1],2,5)
colnames(df2)[-1] <- str_remove_all(colnames(df2)[-1],'[X년]')

# 년도별 평균
apply(df2[,-1], 2, mean)

df2[1,2] <- NA
apply(df2[,-1], 2, mean, na.rm=T)

# 일별 평균
df2[1,2] <- 4
apply(df2[,-1], 1, mean)

# [ 적용함수 비교 ]
# 1차원 데이터 적용 시
apply - 불가
sapply, lapply, mapply 가능

# 2차원 데이터 원소별 적용 시
df3 <- data.frame(a=1:5,b=6:10)

f1 <- function(x) {
  return(x+10)
}

f2 <- function(x) {
  if (x <= 5) {
    return(x*10)
  } else {
    return(x*20)
  }
}

apply(df3,c(1,2),f1)
sapply(df3,f1)
lapply(df3,f1)
mapply(f1, df3)

apply(df3,c(1,2),f2)  # 원소별 적용(1:1 치환)
sapply(df3,f2)        # key별 적용
lapply(df3,f2)        # key별 적용
mapply(f2, df3)       # key별 적용

# [ 연습 문제 ]
# apply_test.csv 파일을 읽고
# 부서별 판매량의 총 합을 구하세요.
# 단, 각 쉘이 -인 경우는 0으로 치환 후 계산
# (치환함수의 적용으로 풀이)
df1 <- read.csv('apply_test.csv', stringsAsFactors = F)

# step1) NA치환
ifelse(is.na(df1), 0, df1)     
str_replace_all(df1,'-','0')

f1 <- function(x) {
  if (is.na(x) | x == '-') {
    return(0)
  } else {
    return(x)
  }
}

df1[,] <- apply(df1, c(1,2), f1)  # 2차원에 대한 원소별 적용 가능
sapply(df1, f1)                   # 2차원에 대한 원소별 적용 불가

# step2) 2010~2013 총 합
str(df1)

as.numeric(df1[,-1])                      # 2차원 적용 불가
df1[,-1] <- sapply(df1[,-1], as.numeric)  # 2차원 적용 가능
df1$total <- apply(df1[,-1], 1, sum)

# step3) 부서번호 추출
str_split("10-smith",'-')[[1]][1]

f2 <- function(x) {
  str_split(x,'-')[[1]][1]
}

df1$deptno <- sapply(df1$deptno.name,f2)

# step4) 부서별 총 합
tapply(df1$total, df1$deptno, sum)



# [ 정리 : sapply가 2차원 데이터셋에 적용 가능한 경우 ]
sapply(data.frame, function)

# 1. data.frame의 첫번째 컬럼을 벡터형식으로 function에 전달
# 2. function이 벡터를 전달받아 벡터를 리턴하면 수행가능
#               벡터를 전달받아 벡터연산 불가하면 수행불가

# ex) 
f3 <- function(x) {
  if (x < 1.1) {
    return(1)
  } else {
    return(2)
  }
}

sapply(iris[,-5],sum)  # O
sapply(iris[,-5],f3)   # X













