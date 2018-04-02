#函数help.start()会打开一个浏览器窗口，我们可在其中查看入门和高级的帮助手册、常见问题集，以及参考材料。
#由函数vignette()函数返回的vignette文档一般是PDF格式的实用介绍性文章。不过，并非所有的包都提供了vignette文档。

#创建数组
dim1 <- c("A1", "A2")
dim2 <- c("B1", "B2", "B3")
dim3 <- c("C1", "C2", "C3", "C4")
z <- array(1:24, c(2, 3, 4), dimnames=list(dim1, dim2, dim3))

#with（）用法
#如果你需要创建在with()结构以外存在的对象，使用特殊赋值符<<-替代标准赋值符（<-）即可，它可将对象保存到with()之外的全局环境中。这一点可通过以下代码阐明：
with(mtcars, {
  nokeepstats <- summary(mpg)
  keepstats <<- summary(mpg)
})
nokeepstats
keepstats

#因子
status <- c("Poor", "Improved", "Excellent", "Poor")
status <- factor(status, order=TRUE,levels=c("Poor", "Improved", "Excellent"))
#有序因子ordered=T,其中levels后的向量顺序便是从小到大的因子顺序



通过执行如plot()、hist()（绘制直方图）或boxplot()这样的高级绘图命令来创建一幅
新图形时，通常会覆盖掉先前的图形。如何才能创建多个图形并随时查看每一个呢？方法有若干。
第一种方法，你可以在创建一幅新图形之前打开一个新的图形窗口：
attach(mtcars)
plot(wt, mpg)
abline(lm(mpg~wt))
title("Regression of MPG on Weight")
detach(mtcars)
每一幅新图形将出现在最近一次打开的窗口中。

第二种方法，你可以通过图形用户界面来查看多个图形。在Mac上，你可以使用Quartz菜单
中的“后退”（Back）和“前进”（Forward）来逐个浏览图形。在Windows上，这个过程分为两
步。在打开第一个图形窗口以后，勾选“历史”（History）→“记录”（Recording）。然后使用菜
单中的“上一个”（Previous）和“下一个”（Next）来逐个查看已经绘制的图形。

第三种也是最后一种方法，你可以使用函数dev.new()、dev.next()、dev.prev()、
dev.set(which=)和dev.off()同时打开多个图形窗口，并选择将哪个输出发送到哪个窗口中。这种方法全平台适用。关于这种方法的更多细节，请参考help(dev.cur)。



#不加参数地执行par()将生成一个含有当前图形参数设置的列表。添加参数no.readonly=TRUE可以生成一个可以修改的当前图形参数列表。
opar <- par(no.readonly=TRUE)
par(lty=2, pch=17)
plot(mtcars$mpg, mtcars$wt, type="b")
par(opar)

col                默认的绘图颜色。某些函数（如lines和pie）可以接受一个含有颜色值的向量并自动循环使用。例如，如果设定col=c("red", "blue")并需要绘制三条线，则第一条线将为红色，第二条线为蓝色，第三条线又将为红色
col.axis           坐标轴刻度文字的颜色
col.lab            坐标轴标签（名称）的颜色
col.main           标题颜色
col.sub            副标题颜色
fg                 图形的前景色
bg                 图形的背景色
cex                表示相对于默认大小缩放倍数的数值。默认大小为1，1.5表示放大为默认值的1.5倍，0.5表示缩小为默认值的50%，等等
cex.axis           坐标轴刻度文字的缩放倍数。类似于cex
cex.lab            坐标轴标签（名称）的缩放倍数。类似于cex
cex.main           标题的缩放倍数。类似于cex
cex.sub            副标题的缩放倍数。类似于cex
font               整数。用于指定绘图使用的字体样式。1=常规，2=粗体，3=斜体，4=粗斜体，5=符号字体（以Adobe符号编码表示）
font.axis          坐标轴刻度文字的字体样式
font.lab           坐标轴标签（名称）的字体样式
font.main          标题的字体样式
font.sub           副标题的字体样式
ps                 字体磅值（1磅约为1/72英寸）。文本的最终大小为 ps*cex
family             绘制文本时使用的字体族。标准的取值为serif（衬线）、sans（无衬线）和mono（等宽）


图形尺寸与边界尺寸
pin                以英寸表示的图形尺寸（宽和高）
mai                以数值向量表示的边界大小，顺序为“下、左、上、右”，单位为英寸
mar                以数值向量表示的边界大小，顺序为“下、左、上、右”，单位为英分*。默认值为c(5, 4, 4, 2) + 0.1



添加文本、自定义坐标轴和图例
dose <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)
plot(dose, drugA, type="b",
     col="red", lty=2, pch=2, lwd=2,
     main="Clinical Trials for Drug A",
     sub="This is hypothetical data",
     xlab="Dosage", ylab="Drug Response",
     xlim=c(0, 60), ylim=c(0, 70))
#标题
title(main="My Title", col.main="red",
      sub="My Sub-title", col.sub="blue",
      xlab="My X label", ylab="My Y label",
      col.lab="green", cex.lab=0.75)
