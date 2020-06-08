# [ 사용자정의 함수 예제 ]
# if 연습문제 3. 두 숫자를 입력해서 첫 번째 숫자가 
# 두 번째 숫자보다 클 경우 첫 번째 숫자에서 두 번째 숫자를 
# 뺀 값을 출력, 두번째 숫자가 첫번째 숫자보다 클 경우 
# 두번째에서 첫번째 숫자를 뺀 값을 출력하는 함수 myf3 생성
myf3 <- function(x,y) {
  if (x >= y) {
    return(x-y)
  } else if (x < y) {
    return(y-x)
  }
}

myf3(1,10) 
myf3(10,1) 

# if 연습문제 5. 사용자가 대문자 'Y'나 소문자'y'를 입력하면 
# 화면에'Yes'를 출력하고 그 외 다른 글자를 입력하면'Not Yes'를 
# 출력하는 함수 생성
myf5 <- function(x) {
  if (x == 'Y' | x == 'y') {  # x %in% c('Y','y')
    return('Yes')
  } else {
    return('Not Yes')
  }
}

myf5('iY')

# [ 연습 문제 - 함수에 벡터가 대입되는 경우 ]
# emp.csv파일을 읽고 
# 1. sal과 comm의 합을 구하는 함수 생성 및 적용
# f_salcomm(emp$SAL,emp$COMM) 형태, 
# COMM이 NA인 경우 0으로 치환
emp <- read.csv('emp.csv', stringsAsFactors = F)

f1 <- function(x,y) {
  return(x + ifelse(is.na(y),0,y))
}

f1(4,5)
f1(emp$SAL,emp$COMM)

# 2. 부서번호에 따른 부서명 출력 함수 생성 및 적용
# 10번이면 인사부, 20은 재무부, 30은 총무부
# 2-1) for + if
vname <- c()

for (i in emp$DEPTNO) {
  if (i == 10) {
    vname <- c(vname, '인사부')
  } else if (i == 20) {
    vname <- c(vname, '재무부')
  } else {
    vname <- c(vname, '총무부')
  }
}

vname

# 2-1) 사용자 정의 함수
f2 <- function(x) {
  if (x == 10) {
    return('인사부')
  } else if (x == 20) {
    return('재무부')
  } else {
    return('총무부')
  }
}

f2(10)
f2(emp$DEPTNO)          # 벡터연산 불가

# sol1) 적용함수
sapply(emp$DEPTNO, f2)  # 벡터연산 가능

# sol2) 사용자정의함수에 반복문 사용
f2 <- function(x) {
  vname <- c()
  for (i in x) {
    if (i == 10) {
      vname <- c(vname, '인사부')
    } else if (i == 20) {
      vname <- c(vname, '재무부')
    } else {
      vname <- c(vname, '총무부')
    }
  }
  return(vname)
}

f2(emp$DEPTNO)   # for문에 의해 벡터연산 가능

# [ 연습 문제 ]
f_nvl(NA,0)
f_nvl(emp$COMM,0)

f_nvl <- function(x, replacement=0) {
  if (is.na(x)) {
    return(replacement)
  } else {
    return(x)
  } 
}

f_nvl(NA,100)
f_nvl(emp$COMM,0)
sapply(emp$COMM, f_nvl, 0)

# self call(재귀함수)
# - 함수 내부에서 본인함수를 또 호출하는 형식
# - 함수의 호출의 반복으로 반복문 없이 반복작업 수행 가능
# - stop point 필요

# 예제) fsum(100) = 1+2+3+...+100 함수를 재귀함수로 생성
fsum <- function(x) {
  vsum <- 0
  for (i in 1:x) {
    vsum <- vsum + i
  }
  return(vsum)
}
fsum(100)


i
1  1      = fsum(1)
2  1+2    = fsum(2) = fsum(1) + 2
3  1+2+3  = fsum(3) = fsum(2) + 3       
...
x  1+2+.. = fsum(x) = fsum(x-1) + x

fsum <- function(x) {
  fsum(x-1) + x
}

