# fire
options(rpr.plot.width = 4, repr.plot.height = 2)
fireplot <- ggplot(data = fire)+
  geom_point(aes(x = Date,y = REPORT_AC,color="red"))+
  ylab("Fire Extent (Acre)")+
  scale_x_date(limits = as.Date(c('1900-01-01','2020-12-31')))+
  theme(legend.position = "none")

#visitation
head(Visitation_by_month_gathered)
summary(Visitation_by_month_gathered$Recreational_Visits)

library(ggplot2)
Visitation_by_month_plot <- ggplot(Visitation_by_month_gathered, aes(x = Date, y = Recreational_Visits)) +
  geom_point()+
  geom_smooth()+
  labs(x="Year", colour="Year", y = "Recreational Visits") 

visitation_by_month_plot2 <- ggplot(Visitation_by_month_gathered, aes(x = Month, y = Recreational_Visits, label=TRUE, abbr=TRUE, group=factor(Year), color=factor(Year))) +
  geom_line() +
  geom_point() +
  labs(x="Month", colour="Year", y = "Recreational Visits")+
  scale_x_continuous(breaks = 1:12)