#坐标轴
axis(side, at=, labels=, pos=, lty=, col=, las=, tck=, ...)
side   一个整数，表示在图形的哪边绘制坐标轴（1=下，2=左，3=上，4=右）
at     一个数值型向量，表示需要绘制刻度线的位置
labels 一个字符型向量，表示置于刻度线旁边的文字标签（如果为NULL，则将直接使用at中的值）
pos    坐标轴线绘制位置的坐标（即与另一条坐标轴相交位置的值）
lty    线条类型
col    线条和刻度线颜色
las    标签是否平行于（=0）或垂直于（=2）坐标轴
tck    刻度线的长度，以相对于绘图区域大小的分数表示（负值表示在图形外侧，正值表示在图形内侧，0表示禁用刻度，1表示绘制网格线）；默认值为???0.01

x <- c(1:10)
y <- x
z <- 10/x
opar <- par(no.readonly=TRUE)
par(mar=c(5, 4, 4, 8) + 0.1)
plot(x, y, type="b",
     pch=21, col="red",
     yaxt="n", lty=3, ann=FALSE)
lines(x, z, type="b", pch=22, col="blue", lty=2)
axis(2, at=x, labels=x, col.axis="red", las=2)
axis(4, at=z, labels=round(z, digits=2),
     col.axis="blue", las=2, cex.axis=0.7, tck=-.01)
mtext("y=1/x", side=4, line=3, cex.lab=1, las=2, col="blue")
title("An Example of Creative Axes",xlab="X values",ylab="Y=X")
par(opar)

次要刻度线
注意，我们最近创建的图形都只拥有主刻度线，却没有次要刻度线。要创建次要刻度线，你
需要使用Hmisc包中的minor.tick()函数。
library(Hmisc)
minor.tick(nx=n, ny=n, tick.ratio=n)

在X轴的每两条主刻度线之间添加1条次要刻度线，并在Y轴的每两条主刻度线之间添加2条次要刻度线
minor.tick(nx=2, ny=3, tick.ratio=0.5)

图例
legend(location, title, legend, ...)
location        有许多方式可以指定图例的位置。你可以直接给定图例左上角的x、y坐标，也可以执行locator(1)，然后通过鼠标单击给出图例的位置，还可以使用关键字bottom、bottomleft、left、topleft、top、topright、right、bottomright或center放置图例。如果你使用了以上某个关键字，那么可以同时使用参数inset=指定图例向图形内侧移动的大小（以绘图区域大小的分数表示）
title           图例标题的字符串（可选）
legend          图例标签组成的字符型向量

#综合画图
dose <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)
opar <- par(no.readonly=TRUE)
par(lwd=2, cex=1.5, font.lab=2)
plot(dose, drugA, type="b",pch=15, lty=1, col="red", ylim=c(0, 60),
     main="Drug A vs. Drug B",xlab="Drug Dosage", ylab="Drug Response")
lines(dose, drugB, type="b",pch=17, lty=2, col="blue")
abline(h=c(30), lwd=1.5, lty=2, col="gray")
library(Hmisc)
minor.tick(nx=3, ny=3, tick.ratio=0.5)
legend("topleft", inset=.05, title="Drug Type", c("A","B"),
       lty=c(1, 2), pch=c(15, 17), col=c("red", "blue"))
par(opar)


#文本
我们可以通过函数text()和mtext()将文本添加到图形上。text()可向绘图区域内部添加
文本，而mtext()则向图形的四个边界之一添加文本。
text(location, "text to place", pos, ...)
mtext("text to place", side, line=n, ...)
location          文本的位置参数。可为一对x,y坐标，也可通过指定location为locator(1)使用鼠标交互式地确定摆放位置
pos               文本相对于位置参数的方位。1=下，2=左，3=上，4=右。如果指定了pos，就可以同时指定参数offset=作为偏移量，以相对于单个字符宽度的比例表示
side              指定用来放置文本的边。1=下，2=左，3=上，4=右。你可以指定参数line=来内移或外移文本，随着值的增加，文本将外移。也可使用adj=0将文本向左下对齐，或使用adj=1右上对齐
attach(mtcars)
plot(wt, mpg,
     main="Mileage vs. Car Weight",
     xlab="Weight", ylab="Mileage",
     pch=18, col="blue")
text(wt, mpg,
     row.names(mtcars),
     cex=0.6, pos=4, col="red")
detach(mtcars)


mydates <- as.Date(c("2007-06-22", "2004-02-13"))
strDates <- c("01/05/1965", "08/16/1975")
dates <- as.Date(strDates, "%m/%d/%Y")
myformat <- "%m/%d/%y"
date <- as.Date(mydates, myformat)
Sys.Date()
date()
today <- Sys.Date()
format(today, format="%B %d %Y")
format(today, format="%A")

startdate <- as.Date("2004-02-13")
enddate <- as.Date("2011-01-22")
days <- enddate - startdate
days

