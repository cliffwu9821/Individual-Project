# Specify current working directory
here::i_am("code/make_table.R")
# Find the absolute path
absolute_path_to_data <- here::here("data", "international_matches.csv")
# Load data
data <- read.csv(absolute_path_to_data, header = TRUE)
library(gtsummary)
library(kableExtra)
# Select three columns of interest, continent, home_team_score, away_team_score
continent<-data[,c(4,10,11)]
# Find the total of home team goals scored by continent
goal_for<-aggregate(continent$home_team_score,by=list(continent$home_team_continent),FUN=sum)
# Find the total of away team goals scored by continent
goal_against<-aggregate(continent$away_team_score,by=list(continent$home_team_continent), FUN=sum)
# Change rownames for goal_for
colnames(goal_for)[colnames(goal_for)=="Group.1"]="Continent"
colnames(goal_for)[colnames(goal_for)=="x"]="Total Number of Goals Scored"
# Change column names for goal_against
colnames(goal_against)[colnames(goal_against)=="Group.1"]="Continent"
colnames(goal_against)[colnames(goal_against)=="x"]="Total Number of Goals Allowed"
# Sorting the two dataframe by total number of goals scored and allowed
goal_for<-goal_for[order(goal_for$`Total Number of Goals Scored`,decreasing=TRUE),]
goal_against<-goal_against[order(goal_against$`Total Number of Goals Allowed`,decreasing = TRUE),]

# Use the kable package to generate tables for home advantage analysis
table_one<-knitr::kable(list(goal_for,goal_against), align="lccrr", caption = "Home Advantage Analysis (Table 1)", row.names = FALSE) %>%
  kable_material(c("striped","hover"))

saveRDS(
  table_one,
  file = here::here("output/table_one.rds")
)

