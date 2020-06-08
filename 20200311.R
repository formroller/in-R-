for (i in 1:10) {
  print(i)
}

for (i in 1:10) {
  if (i==5) {
    next 
  }
  print(i)
}

for (i in 1:10) {
  if (i%%2!=0) {
    next 
  }
  print(i)
}

# [ 연습 문제 ]
# 1부터 100까지 구하되, 짝수만 더하면?
# sol1) for
vsum <- 0

for (i in 1:100) {
  if (i%%2 != 0) {
    next
  }
  vsum <- vsum + i
}

vsum

# sol2) while
i <- 1
vsum <- 0

while (i <= 100) {
  if (i%%2 !=0) {
    next
  }
  vsum <- vsum + i
  i <- i + 1         # i=1일때 스킵되면서 증가되지 않음
}

vsum

# --------
i <- 0
vsum <- 0

while (i <= 100) {
  i <- i + 1         
  if (i%%2 !=0) {
    next
  }
  vsum <- vsum + i
}

vsum


# [ 연습 문제 ]
# 아래 벡터를 출력하되, NA이전까지만 출력
v1 <- c(1,2,3,NA,4,5,6)

for (i in v1) {
  if (is.na(i)) {
    break
  }
  print(i)
}


# 산술연산
sum(..., na.rm = F)
mean(x, ...)

sum(1,2,3)     # 1,2,3의 합 수행
mean(1,2,3)    # 1의 평균만 수행, 나머지 인자 무시
mean(c(1,2,3)) # 1,2,3의 평균 수행

v1 <- c(1,2,3,NA)
sum(v1, na.rm = T)
mean(v1, na.rm = T)           # 3개의 평균
mean(ifelse(is.na(v1),0,v1))  # 4개의 평균

# [ 참고 : NA 치환 함수 ]
str_replace(v1,NA,0)   # NA 치환 불가
str_replace_na(v1,0)   # NA 치환 가능, 문자로 리턴

# [ 연습문제 ]
# 1) 다음의 벡터에 반복문을 사용하여 10% 인상된 가격의 
# 총 합을 구하여라
v1 <- c(1000,1500,NA,3000,4000)

sum(v1 * 1.1, na.rm = T)
sum(ifelse(is.na(v1), 0, v1*1.1))

vsum <- 0
for (i in v1) {
  if (is.na(i)) {
    next
  }
  vsum <- vsum + i*1.1
}

# 사용자 정의 함수 : 사용자가 직접 만드는 함수, 리턴대상필요
함수명 <- function(...) {
  cmd1
  cmd2
  ...
  return(객체)
}

# 예제) abs 기능을 수행하는 사용자 정의함수 생성
abs(-2)

f_abs <- function(x) {
  if (x >= 0) {
    return(x)
  } else {
    return(-1 * x)
  }
}

f_abs(10)
f_abs(-10)
f_abs(0)


# [ 연습 문제 ] 
# 두 수를 입력 받아 두 수의 합을 출력하는 함수생성
f_sum <- function(x,y) {
  return(x+y)
}

f_sum <- function(x,y=0) {
  return(x+y)
}

f_sum(x=10, y=11)
f_sum(10,11)
f_sum(10)

# [ 연습 문제 ]
# 다음의 함수 생성
# f_split('a#b#c','#',2) => b

f_split <- function(x,sep=' ',ord=1) {
  str_split(x,sep)[[1]][ord]
}

str_split('a#b#c','#')
f_split('a#b#c','#',3)

# 예제) 다음의 벡터에서 각각 b, B 추출되도록?
v1 <- c('a#b#c#','A#B#C#')
str_split(v1,'#')  # 단독으로 불가, 반복문 필요
f_split(v1,'#',2)  # 벡터연산 불가

sapply(v1, f_split,'#',2)


# [ 연습 문제 ]
# f_sum2(100) = 1+2+3+...+100






