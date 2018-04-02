#通过网络获得帮助
RSiteSearch("correlation")
#查看特定软件包附带的文档
vignette(package="ggplot2")


ls.str()
#以.开头命名的变量不会被ls()显示出来
.a <- 1
ls()
ls(all.names = T)

#在不退出R的情况下保存工作空间
save.image()

#上一个计算的值
.Last.value

#查看所有的载入内存的R包
search()

#卸载在载入内存的包
detach(package:quantmod)

#查看在datasets包的数据
data()

#查看下载的包
library()
installed.packages()

#在shell命令行中执行R脚本
R CMD BATCH 

#显示文件列表
list.files()
list.files(recursive = T)

#读取固定宽度的数据文件
read.fwf(filename,widths = c(...),col.names = c(...),stringAsfactor=)

#定义不要读取的行
read.csv(comment.char = "")

#读取HTML表格数据
library(XML)
readHTMLTable("http://www..../test.html",which=number)

#读取复杂数据
readlines(filename,n=number) #读取前number行数据
scan(filename,what=list(numeric(0),integer(0))) #numeric(0)读取数字类型，integer(0),complex(0),character(0),logical(0)

#保存对象
save(object,file=".RData")
load(".RData")

#向量插入
append(vec,value,after)

#将多个向量合并成单个向量及平行因子
comb <- stack(list(a=1:5,b=6:10,c=11:15))
print(comb)
aov(values~ind,comb)

#列表数据转成行形式的数据框
do.call(rbind,Map(as.data.frame,list(1:5,6:10,11:15)))

#生成binom实验
combn(1:5,3)

#将函数运用于平行向量和列表
mapply(func,vec1,vec2...)
mapply(func,list1,list2...)

#日期和时间类
Date（日期）POSIXct类（精确到秒）POSIXct类（精确到秒，且能提取日期信息）

