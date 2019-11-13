#shuxi 2019/11/11 data_learning

library(ggplot2)
learning2014<- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",
                        sep="\t", header=TRUE)

qplot(Attitude, Points, col=gender, data=learning2014)+geom_smooth(methods="lm")


#Scale all combination variables to the original scales (by taking the mean)
mean(learning2014$Age)
mean(learning2014$Attitude)
mean(learning2014$Points)
mean(learning2014$Aa)
mean(learning2014$Ab)

str(learning2014)

library(tidyverse)
print(learning2014$Points==0)


