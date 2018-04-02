library(magrittr)


## extract等同于dataframe 取
iris %>%
  extract(1:2, 1:4) # iris[1:2,1:4]

good.times <-
  Sys.Date() %>%
  as.POSIXct %>%
  seq(.,by = "15 mins", length.out = 100) %>%
  data.frame(timestamp = .)

# %<>%操作可以进行在数据集上
x <- rnorm(10)
x %>% abs
x
x %<>% abs %>% sort

# %$% 将数据框带入环境中
iris %>%
  subset(Sepal.Length > mean(Sepal.Length)) %$%
  cor(Sepal.Length, Sepal.Width)

# %>% 将前一部分直接带入下一部分
1:10 %>% (call("sum"))
# 注意{}
rnorm(100) %>% {c(min(.), mean(.), max(.))} %>% floor

# %>% 构造函数 
mean_fun <- . %>% mean
1:10 %>% mean_fun

# %T>% 类似 %>% 但是不返回右边而是左边 
rnorm(200) %>%
  matrix(ncol = 2) %T>%
  plot %>% 
  colSums()
rnorm(200) %>%
  matrix(ncol = 2) %>%
  plot %>% 
  colSums()