today <- Sys.Date()
dob <- as.Date("1956-10-12")
difftime(today, dob, units="weeks")


添加列
要横向合并两个数据框（数据集），请使用merge()函数。在多数情况下，两个数据框是通
过一个或多个共有变量进行联结的（即一种内联结，inner join）


概率函数
d = 密度函数（density）
p = 分布函数（distribution function）
q = 分位数函数（quantile function）
r = 生成随机数（随机偏差）

Beta分布 beta 
Logistic分布 logis
二项分布 binom 
多项分布 multinom
柯西分布 cauchy 
负二项分布 nbinom
（非中心）卡方分布 chisq 
正态分布 norm
指数分布 exp 
泊松分布 pois
F分布 f 
Wilcoxon符号秩分布 signrank
Gamma分布 gamma 
t分布 t
几何分布 geom 
均匀分布 unif
超几何分布 hyper 
Weibull分布 weibull
对数正态分布 lnorm 
Wilcoxon秩和分布 wilcox

###生成服从多元正态分布的数据
library(MASS)
options(digits=3)
set.seed(1234) 
mean <- c(230.7, 146.7, 3.6)
sigma<-matrix(c(15360.8,6721.2,-47.1,6721.2,4700.9,-16.5,-47.1,-16.5,0.3),nrow=3,ncol=3)
mydata <- mvrnorm(500, mean, sigma)
mydata <- as.data.frame(mydata)
names(mydata) <- c("y","x1","x2")
dim(mydata)
head(mydata, n=10)


字符处理函数
nchar(x) 计算x中的字符数量
x <- c("ab", "cde","fghij")
length(x)#返回值为 3
nchar(x[3])#返回值为5

substr(x, start, stop) 提取或替换一个字符向量中的子串
x<-"abcdef"
substr(x, 2, 4)   #返回值为"bcd"
substr(x, 2, 4)<-"22222"  #(x将变成"a222ef")

grep(pattern, x, ignore. case=FALSE,fixed=FALSE)
#在x中搜索某种模式。若fixed=FALSE，则pattern为一个正则表达式。若fixed=TRUE，则pattern为一个文本字符串。返回值为匹配的下标
grep("A",c("b","A","c"),fixed=TRUE)   #返回值为2

sub(pattern, replacement, x,ignore.case=FALSE, fixed=FALSE)
#在x中搜索pattern，并以文本replacement将其替换。若fixed=FALSE，则pattern为一个正则表达式。若fixed=TRUE，则pattern为一个文本字符串
sub("\\s",".","Hello There")返回值为Hello.There。
#注意，"\s"是一个用来查找空白的正则表达式；使用"\\s"而不用"\"的原因是，后者是R中的转义字符

strsplit(x, split, fixed=FALSE) 在split处分割字符向量x中的元素。若fixed=FALSE，则
pattern为一个正则表达式。若fixed=TRUE，则pattern为一个文本字符串
y <- strsplit("abc", "") 
#将返回一个含有1个成分、3个元素的列表，包含的内容为"a" "b" "c"
#unlist(y)[2]和sapply(y, "[", 2)均会返回"b"

paste(…, sep="") 连接字符串，分隔符为sep
paste("x", 1:3,sep="")#返回值为c("x1", "x2", "x3")
paste("x",1:3,sep="M")#返回值为c("xM1","xM2" "xM3")
paste("Today is", date())#返回值为Today is Thu Jun25 14:17:32 2011（我修改了日期以让它看起来更接近当前的时间）

toupper(x) 大写转换
toupper("abc")返回值为"ABC"

tolower(x) 小写转换
tolower("ABC")返回值为"abc"


##swtich控制流
feelings <- c("sad", "afraid")
for (i in feelings)
  print(
    switch(i,
           happy = "I am glad you are happy",
           afraid = "There is nothing to fear",
           sad = "Cheer up",
           angry = "Calm down now"
    )
  )


##aggregate
attach(mtcars)
aggdata <-aggregate(mtcars, by=list(cyl,gear), FUN=mean, na.rm=TRUE)
aggdata



####reshape包
融合，数据集的融合是将它重构为这样一种格式：每个测量变量独占一行，行中带有要唯一确定这个测量所需的标识符变量。
library(reshape)
md <- melt(mydata, id=(c("id", "time")))

重铸，cast()函数读取已融合的数据，并使用你提供的公式和一个（可选的）用于整合数据的函数将其重塑。调用格式为：
newdata <- cast(md, formula, FUN)
其中的md为已融合的数据，formula描述了想要的最后结果，而FUN是（可选的）数据整合函数。其接受的公式形如：
rowvar1 + rowvar2 + … ~ colvar1 + colvar2 +
  在这一公式中，rowvar1 + rowvar2 + ...定义了要划掉的变量集合，以确定各行的内容，
而colvar1 + colvar2 + ...则定义了要划掉的、确定各列内容的变量集合