fsum(10)
# fsum(10) = fsum(9) + 10
#          = fsum(8) + 9 + 10
#          = fsum(7) + 8 + 9 + 10
#             ....
#          = fsum(2) + 3 + ... + 8 + 9 + 10
#          = fsum(1) + 2 + ... + 10   # stop point 발생
#          = fsum(0) + 1 + ... + 10

fsum <- function(x) {
  if (x == 1) {
    return(1)
  } else {
    return(fsum(x-1) + x)
  }
}

fsum(10)

# [ 연습문제 - 다음의 피보나치 수열을 출력하는 함수 생성 ]
# f(1) = 1
# f(2) = 1
# f(3) = 1+1 = 2
# f(4) = 1 + 2
# ...
# f(x) = f(x-2) + f(x-1), (f(1)=1, f(2)=1 충족)
# 1 1 2 3 5 8 13

f_fibo <- function(x) {
  if (x==1 | x==2) {
    return(1)
  } else {
    return(f_fibo(x-2) + f_fibo(x-1))
  }
}

f_fibo(1)

# 가변형인자
f1 <- function(...) {
  v_key <- list(...)
  for (i in v_key) {
    ....
  }
}

f1(1,2,3)

# [ 연습 문제 ] 
fsum3(1,10,100, .... ) = 111

fsum3 <- function(...) {
  v_key <- c(...)
  for (i in v_key) {
    print(i)
  }
}

fsum3 <- function(...) {
  v_key <- list(...)
  vsum  <- 0
  for (i in v_key) {
    vsum <- vsum + i
  }
  return(vsum)
}

fsum3(1,2,3,10,100)

# 지역변수와 전역변수
# - 지역변수 : 특정 함수, 프로그램 내에서 유효한 변수
# - 전역변수 : 특정 함수, 프로그램 밖에서도 유효한 변수

v1 <- 1   # 전역변수 (해당 세션에서)

f1 <- function(x) {
  return(v1)
}

f1()  #1

# ----
v1 <- 10     # 전역변수 (해당 세션에서)

f2 <- function(x) {
  v1 <- 5    # 지역변수(지역변수가 우선순위)
  return(v1)
}

f2()  #5
v1

# ----
f3 <- function(x) {
  vv1 <- 1
  return(vv1)
}

f4 <- function(x) {
  return(vv1)
}

f3()  # 1
f4()  # vv1 not found error

# ----
f3 <- function(x) {
  vv1 <<- 1          # 전역변수화 
  return(vv1)
}

f4 <- function(x) {
  return(vv1)
}

f3()  # 1
f4()  # 1
vv1   # 1

f_test <- function(x) {
  vsum5 <- sum(1:x)
  return(vsum5)
}

vsum5
f_test(100)


# 데이터 분석
# - 지도학습 : Y(target) 존재
#  1) 회귀기반 분석 : Y가 연속형
#  2) 분류기반 분석 : Y가 범주형
# 
# ex) 게임이탈 분석
# 설명변수(X) : 고객아이디, 성별, 나이, 게임시간, kill수, .... , 
# 종속변수(Y) : 탈퇴여부
# 
# - 비지도학습 : Y(target) 존재
# 
# ex) 고객 특징화, 세분류
# 고객아이디, 성별, 나이, 게임시간, kill수, .... ,



# 파일 입출력 함수
# 1. read.csv
# - header = FALSE : 첫번째 행을 컬럼화 할지 여부
# - sep = "" : 파일의 분리 구분 기호
read.csv('read_test1.txt', skip = 1, sep=':',
         header = T) # 기본값

read.table('read_test1.txt', skip = 1, sep=':', 
           header = F) # 기본값

# - na.strings = "NA" : NA 처리할 문자열
# - nrows = -1 : 불러올 행의 개수
# - skip = 0 : 스킵할 행의 개수
read.csv('read_test1.txt', skip = 1)

# - stringsAsFactors = T : 문자형 컬럼의 factor 선언 여부
# - encoding = "unknown" : 파일 인코딩 

read.csv('read_test1.txt')






