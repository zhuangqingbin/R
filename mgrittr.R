library(magrittr)


## extract��ͬ��dataframe ȡ
iris %>%
  extract(1:2, 1:4) # iris[1:2,1:4]

good.times <-
  Sys.Date() %>%
  as.POSIXct %>%
  seq(.,by = "15 mins", length.out = 100) %>%
  data.frame(timestamp = .)

# %<>%�������Խ��������ݼ���
x <- rnorm(10)
x %>% abs
x
x %<>% abs %>% sort

# %$% �����ݿ���뻷����
iris %>%
  subset(Sepal.Length > mean(Sepal.Length)) %$%
  cor(Sepal.Length, Sepal.Width)

# %>% ��ǰһ����ֱ�Ӵ�����һ����
1:10 %>% (call("sum"))
# ע��{}
rnorm(100) %>% {c(min(.), mean(.), max(.))} %>% floor

# %>% ���캯�� 
mean_fun <- . %>% mean
1:10 %>% mean_fun

# %T>% ���� %>% ���ǲ������ұ߶������ 
rnorm(200) %>%
  matrix(ncol = 2) %T>%
  plot %>% 
  colSums()
rnorm(200) %>%
  matrix(ncol = 2) %>%
  plot %>% 
  colSums()