###用sapply做描述性统计
vars <- c("mpg", "hp", "wt")
mystats <- function(x, na.omit=FALSE){
  if (na.omit)
    x <- x[!is.na(x)]
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  skew <- sum((x-m)^3/s^3)/n
  kurt <- sum((x-m)^4/s^4)/n - 3
  return(c(n=n, mean=m, stdev=s, skew=skew, kurtosis=kurt))
}
sapply(mtcars[vars], mystats)

Hmisc包中的describe()函数可返回变量和观测的数量、缺失值和唯一值的数目、平均值、
分位数，以及五个最大的值和五个最小的值。
library(Hmisc)
describe(mtcars[vars])

pastecs包中有一个名为stat.desc()的函数，它可以计算种类繁多的描述性统计量。使用
格式为：stat.desc(x, basic=TRUE, desc=TRUE, norm=FALSE, p=0.95)
其中的x是一个数据框或时间序列。若basic=TRUE（默认值），则计算其中所有值、空值、缺失值的数量，以及最小值、最大值、值域，还有总和。若desc=TRUE（同样也是默认值），则计算中位数、平均数、平均数的标准误、平均数置信度为95%的置信区间、方差、标准差以及变异系数。最后，若norm=TRUE（不是默认的），则返回正态分布统计量，包括偏度和峰度（以及它们的统计显著程度）和Shapiro–Wilk正态检验结果。这里使用了p值来计算平均数的置信区间（默认置信度为0.95）
library(pastecs)
stat.desc(mtcars[vars])


###分组计算描述性统计量
aggregate(mtcars[vars], by=list(am=mtcars$am), mean)
aggregate(mtcars[vars], by=list(am=mtcars$am), sd)
注意list(am=mtcars$am)的使用。如果使用的是list(mtcars$am)，则am列将被标注为Group.1而不是am。

遗憾的是，aggregate()仅允许在每次调用中使用平均数、标准差这样的单返回值函数。
它无法一次返回若干个统计量。要完成这项任务，可以使用by()函数。
dstats <- function(x)(c(mean=mean(x), sd=sd(x)))
by(mtcars[vars], mtcars$am, dstats)


。doBy包中summaryBy()函数的使用格式为
var1 + var2 + var3 + ... + varN ~ groupvar1 + groupvar2 + … + groupvarN
在~左侧的变量是需要分析的数值型变量，而右侧的变量是类别型的分组变量。function
可为任何内建或用户自编的R函数。
library(doBy)
summaryBy(mpg+hp+wt~am, data=mtcars, FUN=mystats)

###reshape包
library(reshape)
dstats <- function(x)(c(n=length(x), mean=mean(x), sd=sd(x)))
dfm <- melt(mtcars, measure.vars=c("mpg", "hp", "wt"),id.vars=c("am", "cyl"))
cast(dfm, am + cyl + variable ~ ., dstats)


频数表和列联表
本节中的数据来自vcd包中的Arthritis数据集
library(vcd)
head(Arthritis)
生成频数表
table(var1, var2, …, varN)     使用 N 个类别型变量（因子）创建一个 N 维列联表
xtabs(formula, data)           根据一个公式和一个矩阵或数据框创建一个 N 维列联表
prop.table(table, margins)     依margins定义的边际列表将表中条目表示为分数形式
margin.table(table, margins)   依margins定义的边际列表计算表中条目的和
addmargins(table, margins)     将概述边margins（默认是求和结果）放入表中
ftable(table)                  创建一个紧凑的“平铺”式列联表

可以使用table()函数生成简单的频数统计表
mytable <- with(Arthritis, table(Improved))
mytable

可以用prop.table()将这些频数转化为比例值
prop.table(mytable)

或使用prop.table()*100转化为百分比
prop.table(mytable)*100

二维列联表
xtabs()函数还可使用公式风格的输入创建列联表，格式为：
mytable <- xtabs(~ A + B, data=mydata)
其中的mydata是一个矩阵或数据框。总的来说，要进行交叉分类的变量应出现在公式的右侧（即~符号的右方），以+作为分隔符。若某个变量写在公式的左侧，则其为一个频数向量（在数据已经被表格化时很有用）。
mytable <- xtabs(~ Treatment+Improved, data=Arthritis)
mytable

你可以使用margin.table()和prop.table()函数分别生成边际频数和比例。行和与行比
例可以这样计算：
margin.table(mytable, 1)
prop.table(mytable, 1)

你可以使用addmargins()函数为这些表格添加边际和。例如，以下代码添加了各行的和与
各列的和：
addmargins(mytable)
addmargins(prop.table(mytable))

在使用addmargins()时，默认行为是为表中所有的变量创建边际和
addmargins(prop.table(mytable, 1), 2)
addmargins(prop.table(mytable, 2), 1)


##多维列表，之前的xtabs，和table都可以推广，另外，ftable()函数可以以一种紧凑而吸引人的方式输出多维列联表
mytable<-xtabs(~ Treatment+Sex+Improved, data=Arthritis)
ftable(mytable)
margin.table(mytable, 1)
margin.table(mytable, 2)
margin.table(mytable, 3)
margin.table(mytable, c(1, 3))


