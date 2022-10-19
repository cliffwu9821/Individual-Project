# Specify current working directory
here::i_am("code/make_figure.R")
# Find the absolute path
absolute_path_to_data <- here::here("data", "international_matches.csv")
# Load data
data <- read.csv(absolute_path_to_data, header = TRUE)
library(tidyverse)
library(ggplot2)
home_advantage_fig <- ggplot(data=data, aes(x=home_team_result, fill= home_team_result))+
  geom_bar()+theme_classic()+geom_text(stat = "count",aes(label=..count..), vjust=-1) + xlab("Game Results") + ylab("Games Counts")+ggtitle("Home Advantage Analysis")+
  theme(plot.title = element_text(hjust = 0.5),aspect.ratio = 1)+ theme(legend.position = "none")+ylim(0,13000)

saveRDS(
  home_advantage_fig,
  file = here::here("output/home_advantage_fig.rds")
)

#France performance analysis table

new_data <- data[data$date >= "2016-01-01", ]
FRA<-new_data[new_data$home_team=="France" | new_data$away_team == "France",]

france_result <- c()
for(i in 1:nrow(FRA)){
  if(FRA$home_team[i]=="France" & FRA$home_team_result[i] == "Win")
  {
    france_result <- append(france_result,"Win")
  }
  else if (FRA$away_team[i] == "France" & FRA$home_team_result[i]=="Lose") {
    france_result <- append(france_result,"Win")
  }
  else if (FRA$home_team[i]=="France" & FRA$home_team_result[i]=="Draw"){
    france_result <-append(france_result,"Draw")
  }
  else if (FRA$away_team[i]=="France" & FRA$home_team_result[i]=="Draw"){
    france_result <-append(france_result,"Draw")
  }
  else if (FRA$home_team[i]=="France" & FRA$home_team_result[i]=="Lose"){
    france_result <- append(france_result,"Lose")
  }
  else if (FRA$away_team[i]=="France" & FRA$home_team_result[i]=="Win"){
    france_result <- append(france_result,"Lose")
  }
}
FRA<-cbind(france_result,FRA)
frenchgames_fig<-ggplot(data=FRA, aes(x=france_result,fill=france_result))+
  geom_bar()+theme_classic()+geom_text(stat = "count",aes(label=..count..), vjust=-1) + xlab("Game Results") + ylab("Games Counts")+ggtitle("France International Matches Results 2016-2022")+
  theme(plot.title = element_text(hjust = 0.5),aspect.ratio = 1)+ylim(0,65)+ theme(legend.position = "none") 

saveRDS(
  frenchgames_fig,
  file = here::here("output/frenchgames_fig.rds")
)