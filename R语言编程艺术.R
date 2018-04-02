####################################################
########### Case1 寻找连续出现1的游程 ##############
####################################################
findruns <- function(x,k){
  #输入一个向量x，返回游程为k的位置索引
  n <- length(x)
  runs <- NULL
  for(i in 1:(n-k+1)){
    if(all(x[i:(i+k-1)]==1)) runs <- c(runs,i)
  }
  return(runs)
}
## c(runs,i) 频繁分配内存，每次执行代码会减慢速度
findruns1 <- function(x,k) {
  n <- length(x)
  count <- 0
  runs <- vector(length = n)
  for(i in 1:(n-k+1)){
    if(all(x[i:(i+k-1)]==1)){
      count <- count+1
      runs[count] <- i
    }
  }
  if(count>0){
    runs <- runs[1:count]
  } else{ 
    runs <- NULL
    }
  return(runs)
}

# 预测离散时间序列，1表示雨，0表示晴，通过最近k天的晴雨天数利用过半数原则判断晴雨
preda <- function(x,k){
  #返回这种估计的错误率
  n <- length(x)
  k2 <- k/2
  preda <- vector(length = n-k)
  for(i in 1:(n-k)){
    if(sum(x[i:(i+k-1)])>=k2) preda[i] <- 1 else preda[i] <- 0
  }
  #preda-x[(k+1):n]表示第（k+1）天到第n天的预测和实际相减去
  return(mean(abs(preda-x[(k+1):n])))
}
#sum函数占用时间，效率低
predb <- function(x,k){
  n <- length(x)
  k2 <- k/2
  predb <- vector(length = n-k)
  sm <- sum(x[1:k])
  if(sm>=k2) predb[1] <- 1 else predb[1] <- 0
  if(n-k>=2){
    for(i in 2:(n-k)){
      sm <- sm+x[i+k-1]-x[i-1]
      if(sm>=k2) predb[i] <- 1 else predb[i] <- 0
    }
  }
  return(mean(abs(predb-x[(k+1):n])))
}
###引入cumsum()
predc <- function(x,k){
  n <- length(x)
  k2 <- k/2
  predc <- vector(length = n-k) 
  csx <- c(0,cumsum(x))
  for(i in 1:(n-k)){
    if(csx[i+k]-csx[i]>=k2) predc[i] <- 1 else predc[i] <- 0
  }
  return(mean(abs(predc-x[(k+1):n])))
}


####################################################
############### Case2 图像操作 #####################
####################################################

library(pixmap)
pic <- read.pnm("pix.pgm")
x <- read.pnm(system.file("pictures/logo.ppm", package="pixmap")[1])

plot(x)
str(x)
x@green[30:50,30:50] <- 1
plot(x)

##使用随机数模糊处理图片
blurtpart <- function(img,rows_range,cols_range,q){
  lrows <- length(rows_range)
  lcols <- length(cols_range)
  newimg <- img
  randomnoise <- matrix(nrow=lrows,ncol=lcols,runif(lrows*lcols))
  newimg@green[rows_range,cols_range] <- (1-q)*img@green[rows_range,cols_range]+q*randomnoise
  return(newimg)
}

plot(blurtpart(x,30:50,30:50,0.8))


####################################################
####### Case3 找出图中距离最近的一对端点 ###########
####################################################

mind <- function(d){
  n <- nrow(d)
  dd <- cbind(d,1:n)
  wmins <- apply(dd[-n,],1,imin)
  i <- which.min(wmins[2,])
  j <- wmins[1,i]
  return(c(d[i,j]),i,j)
}

imin <- function(x){
  lx <- length(x)
  i <- x[lx]
  j <- x[(i+1):(lx-1)]
  l <- i+j
  return(c(k,x[k]))
}


####################################################
############### Case3 闭包操作 #####################
####################################################
counter <- function(){
  ctr <- 0
  f <- function(){
    ctr <<- ctr+1
    cat(ctr,"\n")
  }
  return(f)
}
c1 <- counter()
c2 <- counter()
c1()
c2()
c1()
c1()
c2()





####################################################
############### Case4 置换函数 #####################
####################################################
u <- "g <- "(u,value=v)

newbookvec <- function(x){
  tmp <- list()
  tmp$vec <- x
  tmp$wrts <- rep(0,length(x))
  class(tmp) <- "bookvec"
  return(tmp)
}

"[.bookvec" <- function(bv,subs){
  return(bv$vec[subs])
}

"[<-.bookvec" <- function(bv,subs,value){
  bv$wrts[subs] <- bv$wrts[subs]+1
  bv$vec[subs] <- value
  return(bv)
}
b <- newbookvec(c(3,4,5,5,12,13))
b
b[2]
b[2] <- 88
b[2]
b$wrts




