# subway2.csv 파일의 데이터를 기반으로
# 승차가 가장 많은 top 5개의 역을 구하고 
# 각 역의 시간대별 승차의 증감추세를 도표화
# (참고 : data.frame의 행 형태로는 그래프 표현 불가, 컬럼 형태로 변경)

sub <- read.csv('subway2.csv', stringsAsFactors = F, skip=1)
head(sub)

sub2 <- sub[sub$구분=='승차', -2]
rownames(sub2) <- sub2$전체
sub2$전체 <- NULL

f1 <- function(x) {
  as.numeric(str_remove_all(x,','))
}

sub2[,] <-  apply(sub2, c(1,2), f1)

# 역별 승차 총 합 
apply(sub2, 1, sum)
v_sort <- sort(apply(sub2, 1, sum), decreasing = T)[1:5]

names(v_sort)  # top5 역 이름

# top5 역 추출
total <- t(sub2[rownames(sub2) %in% names(v_sort), ])
rownames(total)  <- as.numeric(substr(rownames(total), 2,3))

dev.new()
plot(total[,1]/10000, type='o', col=1, ylim = c(0,40),
     ann=F, axes = F)

lines(total[,2]/10000, type='o', col=2)
lines(total[,3]/10000, type='o', col=3)
lines(total[,4]/10000, type='o', col=4)
lines(total[,5]/10000, type='o', col=5)

title(main='역별 승차 추이', xlab='시간', ylab='승차수(만)')
axis(1, at=1:nrow(total), labels = rownames(total))
axis(2, ylim = c(0,40))

legend(18, 40, legend = colnames(total), 
       col = 1:5, lty = 1, cex = 0.8)

# 막대그래프 그리기
barplot(height = , # 2차원 데이터, matrix 형태
        ...)       # 기타 옵션

# [ 예제 - 아래 데이터 프레임 막대그래프 그리기]
library(googleVis)
df1 <- dcast(Fruits, Year ~ Fruit, value.var = 'Sales')
rownames(df1) <- df1$Year
df1$Year <- NULL

dev.new()
barplot(df1)   # 'height'는 반드시 벡터 또는 행렬이어야 합니다 에러
barplot(as.matrix(df1)) # 컬럼별 서로 다른 막대 그룹 생성
barplot(as.matrix(df1), beside = T) # 각 행별 서로 다른 막대 생성

barplot(as.matrix(df1), beside = T, col=rainbow(3), ylim = c(0,200))

legend(10,200, rownames(df1), fill = rainbow(3))

# [ 연습 문제 ]
# 상반기사원별월별실적현황_new.csv을 읽고,
# 월별 각 직원의 성취도를 비교하기 위한 막대그래프 출력
df2 <- read.csv('상반기사원별월별실적현황_new.csv',
                 stringsAsFactors=F)
total2 <- dcast(df2, 이름 ~ 월)
rownames(total2) <- total2$이름
total2$이름 <- NULL

dev.new()
barplot(as.matrix(total2), beside = T, col = rainbow(nrow(total2)),
        ylim = c(0,1.5), angle = 45, density = 30,
        legend = rownames(total2), 
        args.legend = list(cex=0.7, x='topright'))



