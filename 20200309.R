# 1. vector
# 2. list
l1 <- list(col1=c(1,2,3), col2=c('a','b'))
l1[1][2]
l1$col1[2]
l1[[1]][2]

# 3. matrix
# 4. array
# - 다차원
# - 동일 데이터 타입만 허용

# 차원의 확장
#         R       python
# 2차원 행,열      행,열
# 3차원 행,열,층   층,행,열

# 1. array 생성
# 3X4
a1 <- array(data=1:12, dim=c(3,4))

# 2X2X3
a2 <- array(data=1:12, dim=c(2,2,3))
a2

# 2. 색인
a2[1,1,3]   # 첫번째 행, 첫번째 컬럼, 세번째 층 추출
a2[,,3]
a2[,,3,drop=F]

# 3. 차원 확인
dim(a2)

# 5. data.frame

# vector -> matrix -> array
# list   -> data.frame

# if문
# - 조건문
# - 조건에 따른 치환 또는 다른 프로그래밍 가능
# - 벡터연산 불가(원소별 조건치환 반복 불가)

# [ 기본 문법 ]
# if (조건) {
#   참일때 수행 문장
# } else if (조건) {
#   참일때 수행 문장
# } else {
#   거짓일때 수행 문장
# }

# 예제) v1의 값이 10이면 'A' 아니면 'B'로 출력
v1 <- 20

if (v1==10) {
  'A'
} else {
  'B'
}


# 예제) v1의 값이 30보다 크면 'A' 20보다 크면 'B',
# 기타 'C'로 출력
if (v1 > 30) {
  'A'
} else if (v1 > 20) {
  'B'
} else {
  'C'
}


# 예제) v2의 값이 10이면 'A' 아니면 'B'로 출력
v2 <- c(10,20,30)

if (v2==10) {
  'A'
} else {
  'B'
}


# ifelse문
# - 조건문
# - 조건에 따른 치환, 리턴만 가능
# - else 리턴 생략 불가
# - 벡터연산 가능

# ifelse(조건,참일때 리턴값,거짓일때 리턴값)

# 예제) v2의 값이 10이면 'A' 아니면 'B'로 출력
ifelse(v2==10,'A','B') # 비교 : decode(v2,10,'A','B')

# 예제) v2의 값이 30보다 크면 'A' 20보다 크면 'B',
# 기타 'C'로 출력
ifelse(v2 > 30,'A',ifelse(v2 > 20,'B','C'))

# [ 연습 문제 ]
# emp.csv 파일을 읽고,
emp <- read.csv('emp.csv', stringsAsFactors = F)

# 1) dname이라는 컬럼 추가, 
# 10번 부서는 인사부, 20번은 총무부 30번은 재무부
emp$dname <- ifelse(emp$DEPTNO == 10, '인사부', 
                    ifelse(emp$DEPTNO == 20,'총무부', 
                                            '재무부'))

# 2) new_sal이라는 컬럼 추가,
# sal이 3000이상인 경우 5%인상, 미만인 경우는 10%인상
emp$new_sal <- ifelse(emp$SAL >= 3000, emp$SAL*1.05, 
                                       emp$SAL*1.1)

# for문
# - 반복문
# - 반복횟수가 정해져 있음
# 
# [ 기본 문법 ]
# 
# for (반복변수 in 대상 or 횟수) {
#   반복처리
# }

for ( i in 1:10 ) {
  print(i)
}

i <- 1 ; print(i)
i <- 2 ; print(i)
...
i <- 10 ; print(i)


for ( i in 1:10 ) {
  print(10)
}


# 예제) v2의 값이 10이면 'A' 아니면 'B'로 출력
# if + for

if (v2 == 10) {
  'A'
} else {
  'B'
}

for (i in v2) {
  if (v2 == 10) {
    'A'
  } else {
    'B'
  }
}

step1) i <- 10
step2)   
if (10 == 10) {
  'A'
} else {
  'B'
}
step3) i <- 20
step4)
if (20 == 10) {
  'A'
} else {
  'B'
}

for (i in v2) {
  if (i == 10) {
    print('A')     # for문은 리턴값이 아닌 실행문장 필요
  } else {
    print('B')
  }
}


v3 <- for (i in v2) {
  if (i == 10) {
    print('A')     # for문은 리턴값이 아닌 실행문장 필요
  } else {
    print('B')
  }
}


for (i in v2) {
  if (i == 10) {
    v_3 <- 'A'    # v_3 벡터에 리턴값 덮어씀
  } else {
    v_3 <- 'B' 
  }
}

i <- 10 ; v_3 <- 'A'
i <- 20 ; v_3 <- 'B'
i <- 30 ; v_3 <- 'B'

v4 <- c()           # 빈벡터 선언

for (i in v2) {
  if (i == 10) {
    v4 <- c(v4,'A') # 연산결과 누적을 위한 처리
  } else {
    v4 <- c(v4,'B') 
  }
}
 
i <- 10 ; v_3 <- 'A'
i <- 20 ; v_3 <- 'A', 'B'
i <- 30 ; v_3 <- 'A', 'B', 'B'


# 예제) 1~10을 갖는 벡터에서 5보다 작거나 같은 경우는
# 곱하기 1을, 6이상인 경우는 곱하기 2를 리턴
# 1) ifelse
v6 <- 1:10

ifelse(v6 <= 5, v6, v6*2)

# 2) for + if : if문에 단 하나의 원소 대입위해, 프로그래밍 
if (v6 <= 5) {
  v6
} else {
  v6 * 2
}

v_result <- c()

for (i in v6) {
  if (i <= 5) {
    v_result <- c(v_result, i)
  } else {
    v_result <- c(v_result, i * 2)
  }
}


# [ 연습 문제 - for + if ]
# emp.csv 파일을 읽고,
emp <- read.csv('emp.csv', stringsAsFactors = F)

# 1) dname이라는 컬럼 추가, 
# 10번 부서는 인사부, 20번은 총무부 30번은 재무부
v_dname <- c()

for (i in emp$DEPTNO) {
  if (i == 10) {
    v_dname <- c(v_dname, '인사부')
  } else if (i == 20) {
    v_dname <- c(v_dname, '총무부')
  } else {
    v_dname <- c(v_dname, '재무부')
  }
}

emp$dname <- v_dname

# 2) new_sal이라는 컬럼 추가,
# sal이 3000이상인 경우 5%인상, 미만인 경우는 10%인상
v_sal <- c()

for (i in emp$SAL) {
  if (i >= 3000) {
    v_sal <- append(v_sal, i * 1.05)
  } else {
    v_sal <- append(v_sal, i * 1.1)
  }
}

emp$new_sal <- v_sal



# while문
# - 조건 기반 반복문(for문은 정해진 대상/횟수 내 반복)
# - for문처럼 다음 단계로 자동으로 넘어가지 않음
# - 조건이 참인경우 무한 반복 수행
# 
# [기본 문법]
# while (조건) {
#   반복문장
# }

# 예제) 1~10까지 출력
j <- 1   # 초기값값

while (j <= 10) {
  print(j)
  j <- j + 1
}

# [연습문제]
# 1 ~ 100의 총합 출력 : 5050
step1) 1
step2) 기존합 + 2  ; 1+2
step3) 기존합 + 3  ; 1+2+3
.... 반복

i <- 1
vsum <- 0

while (i <= 100) {
  vsum <- vsum + i
  i <- i + 1
}

vsum









