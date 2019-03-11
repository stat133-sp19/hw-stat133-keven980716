# ===================================================================================
# Title: Make Global Table of Shots Data
#
# Description: This R script will clean the raw data and help us to get
#              a main table which will be used for later data analysis.
#
# Input(s): 5 raw data file: 'andre-iguodala.csv', 'draymond-green.csv',
#                            'kevin-durant.csv', 'klay-thompson.csv',
#                            'stephen-curry.csv'
#
# Output(s): text files: 'andre-iguodala-summary.txt', 'draymond-green-summary.txt',
#                        'kevin-durant-summary.txt', 'klay-thompson-summary.txt',
#                        'stephen-curry-summary.txt', 'shots-data-summary.txt'
#            CSV file 'shots-data.csv'
# ===================================================================================

library(dplyr)
library(ggplot2)


# read raw data files with relative path
iguodala <- read.csv("../data/andre-iguodala.csv",stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv",stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv",stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv",stringsAsFactors = FALSE)
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)


# add a column name to each imported data frame, that contains the name of the corresponding player
iguodala$name <- rep("Andre Iguodala", nrow(iguodala))
green$name <- rep("Draymond Green",nrow(green))
durant$name <- rep("Kevin Durant", nrow(durant))
thompson$name <- rep("Klay Thompson", nrow(thompson))
curry$name <- rep("Stephen Curry", nrow(curry))


# change the original values of shot_made_flag 
iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "shot_no"
iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "shot_yes"
green$shot_made_flag[green$shot_made_flag == "n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag == "y"] <- "shot_yes"
durant$shot_made_flag[durant$shot_made_flag == "n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "shot_yes"
curry$shot_made_flag[curry$shot_made_flag == "n"] <- "shot_no"
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "shot_yes"


# add a column minute that contains the minute number where a shot occurred
iguodala <- mutate(iguodala, minute = (period-1)*12 + 12 - minutes_remaining)
green <- mutate(green, minute = (period-1)*12 + 12 - minutes_remaining)
durant <- mutate(durant, minute = (period-1)*12 + 12 - minutes_remaining)
thompson <- mutate(thompson, minute = (period-1)*12 + 12 - minutes_remaining)
curry <- mutate(curry, minute = (period-1)*12 + 12 - minutes_remaining)


# use sink() to send the summary() output of each imported data frame into individuals text files
sink(file = "../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

sink(file = "../output/draymond-green-summary.txt")
summary(green)
sink()

sink(file = "../output/kevin-durant-summary.txt")
summary(durant)
sink()

sink(file = "../output/klay-thompson-summary.txt")
summary(thompson)
sink()

sink(file = "../output/stephen-curry-summary.txt")
summary(curry)
sink()


# use the row binding function rbind() to stack the tables into one single data frame
shots_data <- rbind(iguodala,green,durant,thompson,curry)


# export (i.e. write) the assembled table as a CSV file shots-data.csv inside the folder data/
write.csv(x = shots_data, 
          file = "../data/shots-data.csv"
          )


# use sink() to send the summary() output of the assembled table
sink(file = "../output/shots-data-summary.txt")
summary(shots_data)
sink()




