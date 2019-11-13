library(dplyr)
library(ggplot2)

#loading the data & exploring the structure
url <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets"
url_mat <- paste(url, "student-mat.csv", sep = "/")
url_mat
mat <- read.table(url_math, sep = ";" , header=TRUE)
url_por <- paste(url, "student-por.csv", sep ="/")
url_por
por <- read.table(url_por, sep = ";", header = TRUE)
colnames(mat)
colnames(por)

dim(mat)
str(mat)
dim(por)
str(por)

join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
math_por <- inner_join(mat, por, by = join_by, suffix = c(".mat", ".por"))
joined_columns <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]
notjoined_columns

for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

#new variables
alc <- alc %>% 
  mutate(alc_use = (Dalc + Walc)/2) %>% 
  mutate(high_use = alc_use > 2)

#saving the tidied dataset

write.table(alc,file="alc.cvs",sep = ",")
