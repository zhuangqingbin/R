library(RODBC)

library(xlsx)  
table_test <- xlsx::read.xlsx("ufo_awesome.xls",1) 


library(openxlsx)  
table_test <- read.xlsx("ufo_awesome.xls",1)

library(RODBC)
channel<-RODBC::odbcConnectExcel(file.choose())  ##自己选择文件
channel  ##查看文件
sqlTables(channel)  ##列出表格
sqlFetch(channel,"Sheet1")

library(RODBC)  
con <- odbcConnectExcel2007("ufo_awesome.xls") #64位机下方法  
sqlTables(con) #查看该xlsx文件中有哪些表  
#           TABLE_CAT TABLE_SCHEM TABLE_NAME   TABLE_TYPE REMARKS  
# 1 D:\\R\\RODBC.xlsx        <NA>  商品信息$ SYSTEM TABLE    <NA>  
# 2 D:\\R\\RODBC.xlsx        <NA>  补充说明$ SYSTEM TABLE    <NA>  
# 3 D:\\R\\RODBC.xlsx        <NA>  销售信息$ SYSTEM TABLE    <NA>  
table_test <- sqlFetch(con,"销售信息")  
table_test  
odbcClose(con)