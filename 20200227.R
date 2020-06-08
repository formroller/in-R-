# is.na의 활용
v1 <- c(1,2,NA,3,4,NA,5,6)
v2 <- c(1,2,NULL,3,4,NULL,5,6)
sum(v1)
sum(v2)

v1[is.na(v1)] <- 0
sum(v1)

# 연산자 사용시 주의
c(T,T,T) & c(T,F,T)   # 각 원소마다 연산 수행
c(T,T,T) && c(T,F,T)  # 첫번째 원소만 연산 수행

# 예제) v3에서 7보다 크고 10보다 작은 값 출력
v3 <- 1:10 
v3
(v3 > 7) && (v3 < 10)
v3[(v3 > 7) & (v3 < 10)]


# [ 벡터 연습문제 ]
# 1. 2015/01/01 ~ 2015/01/31 일별 날짜 생성
seq(as.Date('2015/01/01'),as.Date('2015/01/31'),1)

# 2. 감 제외
vec1 <- c('사과','배','감','버섯','고구마')
vec1[-3]
vec1[vec1 != '감']

# 3. 다음 수행
vec1 <- c('봄','여름','가을','겨울')
vec2 <- c('봄','여름','늦여름','초가을')

# 1) vec1과 vec2를 합친 결과
c(vec1,vec2)
append(vec1,vec2)
union(vec1,vec2)

# 2) vec1에는 있는데 vec2에는 없는 결과
vec1[!vec1 %in% vec2]
setdiff(vec1,vec2)

# 3) vec1과 vec2 둘다 있는 결과
vec1[vec1 %in% vec2]
intersect(vec1,vec2)

# 집합연산자
t1 <- c('a','b','c','d')
t2 <- c('a','e','f')
t3 <- c('a','e','e','f')

# 1) 합집합 : union
union(t1,t2)  # 중복 제외 합집합 출력

# 2) 교집합 : intersect
intersect(t1,t2) 

# 3) 차집합 : setdiff
setdiff(t1,t2)

# 4) 동등비교 : identical, setequal
# - identical : 구성하는 원소, 크기가 모두 같은지 확인
# - setequal : 구성하는 원소가 같은지 확인(크기상관X)
identical(t2,t3) # FALSE
setequal(t2,t3)  # TRUE


# 리스트
# - 층을 가지는 구조
# - key-value 구조
# - key 내부는 벡터로 구성, 동일한 데이터 타입만 가능

# 1. 생성
l1 <- list('a'=1, 'b'=2, 'c'=3)
l2 <- list('a'=c(1,2), 'b'=c(2,3,4), 'c'=3) ; l2
l2 <- list('a'=c(1,2), 'b'=c(2,3,4), 'c'='a') ; l2

# 2.색인
l2$a     # 키색인, 벡터로 리턴
l2['a']  # 리스트로 리턴
l2[1]    # 1층 추출, 리스트로 리턴
l2[[1]]  # 1층 추출, 벡터로 리턴
l2[c('a','b')]

# 3.수정
l2$d <- c(1,5,7)  # key 생성
l2$d <- NULL      # key 삭제
l2$b[3] <- 40


# [참고] 벡터의 원소에 NULL 할당 불가
v1[2] <- NULL  # 불가


# 예제) l2의 'b'층에 있는 두번째 원소(3) 출력
l2$b[2]
l2['b'][2]  # 불가, l2['b'] 대상의 두번째 층 출력요구


# [문제]
# 1-1. 아래 벡터 생성
# name   grade  jumsu    hakjum
# 서재수  4      90        A0
v1 <- c('서재수','4','90','A0')
names(v1) <- c('name','grade','jumsu','hakjum')

# 1-2. jumsu를 '성적'으로 변경
names(v1)[3] <- '성적'
names(v1)[names(v1)=='jumsu'] <- '성적'

# 2-1. 아래 리스트 생성
# name   grade  jumsu    hakjum
# 서재수  4      90        A0
# 서진수  3      80        B+
# 홍길동  2      85        B+
l1 <- list(name   = c('서재수','서진수','홍길동'),
           grade  = c(4,3,2),
           jumsu  = c(90,80,85),
           hakjum = c('A0','B+','B+')) 

# 2-2. 홍길동의 점수와 hakjum을 각각 95, A+로 변경
l1$jumsu[3] <- 95
l1$hakjum[3] <- 'A+'

l1$jumsu[l1$name=='홍길동'] <- 95
l1$hakjum[l1$name=='홍길동'] <- 'A+'
l1