###独立性检验
卡方独立性检验
你可以使用chisq.test()函数对二维表的行变量和列变量进行卡方独立性检验
library(vcd)
mytable <- xtabs(~Treatment+Improved, data=Arthritis)
chisq.test(mytable)
mytable <- xtabs(~Improved+Sex, data=Arthritis)
chisq.test(mytable)

Fisher精确检验
可以使用fisher.test()函数进行Fisher精确检验。Fisher精确检验的原假设是：边界固定
的列联表中行和列是相互独立的。
mytable <- xtabs(~Treatment+Improved, data=Arthritis)
fisher.test(mytable)

Cochran-Mantel—Haenszel检验
mantelhaen.test()函数可用来进行Cochran—Mantel—Haenszel卡方检验，其原假设是，两个名义变量在第三个变量的每一层中都是条件独立的。下列代码可以检验治疗情况和改善情况在性别的每一水平下是否独立。此检验假设不存在三阶交互作用（治疗情况×改善情况×性别）。
mytable <- xtabs(~Treatment+Improved+Sex, data=Arthritis)
mantelhaen.test(mytable)

相关性的度量
library(vcd)
mytable <- xtabs(~Treatment+Improved, data=Arthritis)
assocstats(mytable)
总体来说，较大的值意味着较强的相关性

Pearson积差相关系数衡量了两个定量变量之间的线性相关程度。Spearman等级相关系数则衡
量分级定序变量之间的相关程度。Kendall’s Tau相关系数也是一种非参数的等级相关度量。
cor()函数可以计算这三种相关系数，而cov()函数可用来计算协方差
x         矩阵或数据框
use       指定缺失数据的处理方式。可选的方式为all.obs（假设不存在缺失数据——遇到缺失数据时将报错）、everything（遇到缺失数据时，相关系数的计算结果将被设为missing）、complete.obs（行删除）以及 pairwise.complete.obs（成对删除，pairwise deletion）
method    指定相关系数的类型。可选类型为pearson、spearman或kendall
states<- state.x77[,1:6]
cov(states)
cor(states)
cor(states, method="spearman")

x <- states[,c("Population", "Income", "Illiteracy", "HS Grad")]
y <- states[,c("Life Exp", "Murder")]
cor(x,y)


偏相关
偏相关是指在控制一个或多个定量变量时，另外两个定量变量之间的相互关系。
你可以使用ggm包中的pcor()函数计算偏相关系数。ggm包没有被默认安装，在第一次使用之前需要先进行安装。函数调用格式为：
pcor(u, S)
其中的u是一个数值向量，前两个数值表示要计算相关系数的变量下标，其余的数值为条件变量（即要排除影响的变量）的下标。S为变量的协方差阵
library(ggm)
#在控制了收入、文盲率和高中毕业率时
#人口和谋杀率的偏相关系数
pcor(c(1,5,2,3,6), cov(states))


相关性的显著性检验
在计算好相关系数以后，如何对它们进行统计显著性检验呢
可以使用cor.test()函数对单个的Pearson、Spearman和Kendall相关系数进行检验。简化后的使用格式为：
cor.test(x, y, alternative = , method = )
其中的x和y为要检验相关性的变量，alternative则用来指定进行双侧检验或单侧检验（取值
为"two.side"、"less"或"greater"），而method用以指定要计算的相关类型（"pearson"、
"kendall"或"spearman"）。当研究的假设为总体的相关系数小于0时，请使用alternative=
  "less"。在研究的假设为总体的相关系数大于0时，应使用alternative="greater"。
cor.test(states[,3], states[,5])

cor.test每次只能检验一种相关关系。但幸运的是，psych包中提供的corr.test()函数可以一次做更多事情
library(psych)
corr.test(states, use="complete")
参数use=的取值可为"pairwise"或"complete"（分别表示对缺失值执行成对删除或行删除）。参数method=的取值可为"pearson"（默认值）、"spearman"或"kendall"。

我们关注了偏相关系数。在多元正态性的假设下，psych包中的pcor.test()函数可以用来检验在控制一个或多个额外变量时两个变量之间的条件独立性。使用格式为
pcor.test(r, q, n)
其中的r是由pcor()函数计算得到的偏相关系数，q为要控制的变量数（以数值表示位置），n为样本大小。


独立样本的t检验
。一个针对两组的独立样本t检验可以用于检验两个总体的均值相等的假设。这里假设两组数据是独立的，并且是从正态总体中抽得。
library(MASS)
t.test(Prob ~ So, data=UScrime)


非独立样本的t检验
library(MASS)
sapply(UScrime[c("U1","U2")], function(x)(c(mean=mean(x),sd=sd(x))))
with(UScrime, t.test(U1, U2, paired=TRUE))



