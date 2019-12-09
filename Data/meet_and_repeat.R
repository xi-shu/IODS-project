#1 inout data, check their variable names, view the data contents and structures, and create some brief summaries of the variables
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
str(BPRS)
summary(BPRS)
str(RATS)
summary(RATS)
#2 Convert the categorical variables of both data sets to factors
library(dplyr)
library(tidyr)
# Factor variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
#Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS.
BPRSL <-  BPRS %>% 
  gather(key = weeks, value = bprs, -treatment, -subject)%>% 
  mutate(week = as.integer(substr(weeks,5,5)))
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 
#glimpse two new dataset
glimpse(BPRSL)
glimpse(RATSL)
BPRS<-BPRSL
RATS<-RATSL
write.csv(BPRS,file="BPRS.CVS")
write.csv(RATS,file="RATS.CVS")
