url="http://wenku.baidu.com/link?url=IrPZA5CLgEZnT9kl2p1DNC_T8fnzDBUeUyb8LB0Nn9Tzlwft_NhmBMIKUBQr0xd5Qhrpia0KcBn6VHEnBklH2VPCEbHDMP7s-ktrTabAZSK"
temp<-getBinaryURL(url)
note<-file("hellodata.xls",open="wb")
writeBin(temp,note)
close(note)

html<-getURL("http://rfunction.com/code/1202/")
temp<-strsplit(html,"<li><a href=\"")#获取源代码
temp
temp1<-temp[[1]]
files<-strsplit(temp1,"\"")
files
library(plyr)
files1<-laply(files,function(x){x[1]})
files1
class(files1)
files<-files1[-c(1,2)]
files
base="http://rfunction.com/code/1202/"
