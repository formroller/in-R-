# 문자열 처리와 관련 함수 : stringr 패키지 사용
install.packages('stringr')
library(stringr)

# 1. str_detect(대상, 패턴) 
# - 문자열 패턴 확인 함수
# - 오라클 like 연산자기능
# - 정규식 표현 가능

v1 <- c('abc', 'Abcd', 'bcd')
v2 <- c('abc', 'Abcd12', 'bcd!@','aaaab')

str_detect(v1, 'a')      # 'a' 포함여부 확인(like '%a%')
str_detect(v1, '^a')     # 'a' 시작 여부 확인(like 'a%')
str_detect(v1, 'a$')     # 'a' 끝나는지 확인(like '%a')
str_detect(v1, '^[aAb]') # 'a' 또는 'A'로 시작하는지 확인
str_detect(v1, '^.b')    # 두번째 글자가 b(like '_a%')

str_detect(v1, '^[aA][bB]')
str_detect(v1, '^[aAbB]')

str_detect(v2, '[0-9]')     # 숫자를 포함하는
str_detect(v2, '\\d')       # 숫자를 포함하는
str_detect(v2, '[:digit:]') # 숫자를 포함하는

str_detect(v2, '[a-zA-Z]')  # 영문을 포함하는(대소구분X)
str_detect(v2, '[:alpha:]') # 문자를 포함하는
str_detect(v2, '[:punct:]') # 특수문자를 포함하는

str_detect(v2, 'a{4,5}')    # a가 4회이상 5회이하 반복되는


# [ 연습문제 ]
# student.csv 파일을 읽고 ID에 'a'를 포함하는 학생의
# 이름, ID, 학년 출력
std[str_detect(std$ID,'a'), c('NAME','ID','GRADE')]

# [ 주의 : %in% 연산자는 문자열 패턴 확인 불가 ]
'a' %in% 'abc'
std$NAME %in% c('서재수','김문호')


# 2. str_count(대상, 패턴)
# - 문자열에 포함되어 있는 패턴의 개수
# - 정규식 표현 가능

str_count(v2,'a')  # 'a'가 포함된 횟수
str_count(v2,'[aA]')  # 'a' 또는 'A'가 포함된 횟수
str_count(v2,'[0-9]')  # 숫자가 포함된 횟수


# 3. str_c(..., sep = , collapse = )
# - 문자열 결합 함수
# - 오라클의 연결연산자(||) 기능
# - sep 옵션 : 결합시 구분자 전달, 벡터끼리 결합(***)
# - collapse 옵션 : 결합시 구분자 전달, 벡터내 결합

v3 <- c('a','b','c')
v4 <- c('A','B','C')

str_c('a','b','c',sep = ';')   # "a;b;c"
str_c(v3, sep = ';')           # "a" "b" "c", 결합불가
str_c(v3, collapse = ';')      # "a;b;c"
str_c('a','b','c')             # "abc", sep='' 기본
str_c(v3,v4)                   # "aA" "bB" "cC"
str_c(v3,'is...')              # v3||'is...'

# [ 연습 문제 ]
# emp.csv파일을 읽고 아래와 같은 형식으로 출력
# 'SMITH의 10% 인상된 연봉은 880이다.'
str_c(emp$ENAME, 
      '의 10% 인상된 연봉은 ', 
      emp$SAL*1.1, 
      '이다.')

# [ 연습 문제 ]
# student.csv파일을 읽고 ID에 숫자가 2회이상 반복된 
# 학생 데이터 제외(행삭제)
v5 <- c('a1b2', 'a123')
str_count(v5,'[0-9]') >= 2   # 불가, 단순포함
str_detect(v5, '[0-9]{2}')   # 가능, 연속반복
str_detect(v5, '[0-9][0-9]') # 가능

std <- std[!str_detect(std$ID, '[0-9]{2}'), ]


# 4. str_length(대상)
# - 문자열의 크기 출력
# - 오라클 length 함수와 비슷
str_length(v1)

