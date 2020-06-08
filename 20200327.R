# subway2.csv ������ �����͸� �������
# ������ ���� ���� top 5���� ���� ���ϰ� 
# �� ���� �ð��뺰 ������ �����߼��� ��ǥȭ
# (���� : data.frame�� �� ���·δ� �׷��� ǥ�� �Ұ�, �÷� ���·� ����)

sub <- read.csv('subway2.csv', stringsAsFactors = F, skip=1)
head(sub)

sub2 <- sub[sub$����=='����', -2]
rownames(sub2) <- sub2$��ü
sub2$��ü <- NULL

f1 <- function(x) {
  as.numeric(str_remove_all(x,','))
}

sub2[,] <-  apply(sub2, c(1,2), f1)

# ���� ���� �� �� 
apply(sub2, 1, sum)
v_sort <- sort(apply(sub2, 1, sum), decreasing = T)[1:5]

names(v_sort)  # top5 �� �̸�

# top5 �� ����
total <- t(sub2[rownames(sub2) %in% names(v_sort), ])
rownames(total)  <- as.numeric(substr(rownames(total), 2,3))

dev.new()
plot(total[,1]/10000, type='o', col=1, ylim = c(0,40),
     ann=F, axes = F)

lines(total[,2]/10000, type='o', col=2)
lines(total[,3]/10000, type='o', col=3)
lines(total[,4]/10000, type='o', col=4)
lines(total[,5]/10000, type='o', col=5)

title(main='���� ���� ����', xlab='�ð�', ylab='������(��)')
axis(1, at=1:nrow(total), labels = rownames(total))
axis(2, ylim = c(0,40))

legend(18, 40, legend = colnames(total), 
       col = 1:5, lty = 1, cex = 0.8)

# ����׷��� �׸���
barplot(height = , # 2���� ������, matrix ����
        ...)       # ��Ÿ �ɼ�

# [ ���� - �Ʒ� ������ ������ ����׷��� �׸���]
library(googleVis)
df1 <- dcast(Fruits, Year ~ Fruit, value.var = 'Sales')
rownames(df1) <- df1$Year
df1$Year <- NULL

dev.new()
barplot(df1)   # 'height'�� �ݵ�� ���� �Ǵ� ����̾�� �մϴ� ����
barplot(as.matrix(df1)) # �÷��� ���� �ٸ� ���� �׷� ����
barplot(as.matrix(df1), beside = T) # �� �ະ ���� �ٸ� ���� ����

barplot(as.matrix(df1), beside = T, col=rainbow(3), ylim = c(0,200))

legend(10,200, rownames(df1), fill = rainbow(3))

# [ ���� ���� ]
# ��ݱ���������������Ȳ_new.csv�� �а�,
# ���� �� ������ ���뵵�� ���ϱ� ���� ����׷��� ���
df2 <- read.csv('��ݱ���������������Ȳ_new.csv',
                 stringsAsFactors=F)
total2 <- dcast(df2, �̸� ~ ��)
rownames(total2) <- total2$�̸�
total2$�̸� <- NULL

dev.new()
barplot(as.matrix(total2), beside = T, col = rainbow(nrow(total2)),
        ylim = c(0,1.5), angle = 45, density = 30,
        legend = rownames(total2), 
        args.legend = list(cex=0.7, x='topright'))


