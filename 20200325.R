# 그래프
figure : 그래프를 그릴 공간(창)
dev.new()  # figure 생성 방법

# 1. plot : 산점도, 선그래프, ...
plot(x축, y축, ...)

par(mfrow=c(1,2))        # figure 분리(1행 2열 형식)
plot(c(1,2,7), c(1,2,3))
plot(c(1,2,3))           # 벡터하나 전달 시 y축으로 인지, 
                         # x축은 자동으로 1,2,3...

# [ 참고 - plot에 데이터프레임 전달시 교차 산점도 출력 ]
# 교차산점도 : 분류분석시 컬럼별 영향도 초기파악에 사용
plot(iris[,-5], col = iris$Species)

# 1) type : 선모양
dev.new() 
par(mfrow=c(1,2))
plot(1:10, type = 'l')
plot(1:10, type = 'o')

# 2) col : 선 색
plot(1:10, type = 'l', col=2)
plot(1:10, type = 'o', col='red')

# 3) lty : 선의 모양
plot(1:10, type = 'l', col=2, lty=3)            # 점선 
plot(1:10, type = 'o', col='red', lty='dashed') # 대쉬선 

# 4) xlab, ylab : 축이름
plot(1:10, xlab = 'x축이름', ylab = 'y축이름')
plot(1:10, xlab = 'x축이름', ylab = 'y축이름', main='그래프이름')

# 5) xlim, ylim : 축 범위 설정
plot(1:10)
plot(1:10, ylim = c(0,20))

# 6) axis 함수 : 눈금 이름 변경
axis(숫자,     # 1이면 x축 눈금, 2이면 y축 눈금 설정 
     at=,      # 눈금을 표현하는 숫자벡터
     labels=)  # 각 눈금에 부여하는 이름


plot(c(120,150,100), type = 'o')
plot(c(120,150,100), type = 'o', ylim=c(0,150),
     axes=F)                                # 눈금 출력 생략
axis(1, at=1:3, labels = c('월','화','수')) # x축 눈금 설정
axis(2, ylim=c(0,150))                      # y축 눈금 설정

# [ 예제 ]
# 다음의 데이터프레임에서 각 과일별 판매량 증감 추이를
# 선그래프로 출력
df1 <- data.frame(apple=c(100,120,150),
                  banana=c(120,150,140),
                  mango=c(90,80,100))
rownames(df1) <- 2007:2009
dev.new()

plot(df1$apple, type = 'o', ylim = c(0,200), col=1, 
     axes = F,
     ann = F)   # 제목 출력 생략 

lines(df1$banana, type = 'o', col=2)
lines(df1$mango, type = 'o', col=3)

axis(1, at=1:3, labels = rownames(df1))
axis(2, ylim = c(0,200))

title(main='과일별 판매량 증감추이', col.main = 'blue',
      xlab='년도', cex.lab = 2,
      ylab='판매량', font.lab=4)

# 범례 표시
legend(x축위치,    # 범례 x 시작위치
       y축위치,    # 범례 y 끝 위치
       legend = ,  # 범례 표현 값
       col=,       # 각 범례 표현 색
       lty=,       # 범례 선스타일
       fill=)      # 범례 채울 스타일

legend(1,100, colnames(df1), col=1:3, lty=1)