# 5. str_locate(대상,패턴)
# - 문자열이나 패턴의 위치 출력
# - 오라클 instr 함수와 비슷
v6 <- c('a#b#c','a##b##c##') 
str_locate(v6,'#')     # 첫번째 #의 위치 출력
str_locate_all(v6,'#') # #의 모든 위치 출력
str_locate('abc','ab') # 찾는 문자열의 시작,끝 위치 다른경우

# 6. stringr::str_sub(대상, 시작위치, 끝위치)
# = substr
# - 위치기반 문자열 추출 함수
# - 오라클 substr이랑 비슷하나 세번째 인자 의미 주의
str_sub(v6,2,3)  # 각 원소별 2부터 3 위치까지 문자열추출
substr(v6,2,3)   

# [ 연습 문제 ]
# '031-356-1234'에서 지역번호 추출, 단 위치 기반으로
v_end <- str_locate('031-356-1234','-')[1,1] - 1
substr('031-356-1234',1, v_end)


# 7. stringr::str_replace(대상,찾을문자열,바꿀문자열)
# - = replace
# - 문자열 치환 함수
# - oracle replace 함수와 비슷

str_replace('abc','a','A')
str_replace('abca','ab','AB')  # translate 기능 없음
str_replace('abca','ab','')    # 삭제 기능

str_replace_all('abca','a','') # 발견된 패턴 모두 삭제/치환

# ** 주의사항
v7 <- c('ab',NA,'bc')
str_replace(v7,NA,0)       # NA를 치환불가
str_replace(v7,'ab',NA)    # NA로 치환불가
str_replace('ab','a',0)    # 문자이외값으로 치환불가

str_remove_all('ab','a')   # 삭제 함수로 대체 가능

# [ 연습 문제 ]
# 다음의 변수의 10%인상된 값 출력
# v_sal <- c('1,200','5,000','3,300')
v_sal <- c('1,200','5,000','3,300')

v_sal <- as.numeric(str_replace_all(v_sal,',',''))
v_sal * 1.1

# 8. str_split(대상, 패턴)
# - 분리함수
# - 출력결과가 리스트

str_split('a#b#c','#')[[1]][2]

# [ 연습 문제 ]
# professor.csv 파일을 읽고
pro <- read.csv('professor.csv', stringsAsFactors = F)

# 1) 교수번호가 40으로 시작하는 교수의 이름, 교수번호, 
# pay 출력
pro[str_detect(pro$PROFNO, '^40'), c('NAME','PROFNO','PAY')]

# 2) email_id라는 각 교수의 이메일 아이디를 담는 컬럼 생성
# 2-1) 위치기반 : substr + str_locate
# 1) '@' 위치확인
v_lo <- str_locate(pro$EMAIL,'@')[,1]

# 2) 추출
pro$email_id <- substr(pro$EMAIL, 1, v_lo - 1)

# 2-2) 분리기반 : str_split
str_split('captain@abc.net','@')[[1]][1]

str_split(pro$EMAIL,'@')[[1]][1]
str_split(pro$EMAIL,'@')[[2]][1]
...

for (i in 1:nrow(pro)) {
  pro$email_id2[i] <- str_split(pro$EMAIL,'@')[[i]][1]
}

v_id <- c()
for (i in 1:nrow(pro)) {
  v_id <- c(v_id, str_split(pro$EMAIL,'@')[[i]][1])
}


# 반복 제어문 : 반복문의 흐름을 제어하는 구문
# 1. next : 반복문내 next 뒤에 실행되는 문장스킵

for (i in 1:10) {
  cmd1          # 10번 실행
  cmd2          # 10번 실행
  if (i==5) {
    next
  }
  cmd3          # skip 대상, 9번 실행
}
cmd4            # 1번 실행

# 2. break : 반복문 즉시 종료
for (i in 1:10) {
  cmd1          # 5
  cmd2          # 5
  if (i==5) {
    break
  }
  cmd3          # 4
}
cmd4            # 1

# 3. exit : 프로그램 즉시 종료
for (i in 1:10) {
  cmd1          # 5
  cmd2          # 5
  if (i==5) {
    exit(0)
  }
  cmd3          # 4
}
cmd4            # 0

# [ 연습 문제 ] 
# 1부터 10까지 중 짝수만 출력
for (i in 1:10) {
  if (i %% 2 != 0) {
    next
  }
  print(i)
}



