# 2-3. 서진수의 jumsu 삭제(삭제불가시 없는 데이터 처리)
l1$jumsu[l1$name=='서진수'] <- NULL # 불가
l1$jumsu[l1$name=='서진수'] <- NA   # 가능


# matrix
# - 2차원구조, 행과 열로 구성
# - 동일한 데이터 타입만 허용

# 1.생성
matrix(data=1:9,    # matrix 구성 데이터
       nrow=3,      # 행의 수
       ncol=3,      # 컬럼 수
       byrow=T)     # 로우 우선순위 여부(F가 기본값)
       #dimnames = ) # 행과 열의 이름

m1 <- matrix(data=1:9,nrow=3) 

# 2.색인
m1[,1]
m1[1,]
m1[1,1]
m1[c(1,3),]
m1[,2:3]

# 예제) 3번째 컬럼이 9이상인 행 선택
m1[,3] >= 9
m1[m1[,3] >= 9, ]

m1[m1 > 5]

# 연습문제) 1부터 20값을 갖는 5X4행렬 생성 후
# 짝수값을 모두 0으로 수정하여라.
m2 <- matrix(1:20,nrow=5)
m2[m2 %% 2 == 0] <- 0

# 3.행, 컬럼 이름 수정
rownames(m1) <- 0:2                           # 벡터출력
colnames(m1) <- c('a','b','c')                # 벡터출력
dimnames(m2) <- list(1:5, c('a','b','c','d')) # 리스트출력

# [참고] : 색인시 주의사항
# m1에서 2,3번째 행의 'b'컬럼 각각 50,60으로 수정
m1
m1[c(2,3),'b']      # 위치색인(숫자전달)
m1[c('1','2'),'b']  # 이름색인(문자전달)

rownames(m1)    # 기존에 부여한 0~2는 문자이름으로 저장됌

# 4.구조변경
rbind(m1,c(10,11,12))
cbind(m1,c(10,11,12))

# 5.연산
m3 <- matrix(1:4,nrow=2)
m4 <- matrix(c(10,20,30,40),nrow=2)
m5 <- matrix(1:6,nrow=2)
m6 <- matrix(c(10,20), nrow=2)

m3 + m4   # 크기가 같은 두 행렬 연산 가능
m3 + m5   # 크기가 다른 두 행렬 연산 불가
m3 %*% m6 # inner product

# 참고 : 행렬의 곱(inner product)
[x11 x12   [y1    [x11*y1+x12*y2
         *      = 
 x21 x22]   y2]    x21*y1+x22*y2]
  (2X2)  * (2X1) = (2X1)


# 6.크기확인
nrow(m1)  # 행의 수
ncol(m1)  # 컬럼 수
dim(m1)   # 행, 컬럼 수가 벡터로 동시 출력

dim(m2) <- c(4,5)
m2

# [ 연습문제 ]
v1 <- c('봄','여름','가을','겨울')

matrix(v1,nrow = 2)
seasons <- matrix(v1,nrow = 2, byrow = T)
seasons[,2,drop=F]  # 차원축소 방지

seasons_2 <- rbind(seasons, c('초봄','초가을'))
seasons_3 <- cbind(seasons_2, c('초여름','초겨울','한겨울'))

# 데이터프레임
# - 행과 열의 구조를 갖는 2차원 데이터 형식
# - 엑셀에서의 표, 데이터베이스에서의 테이블과 유사
# - key(컬럼)-value 구조를 갖음

# 1.생성
df1 <- data.frame(name   = c('smith','allen','scott'),
                  sal    = c(800,900,1000),
                  deptno = c(10,20,30),
                  stringsAsFactors = F)
# 2.구조확인
str(df1)
nrow(df1)
ncol(df1)
dim(df1)

# 3.구조변경
# 1) 행 추가
df1 <- rbind(df1, c('king',2000,10))
str(df1)
df1$sal <- as.numeric(df1$sal)
df1$deptno <- as.numeric(df1$deptno)

# [ 참고 ] : 위치값 지정을 통한 데이터 삽입
df1[5,1] <- 'hong'
df1[5,2] <- 3000
df1[5,3] <- 20

# 2) 컬럼추가
df1$comm <- c(100,0,NA,500,300)
str(df1)

df1 <- cbind(df1, c(7411,7511,7611,7711,9811))
colnames(df1)[5] <- 'deptno'

# [ 연습문제 ]
df1 <- read.csv('student.csv', stringsAsFactors = F)
str(df1)

# 4학년 학생의 키의 평균
mean(df1[df1$GRADE==4, 'HEIGHT'])




