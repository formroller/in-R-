# �׷���
figure : �׷����� �׸� ����(â)
dev.new()  # figure ���� ���

# 1. plot : ������, ���׷���, ...
plot(x��, y��, ...)

par(mfrow=c(1,2))        # figure �и�(1�� 2�� ����)
plot(c(1,2,7), c(1,2,3))
plot(c(1,2,3))           # �����ϳ� ���� �� y������ ����, 
                         # x���� �ڵ����� 1,2,3...

# [ ���� - plot�� ������������ ���޽� ���� ������ ��� ]
# ���������� : �з��м��� �÷��� ���⵵ �ʱ��ľǿ� ���
plot(iris[,-5], col = iris$Species)

# 1) type : �����
dev.new() 
par(mfrow=c(1,2))
plot(1:10, type = 'l')
plot(1:10, type = 'o')

# 2) col : �� ��
plot(1:10, type = 'l', col=2)
plot(1:10, type = 'o', col='red')

# 3) lty : ���� ���
plot(1:10, type = 'l', col=2, lty=3)            # ���� 
plot(1:10, type = 'o', col='red', lty='dashed') # �뽬�� 

# 4) xlab, ylab : ���̸�
plot(1:10, xlab = 'x���̸�', ylab = 'y���̸�')
plot(1:10, xlab = 'x���̸�', ylab = 'y���̸�', main='�׷����̸�')

# 5) xlim, ylim : �� ���� ����
plot(1:10)
plot(1:10, ylim = c(0,20))

# 6) axis �Լ� : ���� �̸� ����
axis(����,     # 1�̸� x�� ����, 2�̸� y�� ���� ���� 
     at=,      # ������ ǥ���ϴ� ���ں���
     labels=)  # �� ���ݿ� �ο��ϴ� �̸�


plot(c(120,150,100), type = 'o')
plot(c(120,150,100), type = 'o', ylim=c(0,150),
     axes=F)                                # ���� ��� ����
axis(1, at=1:3, labels = c('��','ȭ','��')) # x�� ���� ����
axis(2, ylim=c(0,150))                      # y�� ���� ����

# [ ���� ]
# ������ �����������ӿ��� �� ���Ϻ� �Ǹŷ� ���� ���̸�
# ���׷����� ���
df1 <- data.frame(apple=c(100,120,150),
                  banana=c(120,150,140),
                  mango=c(90,80,100))
rownames(df1) <- 2007:2009
dev.new()

plot(df1$apple, type = 'o', ylim = c(0,200), col=1, 
     axes = F,
     ann = F)   # ���� ��� ���� 

lines(df1$banana, type = 'o', col=2)
lines(df1$mango, type = 'o', col=3)

axis(1, at=1:3, labels = rownames(df1))
axis(2, ylim = c(0,200))

title(main='���Ϻ� �Ǹŷ� ��������', col.main = 'blue',
      xlab='�⵵', cex.lab = 2,
      ylab='�Ǹŷ�', font.lab=4)

# ���� ǥ��
legend(x����ġ,    # ���� x ������ġ
       y����ġ,    # ���� y �� ��ġ
       legend = ,  # ���� ǥ�� ��
       col=,       # �� ���� ǥ�� ��
       lty=,       # ���� ����Ÿ��
       fill=)      # ���� ä�� ��Ÿ��

legend(1,100, colnames(df1), col=1:3, lty=1)








