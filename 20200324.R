# [ 참고 - 엑셀파일 형태의 데이터 입출력 ]
install.packages('xlsx')
library(xlsx)

# 1. read.xlsx(파일명, 시트번호)
read.csv('emp_1.xlsx')    # 에러 발생
read.xlsx('emp_1.xlsx',1) # 정상 로딩 

# 2. write.xlsx(데이터프레임명, 저장할파일명)



# reshape2
# 1. melt : stack 처리
# 2. dcast : unstack 처리**

help("dcast")

dcast(data,                 # 데이터프레임          
      formula,              # 행고정 ~ 컬럼 고정 
      fun.aggregate = NULL, # 요약함수
      ...
      value.var = )         # value 컬럼

d1 <- read.csv('dcast_ex1.csv')
d2 <- read.csv('dcast_ex2.csv')
d3 <- read.csv('dcast_ex3.csv')

# case1) 교차테이블 생성
dcast(d1, year + name ~ info, value.var = 'value')

# case2) value 컬럼이 여러개인 경우
dcast(d2, year ~ name ) # value.var 생략시 맨 마지막 숫자컬럼
dcast(d2, year ~ name, value.var = 'qty')

# case3) 교차테이블 생성시 쉘에 들어갈 값이 여러개인 경우
# 예제) dcast_ex3.csv 파일을 읽고 년도별 이름별 교차테이블
dcast(d3, 년도 ~ 이름)      # fun.aggregate 생략시 count 계산
dcast(d3, 년도 ~ 이름, sum) # 요약 필요시 fun.aggregate 전달

# [ 참고 - 행별, 컬럼별 요약기능 ]
dcast(d3, 년도 ~ 이름, sum, margins=T)
dcast(d3, 년도 ~ 이름, mean, margins=T)

# [ 연습 문제 ]
# 상반기사원별월별실적현황_new.csv 파일을 
# 다음과 같은 교차테이블로 표현
#       1     2     3     4     5     6
#박동주 1     0.85 0.75  0.98  0.92  0.97
#최경우 0.90 0.92  0.68  0.87  0.89  0.89

df_new <- read.csv('상반기사원별월별실적현황_new.csv', 
                   stringsAsFactors=F)
df_new2 <- dcast(df_new, 이름 ~ 월)

# [ 예제 - 위 데이터에서 사원별 성취도 평균 ]
apply(df_new2[,-1],1,mean)
rowSums(df_new2[,-1])
rowMeans(df_new2[,-1])
colSums(df_new2[,-1])
colMeans(df_new2[,-1])

# [ 연습 문제 ]
# subway2.csv 파일을 읽고 역별, 시간대별 승하차의 총 합을 출력

sub <- read.csv('subway2.csv', skip = 1, 
                stringsAsFactors = F,
                na.strings = '')

# [ 참고 - 파이썬 fillna 대체 함수 in R ]
install.packages('zoo')
library(zoo)
zoo::na.locf(벡터)

na.locf(sub$전체)

# step1) 역이름 이전값 가져오기
sub$전체 <- na.locf(sub$전체)

# step2) 천단위 구분기호 제거 및 숫자 변경
f2 <- function(x) {
  as.numeric(str_remove_all(x,','))
}

sub[, -c(1,2)] <- apply(sub[, -c(1,2)], c(1,2), f2)


# step3) 시간대 정보 컬럼 stack 처리
ddply(sub, .(전체), summarise, v1=sum(X05.06), 
                               v2=sum(X06.07))  # 그룹연산 불편

sub2 <- melt(sub, id.vars = c('전체','구분'),
                  variable.name='시간', value.name='수')

sub2$시간 <- as.numeric(substr(sub2$시간,2,3))

# step4) 역별, 시간대별 승하차 총 합
ddply(sub2, .(전체,시간), summarise, CNT=sum(수))
dcast(sub2, 전체 ~ 시간, sum)


# [ dplyr 패키지 : 여러가지 함수를 사용, 구조화된 전처리 ]
install.packages('dplyr')
library(dplyr)

# 1. select : 컬럼 선택        
# 2. mudate : 컬럼 가공
# 3. filter : 행 선택
# 4. group_by : 그룹연산(그룹핑만)
# 5. arrange : 정렬
# 6. summarise_each : 그룹연산의 실제 연산조건

emp <- read.csv('emp.csv', stringsAsFactors = F)


# 예제1) emp 테이블에서 이름, 연봉, 부서번호만 출력
emp %>%
  select(ENAME, SAL, DEPTNO)

# 예제2) emp 테이블에서 10번 부서 직원정보 출력
emp %>%
  select(ENAME, SAL, DEPTNO) %>%
  filter(DEPTNO==10)


# 예제2) emp 테이블에서 comm이 NA가 아닌
emp %>%
  select(ENAME, SAL, DEPTNO) %>%
  filter(!is.na(COMM)) # select 연산 결과에 COMM이 포함되지
                       # 않았기 때문에 연산 오류

emp %>%
  select(ENAME, SAL, DEPTNO, COMM) %>%  # select에 포함
  filter(!is.na(COMM))

emp %>%
  filter(!is.na(COMM)) %>%   # filter를 먼저 수행하도록 
  select(ENAME, SAL, DEPTNO)
  

# 예제3) emp 테이블에서 10번 직원의 10% 인상된 정보 출력
emp %>%
  select(ENAME, SAL, DEPTNO) %>%
  filter(DEPTNO==10) %>%
  mutate(v1=SAL*1.1)

# [ 연습 문제 ]
# student.csv 파일을 읽고
std <- read.csv('student.csv', stringsAsFactors = F)

# 1. 각 학생의 이름, 학년, 교수번호 출력
std %>%
  select(NAME, GRADE, PROFNO)

# 2. 위 정보에 교수번호가 없는 학생은 생략
std %>%
  select(NAME, GRADE, PROFNO) %>%
  filter(!is.na(PROFNO))

# 3. 위 정보에 각 학생의 성별 컬럼 추가하여 출력
std %>%
  select(NAME, GRADE, PROFNO, JUMIN) %>%
  filter(!is.na(PROFNO)) %>%
  mutate(V1=ifelse(substr(JUMIN,7,7)=='1','남','여'))


# 예제4) 위 데이터에서 학년별 정렬 
std %>%
  select(NAME, GRADE, PROFNO, JUMIN) %>%
  filter(!is.na(PROFNO)) %>%
  mutate(V1=ifelse(substr(JUMIN,7,7)=='1','남','여')) %>%
  arrange(desc(GRADE), V1)

# 예제5) 학년별 키 평균
std %>%
  select(NAME, GRADE, HEIGHT) %>%
  group_by(GRADE) %>%
  summarise_each(mean, HEIGHT)
  
# [ 연습 문제 ]
# 1. crime.csv 파일을 읽고, 
# 1) 구별 년도별 발생 현황 출력(교차테이블)
# 2) 구별 년도별 검거율의 현황 출력(교차테이블)

# 2. kimchi_test.csv 파일을 읽고
# 1) 1월 총각김치의 대형마트 판매량과 판매금액 출력(dplyr)
# 2) 년도별 월별 전체 판매량의 총 합 출력(dplyr)






