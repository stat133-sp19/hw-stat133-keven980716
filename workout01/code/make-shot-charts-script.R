# =====================================================================================
# Title: Make Shot Charts
#
# Description: This R script will help us to create shot charts (with court backgrounds)   
#              of each player. 
#
# Input(s): data file: 'shots-data.csv'
#           JPG file: 'nba-court.jpg'
#
# Output(s): PDF files: 'andre-iguodala-shot-chart.pdf', 'draymond-green-shot-chart.pdf',
#                        'kevin-durant-shot-chart.pdf', 'klay-thompson-shot-chart.pdf',
#                        'stephen-curry-shot-chart.pdf', 'gsw-shot-charts.pdf'
#            PNG file 'gsw-shot-charts.png'
# =====================================================================================

library(dplyr)
library(ggplot2)
library(jpeg)
library(grid)

# import the global table
shots_data <- read.csv("../data/shots-data.csv",stringsAsFactors = FALSE)

# create data frames of each player
iguodala <- shots_data[shots_data$name == "Andre Iguodala",]
green <- shots_data[shots_data$name == "Draymond Green",]
durant <- shots_data[shots_data$name == "Kevin Durant",]
thompson <- shots_data[shots_data$name == "Klay Thompson",]
curry <- shots_data[shots_data$name == "Stephen Curry",]

# import image of background of basketball court 
court_file <- "../images/nba-court.jpg"
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc"))

##########################################################################

# create and save shot charts of each player
# create shot chart for Andre Iguodala
iguodala_shot_chart <- ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()

# save shot chart of Andre Iguodala
pdf(file = "../images/andre-iguodala-shot-chart.pdf", width = 6.5, height = 5)
iguodala_shot_chart
dev.off()



# create shot chart for Draymond Green
green_shot_chart <- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()

# save shot chart of Draymond Green
pdf(file = "../images/draymond-green-shot-chart.pdf", width = 6.5, height = 5)
green_shot_chart
dev.off()



# create shot chart for Kevin Durant
durant_shot_chart <- ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()

# save shot chart of Kevin Durant
pdf(file = "../images/kevin-durant-shot-chart.pdf", width = 6.5, height = 5)
durant_shot_chart
dev.off()



# create shot chart for Klay Thompson
thompson_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()

# save shot chart of Klay Thompson
pdf(file = "../images/klay-thompson-shot-chart.pdf", width = 6.5, height = 5)
thompson_shot_chart
dev.off()



# create shot chart for Stephen Curry
curry_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()

# save shot chart of Stephen Curry
pdf(file = "../images/stephen-curry-shot-chart.pdf", width = 6.5, height = 5)
curry_shot_chart
dev.off() 

########################################################################


# create facetted shot chart
facetted_shot_chart <- ggplot(data = shots_data) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag, shape = shot_made_flag),size = 0.9) +
  ylim(-50, 420) +
  facet_wrap(~name) +
  ggtitle('Shot Charts: GSW (2016 season)') +
  scale_color_manual(name = "made shot or not",values = c("red", "#56f442")) +
  scale_shape_manual(name = "made shot or not",values = c(4,1)) +
  theme_minimal()


# save this image in PDF format
pdf(file = "../images/gsw-shot-charts.pdf", width = 8, height = 7)
facetted_shot_chart
dev.off()

#save this image in PNG format
png(filename = "../images/gsw-shot-charts.png", units="in", width = 8, height = 7, res = 300)
facetted_shot_chart
dev.off()
