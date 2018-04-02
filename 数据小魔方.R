###########################################################################################
#### 基础字符串处理函数??????stringr
#### 绘图系统：plot??????ggplot2
#### 代码风格：函数嵌套??????管道函数（`%>%`）
#### 列表处理：list（自建循环）??????rlist
#### json处理：Rjson+RJSONIO??????jsonlite
#### 数据抓取：RCurl+XML??????httr+xml2
#### 循环任务：for/while??????apply??????plyr::a_ply??????并行运算（foreach、parallel）
#### 切片索引：subset??????dplyr::select+filter
#### 聚合运算：aggregate??????plyr::ddply+mutate??????dplyr::group_by+summarize
#### 数据联结：merge??????plyr::join??????dplyr::left/right/inner/outer_join
#### 数据塑型：plyr::melt/dcast??????tidyr::gather/spread
###########################################################################################








####  关于R语言软件的更新：

install.packages("installr")#下载安装工具包

library(installr) #加载安装工具包

check.for.updates.R()#检测是否有最新版的R软件

installr()#下载并安装新版R软件

copy.packages.between.libraries()#复制旧版R中的包到新版R中

#数据重塑
reshape2::melt(data, id.vars = c("姓名","性别"),variable.name = "科目", value.name = "成绩")


####数据合并
ID<-c(1,2,3,4)
name<-c("A","B","C","D")
score<-c(60,70,80,90)
student1<-data.frame(ID,name)
student2<-data.frame(ID,score)
student1;student2

merge(student1,student2,by=c("ID","ID"))

#inner（内部链接）只合并交集
m1 <- merge(authors, books, by.x = "surname", by.y = "name")

#left join（左连接）
m2 <- merge(authors, books, by.x = "surname", by.y = "name",all.x=TRUE)

#right join（右连接）
m3 <- merge(authors, books, by.x = "surname", by.y = "name",all.y=TRUE)

#all_join（外连接）
m4 <- merge(authors, books, by.x = "surname", by.y = "name",all=TRUE)

library(dplyr)
##### dplyr::inner_join/full_join/left_join/right_join
x<-data.frame(Name=c("John","Paul","George","Ringo","Stuart","Pete"),instrument=c("guitar","bass","guitar","drums","bass","drums"))
y<-data.frame(name=c("John","Paul","George","Ringo","Brian"),band=c("TRUE","TRUE","TRUE","TRUE","FALSE"))
x;y
#(1)inner_join(x, y) ：只包含同时出现在x,y表中的行
inner_join(x,y,by=c("Name"="name"))

#(2)left_join(x, y) ：包含所有x中以及y中匹配的行
left_join(x,y,by=c("Name"="name"))

#(3)right_join(x, y,by=c("Name"="name")) ：包含所有y中以及x中匹配的行
right_join(x,y,by=c("Name"="name"))

#(4)full_join(x,y,by=c("Name"="name")) ：包含所以x、y中的行
full_join(x,y,by=c("Name"="name"))

#(5)semi_join(x, y) ：包含x中，在y中有匹配的行，结果为x的子集
semi_join(x,y,by=c("Name"="name"))

#(6)anti_join(x, y) ：包含x中，不匹配y的行，结果为x的子集，与semi_join相反
anti_join(x,y)

library(sqldf)
sqldf("select * from x left join y on x.Name=y.name")

#######  data.table
# data.table中提供了将行索引、列切片、分组功能于一体的数据处理模型
data.table[i,j,by]


mydata <- fread("https://raw.githubusercontent.com/wiki/arunsrinivasan/flights/NYCflights14/flights14.csv")
str(mydata)
# 行索引，类似dataframe
mydata[carrier %in% c("AA","AS"),]
# 列索引
mydata[,list(carrier,tailnum)]  
mydata[,.(carrier,tailnum)]

# 列索引的位置不仅支持列名索引，可以直接支持内建函数操作
mydata[,.(f100 = flight/1000,carrier,tailnum)]
# 支持直接在列索引位置新建列，赋值符号为:=
mydata[,delay_all := dep_delay+arr_delay]
# 删除一列
mydata[,delay_all := NULL]

# 批量操作
mydata[,c("delay_all","delay_dif") := .((dep_delay+arr_delay),(dep_delay-arr_delay))]
mydata[,c("delay_all","delay_dif") := NULL]

#可以直接使用data.table内建的函数
mydata[carrier %in% c("AA","AS"),.N]


mydata[carrier %in% c("AA","AS"),.(sum(dep_delay),mean(arr_delay))]
mydata[carrier %in% c("AA","AS"),.(dep_delay,mean(arr_delay))]
mydata[carrier %in% c("AA","AS") & dep_delay %between% c(500,1000),.(dep_delay,arr_delay)]


mydata[,.(sum(dep_delay),mean(arr_delay)),by = carrier]
mydata[,.(sum(dep_delay),mean(arr_delay)),by = .(carrier,origin)]

#排序
setorder(mydata,carrier,-arr_delay)

##数据合并
DT <- data.table(x=rep(letters[1:5],each=3), y=runif(15))
DX <- data.table(z=letters[1:3], c=runif(3))
setkey(DT,x)
setkey(DX,z)

DT[DX]



########### 多任务处理与并行运算包??????foreach
library("foreach")
library("doParallel")
library("httr") 
library("jsonlite")
library("magrittr")

GETPDF <-  function(i){
  url<-"https://index.toutiao.com/api/report"
  headers<-c(        
    "Host"="index.toutiao.com", 
    "User-Agent"="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.79 Safari/537.36"
  )
  payload <-list("page"=1,"size"=12)
  payload[["page"]]=i
  web <- GET(url,add_headers(.headers = headers),query = payload)
  content <- web %>% content(as="text",encoding="UTF-8") %>% fromJSON() %>% `[[`(9)  
}

#方案1??????使用%do%函数执行普通的向量运算
system.time({
  cl<- makeCluster(4)      
  registerDoParallel(cl)       #进行进程注册
  mydata1 <- foreach(
    i=1:16,          #输入等待请求的参数
    .combine=rbind,  #返回结果的整合
    .packages = c("httr", "jsonlite","magrittr") 
    #多个进程共享的系统环境
  ) %dopar% GETPDF(i)
  stopCluster(cl)
})

#方案2??????使用%dopar%函数执行多进程的运算

system.time({
  cl<-makeCluster(4)
  registerDoParallel(cl)
  mydata2 <- foreach(i=1:16,.combine=rbind) %do% GETPDF(i)
})


system.time(
  mydata3 <- plyr::ldply(1:16,GETPDF)
)


########### 多进程与并行处理包parallel
library("parallel")
detectCores()           #计算计算机核心数：
detectCores(logical=F)  #获取实际物理核心数

system.time({
  cl<- makeCluster(4)      
  registerDoParallel(cl)       #进程注册
  mydata1 <- foreach(
    i=1:16,          #输入等待请求的参数
    .combine=rbind,  #返回结果的整合
    .packages = c("httr","jsonlite","magrittr") 
    #多个进程共享的系统环境
  ) %dopar% GETPDF(i)
  stopCluster(cl)
})

system.time({
  cl<- makeCluster(detectCores())  
  all.pcg <-  c("httr","jsonlite","magrittr")  
  worker.init <- function(p) sapply(p,library,character.only=TRUE) 
  clusterCall(cl, worker.init, all.pcg)    
  #此句用于将各个子进程的环境全部加载分配到各进程环境中
  mydata2 <- parLapply(
    cl,      #进程环境
    1:16,    #遍历参数
    GETPDF   #测试代码语句
  ) %>% rlist::list.rbind()
  stopCluster(cl)
})