###########非参数检验
###二组
with(UScrime, by(Prob, So, median))
wilcox.test(Prob ~ So, data=UScrime)
#Wilcoxon符号秩检验是非独立样本t检验的一种非参数替代方法。它适用于两组成对数据和无法保证正态性假设的情境。调用格式与Mann–Whitney U检验完全相同，不过还可以添加参数paired=TRUE
sapply(UScrime[c("U1","U2")], median)
with(UScrime, wilcox.test(U1, U2, paired=TRUE))
#当t检验的假设合理时，参数检验的功效更强（更容易发现存在的差异）。而非参数检验在假设非常不合理时（如对于等级有序数据）更适用。

#多于两组的比较
#如果无法满足ANOVA设计的假设，那么可以使用非参数方法来评估组间的差异。如果各组独立，则Kruskal—Wallis检验将是一种实用的方法。如果各组不独立（如重复测量设计或随机区组设计），那么Friedman检验会更合适。
kruskal.test(y ~ A, data)
friedman.test(y ~ A | B, data)
#其中的y是数值型结果变量，A是一个分组变量，而B是一个用以认定匹配观测的区组变量（blocking variable
states <- as.data.frame(cbind(state.region, state.x77))
kruskal.test(Illiteracy ~ state.region, data=states)
class <- state.region
var <- state.x77[,c("Illiteracy")]
mydata <- as.data.frame(cbind(class, var))
rm(class, var)
library(npmc)
summary(npmc(mydata), type="BF")
aggregate(mydata, by=list(mydata$class), median)



















boxplot(mpg ~ cyl, data=mtcars,
        notch=TRUE,
        varwidth=TRUE,
        col="red",
        main="Car Mileage Data",
        xlab="Number of Cylinders",
        ylab="Miles Per Gallon")

dotchart(mtcars$mpg, labels=row.names(mtcars), cex=.7,
         main="Gas Mileage for Car Models",
         xlab="Miles Per Gallon")

x <- mtcars[order(mtcars$mpg),]
x$cyl <- factor(x$cyl)
x$color[x$cyl==4] <- "red"
x$color[x$cyl==6] <- "blue"
x$color[x$cyl==8] <- "darkgreen"
dotchart(x$mpg,
         labels = row.names(x),
         cex=.7,
         groups = x$cyl,
         gcolor = "black",
         color = x$color,
         pch=19,
         main = "Gas Mileage for Car Models\ngrouped by cylinder",
         xlab = "Miles Per Gallon")





library(car)
scatterplot(weight ~ height,
            data=women,
            spread=T, lty.smooth=2,
            pch=22,
            main="Women Age 30-39",
            xlab="Height (inches)",
            ylab="Weight (lbs.)")






states <- as.data.frame(state.x77[,c("Murder", "Population",
                                     "Illiteracy", "Income", "Frost")])
cor(states)
scatterplotMatrix(states, spread=FALSE, lty.smooth=2,main="Scatter Plot Matrix")
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost,
          data=states)
summary(fit)

fit <- lm(mpg ~ hp + wt + hp:wt, data=mtcars)
summary(fit)
#探索交互项中一个变量的秩变换另一个变量和因变量的关系
library(effects)
#plot(effect(term, mod, xlevels),
#    multiline=TRUE)
library(effects)
plot(effect("hp:wt",fit,list(wt=c(2.2,3.2,4.2))),multiline=TRUE)


fit <- lm(weight ~ height, data=women)
par(mfrow=c(2,2))
plot(fit)
#修改
fit2 <- lm(weight ~ height + I(height^2), data=women)
par(mfrow=c(1,1))
plot(fit2)


#car中的各种检验
library(car)
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
qqPlot(fit, labels=row.names(states), id.method="identify",
       simulate=TRUE, main="Q-Q Plot")
#观测到Nevada 这一离群点
states["Nevada",]
#由于原来做回归的数据框行有名字，所以函数运用于模型之后是带有名字的向量
fitted(fit)["Nevada"]
residuals(fit)["Nevada"]
rstudent(fit)["Nevada"]#提取学生化已删除残差

residplot <- function(fit, nbreaks=10) {
  z <- rstudent(fit)
  hist(z, breaks=nbreaks, freq=FALSE,
       xlab="Studentized Residual",
       main="Distribution of Errors")
  rug(jitter(z), col="brown")
  curve(dnorm(x, mean=mean(z), sd=sd(z)),
        add=TRUE, col="blue", lwd=2)
  lines(density(z)$x, density(z)$y,
        col="red", lwd=2, lty=2)
  legend("topright",
         legend = c( "Normal Curve", "Kernel Density Curve"),
         lty=1:2, col=c("blue","red"), cex=.7)
}
residplot(fit)

#检验残差是否自相关
durbinWatsonTest(fit)

#点图指的是总模型的残差加上一个自变量与其回归系数的乘积vs该自变量，直线则是一个自变量与其回归系数的乘积vs该自变量，以此检验线性于参数假设
crPlots(fit)

#检验异方差
#原假设为不存在异方差
ncvTest(fit)
spreadLevelPlot(fit)


