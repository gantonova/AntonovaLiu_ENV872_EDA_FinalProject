#Time Series analysis
#fire time series analysis
library(Kendall)
fire.ts <- ts(fire.sum$summonth, start = c(1992,2), frequency = 12)
#decompose
fire.Decomposed <- stl(fire.ts, s.window = "periodic")
TSplotfire<- plot(fire.Decomposed, main = "Fire Extent Decomposed")
#Mann Kendall test
fire.trend1 <- Kendall::SeasonalMannKendall(fire.ts)
summary(fire.trend1)

#Time Series Analysis of Visitation Data
Visitation_by_month_gathered_ts <- ts(Visitation_by_month_gathered$Recreational_Visits, start = c(1999,1), frequency = 12)
# Generate the decomposition
Visitation_by_month_Decomposed <- stl(Visitation_by_month_gathered_ts, s.window = "periodic")
# Visualize the decomposed series. 
TSplotvisit <- plot(Visitation_by_month_Decomposed)
#mostly monotonic trend - visitation appears to be decreasing overall
# Run SMK test
Visitation_by_month_trend1 <- Kendall::SeasonalMannKendall(Visitation_by_month_gathered_ts)
#Answer: The seasonal Mann-Kendall test is the most appropriate because this ozone data has seasonality as seen in the decomposed time series plot and is non-parametric.
# Inspect results
Visitation_by_month_trend1
summary(Visitation_by_month_trend1)
#The p-value us less than 0.05, so we reject the null hypothesis that the data is stationary, therefore we have a trend over time. Visitation appears to be decreasing over time in Yosemite National Park. 
Visitation_by_month_trend2 <- trend::smk.test(Visitation_by_month_gathered_ts)
# Inspect results
Visitation_by_month_trend2
summary(Visitation_by_month_trend2)

# Modeling relationship between visitation and fire
library(corrplot)
yosecorr <- cor(yosefire[,c(1,3:6)])
corrplot <- corrplot(yosecorr,method = "number",insig = "label_sig",
         sig.level = c(.05))
#linear model
mod.lmfactor <- lm(data=yosefire, Visits ~ as.factor(Month) + Sumfire + Firecounts)
step(mod.lmfactor)
mod.lmfactorfin <- lm(data=yosefire, Visits ~ as.factor(Month) + Firecounts)
summary(mod.lmfactorfin)
par(mfrow=c(2,2))
plot(mod.lmfactorfin)
yosefire$fit <- mod.lmfactorfin$fitted.values
#plot model fit
modelplot <- ggplot() +
  geom_line(data = yosefire, aes(x = Date, y = fit, color="Fit")) +
  geom_line(data = yosefire, aes(x = Date, y = Visits, color = "Real")) +
  theme_bw() +
  ggtitle("Number of Visits through time") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Date") +
  ylab("Number of Visits")+
  scale_color_manual(name = "", values = c("Real" = "red", "Fit" = "blue"))
