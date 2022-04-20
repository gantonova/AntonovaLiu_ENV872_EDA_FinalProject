library(tidyverse)
library(lubridate)
library(dplyr)
library(plyr)
library(nlme)
library(ggnewscale)
library(readr)
fire <- read.csv("./Data/Raw/Fire300milesBuffer.csv")
Visitation_by_Month <- read_csv("./Data/Raw/Visitation_by_Month.csv")

#fire
fire$Date<- as.Date(fire$ALARM_DATE,format = "%Y/%m/%d")
fire.p <- fire %>%
  select(Date, REPORT_AC) %>%
  mutate(Year= year(Date)) %>%
  mutate(Month= month(Date)) %>%
  filter(Year >1998 & Year < 2020) %>%
  mutate(count = 1) %>%
  drop_na()
#sum by month each year
fire.sum <- fire.p%>%
  group_by(Year, Month) %>%
  dplyr::summarize(summonth = sum(REPORT_AC),
                   Count = sum(count)) %>%
  mutate(Date = ym(paste(Year, Month,sep = "-")))

## visitation data wrangling & exploratory analysis
#Pivot Longer to create a tidy dataset

# Gather nutrient data into one column using pivot_longer
Visitation_by_month_gathered <- Visitation_by_Month %>%
  pivot_longer(JAN:DEC, names_to = "Month", values_to = "Recreational_Visits")

#Create a date column
Visitation_by_month_gathered$Date <- ymd( paste(Visitation_by_month_gathered$Year, Visitation_by_month_gathered$Month, "1", sep="-") )
head(Visitation_by_month_gathered)

Visitation_by_month_gathered <- filter(Visitation_by_month_gathered, Year > 1998 & Year < 2020 )
Visitation_by_month_gathered$Month <- month(Visitation_by_month_gathered$Date)

#join datasets
yosefire <- inner_join(Visitation_by_month_gathered,fire.sum, by="Date")
yosefire <- yosefire%>%
  select(Recreational_Visits:Count) %>%
  filter(Count<100)
colnames(yosefire)<- c("Visits","Date", "Year","Month","Sumfire","Firecounts")
write.csv(yosefire, "./Data/Processed/Yosefire.csv")