#全局检验，整体性检验线性模型的假设
library(gvlma)
gvmodel<-gvlma(fit)
summary(gvmodel)

#检验多重共线性
vif(fit)
sqrt(vif(fit)) > 2 # problem?

#检验异常点
#拟合效果不好的点 outlier
outlierTest(fit)
##Cook值大于4/(n-k-1)就说明影响大
cutoff <- 4/(nrow(states)-length(fit$coefficients)-2)
plot(fit, which=4, cook.levels=cutoff)
abline(h=cutoff, lty=2, col="red")

influencePlot(fit, id.method="identify", main="Influence Plot",
              sub="Circle size is proportional to Cook’s distance")
#Nevada and Rhode Island are outliers; NewYork, California, Hawaii,and Washington have high leverage; and Nevada, Alaska, and Hawaii are influential observations


#修正因变量的形式来符合正态性假设
#最大似然找出指数
summary(powerTransform(states$Murder))
#从LR test中的lambda=（1） 的p值可以看出没必要做变换 说明原方程还是较好地拟合正态

#当线性于参数假设不符合，可以修正自变量的形式（改变指数）来改正
boxTidwell(Murder~Population+Illiteracy,data=states)
#说明popluation指数是0.86，illiteracy指数是1.35，但由p值可以看出没必要做变换

#检验异方差
#原假设为不存在异方差
ncvTest(fit)
spreadLevelPlot(fit)
#如果不是水平，且ncvTest检验不满足同方差，按Suggested power transformation修正因变量


#内嵌模型的比较 anova
fit1 <- lm(Murder ~ Population + Illiteracy + Income + Frost,data=states)
fit2 <- lm(Murder ~ Population + Illiteracy, data=states)
anova(fit2, fit1)
#不添加两个变量
AIC(fit1,fit2)
#以最小AIC最优

#但当方程的自变量过多，要检验的方程太多，则应该使用前进、后退、逐步方法
library(MASS)
fit1 <- lm(Murder ~ Population + Illiteracy + Income + Frost,data=states)
stepAIC(fit, direction="backward")

#根据所有自变量的可能子集做回归，该法优于上一个，但太耗时间
library(leaps)
leaps<-regsubsets(Murder~Population+Illiteracy+Income+Frost,data=states,nbest=4)
plot(leaps, scale="adjr2")
library(car)
subsets(leaps, statistic="cp",main="Cp Plot for All Subsets Regression")
abline(1,1,lty=2,col="red")

#关于模型的预测评价
#如果仅仅是描述由数据构建的模型再选择好自变量后其实已经可以，但是为了更好地预测现实世界的种种情况，还需要对模型的预测能力做进一步的分析
#思路，将数据分解成k个子集，以其中一个作为预测的变量，以剩下的k-1个为基础做出回归模型，最后算出R
shrinkage <- function(fit, k=10){
  require(bootstrap)
  theta.fit <- function(x,y){lsfit(x,y)}
  theta.predict <- function(fit,x){cbind(1,x)%*%fit$coef}
  x <- fit$model[,2:ncol(fit$model)]
  y <- fit$model[,1]
  results <- crossval(x, y, theta.fit, theta.predict, ngroup=k)
  r2 <- cor(y, fit$fitted.values)^2
  r2cv <- cor(y, results$cv.fit)^2
  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
  cat("Change =", r2-r2cv, "\n")
}
fit <- lm(Murder ~ Population + Income + Illiteracy + Frost, data=states)
shrinkage(fit)

#判断各个变量的重要性
relweights <- function(fit,...){
  R <- cor(fit$model)
  nvar <- ncol(R)
  rxx <- R[2:nvar, 2:nvar]
  rxy <- R[2:nvar, 1]
  svd <- eigen(rxx)
  evec <- svd$vectors
  ev <- svd$values
  delta <- diag(sqrt(ev))
  lambda <- evec %*% delta %*% t(evec)
  lambdasq <- lambda ^ 2
  beta <- solve(lambda) %*% rxy
  rsquare <- colSums(beta ^ 2)
  rawwgt <- lambdasq %*% beta ^ 2
  import <- (rawwgt / rsquare) * 100
  lbls <- names(fit$model[2:nvar])
  rownames(import) <- lbls
  colnames(import) <- "Weights"
  barplot(t(import),names.arg=lbls,
          ylab="% of R-Square",
          xlab="Predictor Variables",
          main="Relative Importance of Predictor Variables",
          sub=paste("R-Square=", round(rsquare, digits=3)),
          ...)
  return(import)
}
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
relweights(fit, col="lightgrey")






















##方差分析
#注意anova函数在基础包和在car包是不一样的，anova在基础包是可以选择三种方差分析类型中的一种，aov只能分析第一种
#单因素方差分析

library(mvtnorm)
library(survival)
library(TH.data)
library(multcomp)
attach(cholesterol)
table(trt)
aggregate(response,by=list(trt),mean)
aggregate(response,by=list(trt),sd)
fit<-aov(response~trt)
summary(fit)
library(gplots)
plotmeans(response ~ trt, xlab="Treatment", ylab="Response",main="Mean Plot\nwith 95% CI")#画出每组均值及其大致分布
detach(cholesterol)

