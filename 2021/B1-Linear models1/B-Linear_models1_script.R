library(knitr)
#work
setwd("H:/Work/Teaching-Undergrad/Data analysis for life and earth sciences  2041/Practicals-new/B1-Linear models1")
#home
setwd("C:/Documents and Settings/A&L/Desktop/Current work/Practicals-new/B1-Linear models1")


# 1 Size of pest populations vs temperature

Bug.pop = read.csv(file = "InsectPopTemp.csv", header = TRUE)  

popA.lm = lm(Popna ~ Tempa, data = Bug.pop)
summary(popA.lm)
confint(popA.lm)

#Residual SS
sum(summary(popA.lm)$residuals^2)
#Regression SS
sum((predict(popA.lm) - mean(Bug.pop$Popna))^2) 
# Total SS
sum(summary(popA.lm)$residuals^2) + sum((predict(popA.lm) - mean(Bug.pop$Popna))^2) 


popB.lm = lm(Popnb ~ Tempb, data = Bug.pop, na.action='na.omit')
summary(popB.lm)
sum(summary(popB.lm)$residuals^2)
sum((predict(popB.lm) - mean(Bug.pop$Popnb))^2) 
sum(summary(popB.lm)$residuals^2) + sum((predict(popB.lm) - mean(Bug.pop$Popnb))^2) 


popC.lm = lm(Popnc ~ Tempc, data = Bug.pop)
summary(popC.lm)
sum(summary(popC.lm)$residuals^2)
sum((predict(popC.lm) - mean(Bug.pop$Popnc))^2) 
sum(summary(popC.lm)$residuals^2) + sum((predict(popC.lm) - mean(Bug.pop$Popnc))^2) 

popD.lm = lm(Popnd ~ Tempd, data = Bug.pop)
summary(popD.lm)
sum(summary(popD.lm)$residuals^2)
sum((predict(popD.lm) - mean(Bug.pop$Popnd))^2) 
sum(summary(popD.lm)$residuals^2) + sum((predict(popD.lm) - mean(Bug.pop$Popnd))^2) 



popC.lm = lm(Popnc ~ Tempc, data = Bug.pop)
summary(popC.lm)

popD.lm = lm(Popnd ~ Tempd, data = Bug.pop)
summary(popD.lm)




# 2 Freestyle swimming records

# Import the data
Swim.records = read.csv(file = "Swim.records.csv", header = TRUE)

# Plot time vs year
plot(Time~Year,data = Swim.records)

# Run a linear model with time as Y variable, year as X
swim.lm = lm(Time~Year, data = Swim.records)

# 
summary(swim.lm)

predict(swim.lm,list(Year=2016))

abline(swim.lm)




# 3) Life expectancy vs. infant mortality rate
library(ggplot2)

UN.pop = read.csv(file = "Unpopstats.csv", header = TRUE)

UN.pop = read.csv(file = "UNpopstats.csv", header = TRUE)  
ggplot(UN.pop, aes(y = LifeExp, x = InfMort)) + geom_point(aes(colour = as.factor(Gender))) + 
  ylab("Life expectancy at birth (yrs)") + xlab("Infant mortality rate") +
  geom_smooth(size = 0.5, method = "lm", alpha = 0.3, colour = "black", aes(group = Gender)) +
  theme(legend.title=element_blank()) + 
  scale_colour_discrete(name="Gender", breaks=c(1, 0), labels=c("Male","Female"))
```

UN.pop.female = subset(UN.pop, Gender == "female")
UN.pop.male = subset(UN.pop, Gender == "male")

Female.lm = lm(LifeExp ~ InfMort, data = UN.pop.female)
summary(Female.lm)
Male.lm = lm(LifeExp ~ InfMort, data = UN.pop.male)
summary(Male.lm)


# Boiling point vs air pressure

Hooker = read.csv(file = "Hooker.csv", header = TRUE)
plot(Temp ~ Press, data = Hooker) 
Hooker.lm = lm(Temp ~ Press, data = Hooker)
plot(Hooker.lm)

Hooker$logTemp = log10(Hooker$Temp)
Hooker$logPress = log10(Hooker$Press)
Hooker.lmLOG = lm(logTemp ~ logPress, data = Hooker)
plot(Hooker.lmLOG)
summary(Hooker.lmLOG)


# 5) Growth rates vs. individual size

Growth = read.csv(file = "GrowthRate.csv", header = TRUE)
plot(GrowthRate ~ BodyWt, data = Growth)
growth.lm = lm(GrowthRate ~ BodyWt, data = Growth)
summary(growth.lm)
plot(growth.lm)

Growth$logBodyWt = log10(Growth$BodyWt)
growth.lmLOG = lm(GrowthRate ~ logBodyWt, data = Growth)
summary(growth.lmLOG)
plot(growth.lmLOG)


Growth$logGrowthRate = log10(Growth$GrowthRate)
growth.lmLOGLOG = lm(logGrowthRate ~ logBodyWt, data = Growth)
summary(growth.lmLOGLOG)
plot(growth.lmLOGLOG)


# 6) Brain weight vs. body size  

Brain = read.csv(file = "Brain.csv", header = TRUE)
plot(BrainWt ~ BodyWt, data = Brain)
brain.lm = lm(log(BrainWt)~log(BodyWt),data=Brain)
summary(brain.lm)
plot(brain.lm)

