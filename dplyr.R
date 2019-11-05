##Introduction to tidyverse

# made up of 
# ggplot - functions for plotting data
# dplyr - functions for data manipulation
# tidyr - functions to get into "tidy data"
# readr - functions to read in data
# purr - allows you to work with functions and vectors to replace for loops
# tibble - a version of a dataframe
# stringr - manipulating strings
# forcats - working with factors

#lets starts by installing the package if you dont have it
install.packages("tidyverse")

#let get a dataset to play around with...
#pasilla dataset from Brooks et al. Investigation into the effect of siRNA knock-down of pasilla,
#a gene that is thought to be involved in regulation of splicing. The dataset contains 3 biological replicates
#of the knockdown and 4 biological replicates for the untreated control.
BiocManager::install("pasilla")

#find location of the data
location_of_dataset <- system.file("extdata", package = "pasilla", mustWork = T)

#read in the data
pasilla <- read.delim(file.path(location_of_dataset, "pasilla_sample_annotation.csv"), sep = ",")

#load the library
#we will use require in this instance just to illustrate the packages that are attached
#feel free to use the normal library()
require(tidyverse)

# rules for tidyverse
# each variable in in its own column
# each observation/case is in its own row

#it also introduced the concenpt of pipeing something into something else
#if you have ever used command line it is akin to "|"
#but in R it is represented as %>%

#Lets find out the total number of lanes we have use throughout the experiment
summarise(pasilla, total = sum(exon.counts))

#or with the pipe we could do this: 
#(notice how when you pipe, you do not need to use the $ operator to call a vector. 
#Autofill with tab should also show the possible vectors)
pasilla %>%
  summarise(total = sum(exon.counts))

#the piping allows you to push the data into another function. 
#Usually you would store it as a new dataframe, but when you pipe, there is no need to have in intermediate dataframe
pasilla %>%
  group_by(type) %>%
  summarise(average = mean(exon.counts))

#lets say we wanted to filter the data so we could only see the treated data and with exon.counts less than 14 million
pasilla %>%
  filter(condition == "treated") %>%
  filter(exon.counts < 14e6)


#lets calculate reads per lane. To create new columns, dplyr has a function called mutate.
#mutate allows you to apply vectorised functions to columns
#notice the total number of reads is x2 for paired end reads. Thats not helpful is it?
#let use a function from the stringr package to get just the numeric value

pasilla %>%
  mutate(reads.per.lane = as.numeric(stringr::str_extract(total.number.of.reads, "[0-9]+")) / number.of.lanes)