#用TUkeyHSD检验哪些组均值不同，但该函数和HH包中的函数冲突，可以用detach("package:HH")将其移出搜索路径
TukeyHSD(fit)
par(las=2)
par(mar=c(5,8,4,2))
plot(TukeyHSD(fit))

library(multcomp)
par(mar=c(5,4,6,2))
tuk <- glht(fit, linfct=mcp(trt="Tukey"))
plot(cld(tuk, level=.05),col="lightgrey")


#方差检验假设，因变量正态分布，在各组中方差一致

###检验方差分析的假设前提
##检验正态性假设
library(car)
qqPlot(lm(response ~ trt, data=cholesterol),simulate=TRUE, main="Q-Q Plot", labels=FALSE)#点都落入95%的带中，符合正态性假设
##检验方差齐性
bartlett.test(response ~ trt, data=cholesterol)
#原假设，方差相同
library(car)
outlierTest(fit)


##单因素协变量方差分析
#使用litter数据集，该数据集记录了四组被注入不同药剂量的怀孕母鼠，因变量是它们生出的小鼠的体重，协变量是怀孕时间
data(litter, package="multcomp")
attach(litter)
table(dose)
aggregate(weight, by=list(dose), FUN=mean)
fit <- aov(weight ~ gesttime + dose)
summary(fit)
#F检验表示协变量gesttime和出生体重有关，因素变量dose在控制协变量不变时和出生体重有关
#为获得调整后的组均值，即去除了协变量的影响后的组均值
library(effects)
effect("dose", fit)
#已知要比较的具体关系，联想spss中的方差分析中的多项式
library(multcomp)
contrast <- rbind("no drug vs. drug" = c(3, -1, -1, -1))
summary(glht(fit, linfct=mcp(dose=contrast)))
#即检验无药物注射的小组和其他三个小组的差别

#检验假设
library(multcomp)
fit2 <- aov(weight ~ gesttime*dose, data=litter)
summary(fit2)
#交互项不显著，证明了斜率相等的假设，
#可视化结果
library(lattice)
library(grid)
library(latticeExtra)
library(RColorBrewer)
library(gridExtra)
library(HH)
ancova(weight ~ gesttime + dose, data=litter)

###双因素方差分析
attach(ToothGrowth)
table(supp, dose)
aggregate(len, by=list(supp, dose), FUN=mean)
aggregate(len, by=list(supp, dose), FUN=sd)
fit <- aov(len ~ supp*dose)
summary(fit)
interaction.plot(dose, supp, len, type="b",
                 col=c("red","blue"), pch=c(16, 18),
                 main = "Interaction between Dose and Supplement Type")
library(gplots)
plotmeans(len ~ interaction(supp, dose, sep=" "),
          connect=list(c(1,3,5),c(2,4,6)),
          col=c("red", "darkgreen"),
          main = "Interaction Plot with 95% CIs",
          xlab="Treatment and Dose Combination")
library(HH)
interaction2wt(len~supp*dose)


###重复测量方差分析
w1b1 <- subset(CO2, Treatment=='chilled')
fit <- aov(uptake~conc*Type + Error(Plant/conc), w1b1)
summary(fit)
par(las=2)
par(mar=c(10,4,4,2))
with(w1b1, interaction.plot(conc,Type,uptake,
                            type="b", col=c("red","blue"), pch=c(16,18),
                            main="Interaction Plot for Plant Type and Concentration"))
boxplot(uptake ~ Type*conc, data=w1b1, col=(c("gold", "green")),
        main="Chilled Quebec and Mississippi Plants",
        ylab="Carbon dioxide uptake rate (umol/m^2 sec)")


###单因素多变量方差分析
library(MASS)
attach(UScereal)
y <- cbind(calories, fat, sugars)
aggregate(y, by=list(shelf), FUN=mean)
cov(y)
fit <- manova(y ~ shelf)
summary(fit)
summary.aov(fit)

##单因素多变量方差分析的假设：正态，方差齐性
center <- colMeans(y)
n <- nrow(y)
p <- ncol(y)
cov <- cov(y)
d <- mahalanobis(y,center,cov)
coord <- qqplot(qchisq(ppoints(n),df=p),
                d, main="Q-Q Plot Assessing Multivariate Normality",
                ylab="Mahalanobis D2")
abline(a=0,b=1)
identify(coord$x, coord$y, labels=row.names(UScereal))#交互标记
#方差齐性R并没有什么好的检验

#如果两个假设不满足，可以用稳健的单因素多变量方差分析
library(robustbase)
library(rrcov)
Wilks.test(y,shelf,method="mcd")

##单因素方差分析与回归分析
library(survival)
library(multcomp)
levels(cholesterol$trt)
fit.aov <- aov(response ~ trt, data=cholesterol)
summary(fit.aov)
250