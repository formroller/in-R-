# R 자료구조
# 1.스칼라
# 2.벡터(vector)
# 3.행렬(matrix)
# 4.배열(array)
# 5.데이터프레임(data.frame)

# 벡터
- 1차원
- 단 하나의 데이터 타입만 허용

# 1.벡터의 생성
v1 <- c(1,2,3) ; v1
v2 <- c('a',1) ; v2
v3 <- 1:10     ; v3

# 2.벡터의 확장
c(v1,4)                         # 맨 끝에 추가
append(x=v1, values=4, after=2) # 중간위치 추가 가능

# 3.벡터의 산술연산
v4 <- c(10,20,30)
v5 <- c(10,20,30,40)

v1 + 1     # 벡터와 스칼라 연산 가능
v1 + v4    # 서로 크기가 같은 벡터 연산 가능
v1 + v5    # 서로 크기가 다른 벡터는 작은 벡터가 반복연산

#  10 20 30 40 
# + 1  2  3  1  
# -------------
#  11 22 33 41

# 4.벡터의 색인(indexing, 추출)
# 1) 정수색인
v1[1]       # 첫번째 원소 추출
v1[c(1,3)]  # 첫번째, 세번째 원소 추출
v1[-1]      # 첫번째 원소 제외 추출

# 2) 이름색인
names(v1)      # 벡터의 각 원소이름 출력
names(v1) <- c('a','b','c')
v1['a']
v1[-'a']       # 이름색인에 - 사용 불가 
v1[c('a','b')]

# 3) 조건색인(불리언색인)
v1[c(T,F,F)]
v1[v1 < 2]    # where v1 < 2

# 4) 슬라이스색인(연속추출)
v2 <- 1:10
v2[4:8]
v2[c(4,5,6,7,8)]
v1['b':'c']

# 참고 : 2차원 데이터에서의 색인
df1 <- read.csv('emp.csv')
df1[1,2]

# smith의 이름, 입사일, 연봉 추출
df1[1,c(2,5,6)]

# smith와 allen의 이름과 연봉 추출
df1[c(1,2), c(2,6)]
df1[c(1,2), c('ENAME','SAL')]

df1[1,1] <- 7360
  
# sal이 2000이상인 직원 이름, sal 추출
select ENAME,SAL
  from emp
 where sal >= 2000;

df1$SAL >= 2000      # 각 행마다 조건 결과 추출

df1[df1$SAL >= 2000 , c('ENAME','SAL') ]  

# [ 연습문제 ]
# 1) emp.csv 파일을 읽고 10번 부서원의 이름, job, sal 출력
df1 <- read.csv('emp.csv')
df1[df1$DEPTNO == 10, c('ENAME','JOB','SAL')]

# 2) 20번 부서원의 sal의 총 합 출력
sum(df1[df1$DEPTNO == 20, 'SAL'])

# 3) 이름이 scott과 king인 사람의 이름, 사번, sal 출력

df1[df1$ENAME %in% c('SCOTT','KING'),
    c('ENAME','EMPNO','SAL')]

df1[(df1$ENAME == 'SCOTT') | (df1$ENAME == 'KING'),
    c('ENAME','EMPNO','SAL')]

# 5.벡터 수정
v1[2] <- 20 ; v1
v2[2:5] <- seq(20,50,10) ; v2

# 예제) v1벡터에 마지막에 4 삽입, 원소이름을 d 부여
c(v1,4)
v1 <- append(v1,4)
names(v1)[4] <- 'd' ; v1 

# 6. 벡터 크기 확인
length(v1)  # 1차원인 벡터의 크기 확인
NROW(v1)    # 행의 개수, 1차원일 경우는 원소의 개수 출력
nrow(v1)    # 행의 개수, 2차원에서만 

nrow(df1)

# 논리연산자
# 1) and 연산자
T & T
T & F

# 2) or 연산자
T | T
T | F

v1[(v1 > 1) & (v1 < 3)]

# 3) not 연산자
!(v1 > 1)
v1 != 1
!(v1 == 1)

# 예제) v2에서 3보다 작거나 같고 8보다 크거나 같은 값출력
v2 <- 1:10
v2[(v2 <= 3) | (v2 >= 8)]

# 포함연산자
(v1 == 1) | (v1 == 3)
v1 %in% c(1,2)  # or 연산의 축약형
1 %in% v1       # v1에 1 포함 여부

# 형 확인 함수
is.character('a')

is.vector(df1)

is.na(1)
is.null(1)

# 예제) 다음의 v3에서 NA인 원소만 찾아 2로 수정
v3 <- c(1,NA,3,4)
is.na(v3)

v3[is.na(v3)] <- 2

# factor형 변수







