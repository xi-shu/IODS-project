hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)
#change the longer name 
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "LEaB"
colnames(hd)[5] <- "EYoE"
colnames(hd)[6] <- "MYoE"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "rank"
#Mutate the “Gender inequality” data and create two new variables. 
install.packages("tidyverse")
library(dplyr)
library(ggplot2)
colnames(gii)[7] <- "edu2F"
colnames(gii)[8] <- "edu2M"
gii<- mutate(gii, R_Fe_Ma_p = (edu2F + edu2M) / 2)
colnames(gii)[9] <- "laF"
colnames(gii)[10] <- "laM"
gii<-mutate(gii, ratio_lfpofF_M = (laF + laM) / 2)
#join two dataset
human<- inner_join(hd, gii, by = "Country", suffix = c(".hd", ".gii"))
write.csv(human,file="human.csv")
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)
names(human)
str(human)
dim(human)
summary(human)
#mutatuion data 
library(stringr)
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric
#keep content 
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))
#Remove all rows with missing values and regions 
human$Country
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human_ <- filter(human, complete.cases(human))

#row names of the data is the countres' names
tail(human_, 10)
last <- nrow(human_) - 7
human_ <- human_[1:last, ]
rownames(human_) <- human_$Country
human <- select(human_, -Country)
write.csv(human,file="human.csv")
