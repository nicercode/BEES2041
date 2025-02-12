#work
setwd("H:/Work/Teaching-Undergrad/Data analysis for life and earth sciences  2041/Practicals-new/B2-Linear models2")
#home
setwd("C:/Documents and Settings/A&L/Desktop/Current work/Practicals-new/B2-Linear models2")

# 7 Turtle hatching times vs temperature

Turtles = read.csv(file = "Turtles.csv", header = TRUE)
Turtles$Temperature = factor(Turtles$Temperature)
Turtles.ANOVA = aov(Days ~ Temperature, data = Turtles)
summary(Turtles.ANOVA)
hist(Turtles.ANOVA$residuals)
plot(Turtles.ANOVA)
boxplot(Days~Temperature, data = Turtles)


#8) Gastropod abundance vs. height on the shore

Gastropods = read.csv(file = "MaroubraZones.csv", header = TRUE)


#Count how many rows in each species x zone combination

table(Gastropods$Zone, Gastropods$Species)

# Reorder levels of Zone

Gastropods$Zone = factor(Gastropods$Zone, levels = c("Low", "Mid", "High"))

Austrocochlea = subset(Gastropods, Species == "Austrocochlea")
Cellana = subset(Gastropods, Species == "Cellana")
Nerita = subset(Gastropods, Species == "Nerita")

boxplot(Abundance~Zone, data = Cellana)
boxplot(Abundance~Zone, data = Austrocochlea)
boxplot(Abundance~Zone, data = Nerita)

Nerita.means = tapply(Nerita$Abundance, Nerita$Zone, mean)
barplot(Nerita.means)

library(gplots)
Nerita.ci.low = tapply(Nerita$Abundance, Nerita$Zone, function(x) t.test(x)$conf.int[1])
Nerita.ci.up = tapply(Nerita$Abundance, Nerita$Zone, function(x) t.test(x)$conf.int[2])

barplot2(Nerita.means, plot.ci = TRUE, ci.l = Nerita.ci.low, ci.u = Nerita.ci.up, ylab = "Abundance (Nerita)")


Austro.mean = tapply(Austrocochlea$Abundance, Austrocochlea$Zone, mean)
Austro.ci.low = tapply(Austrocochlea$Abundance, Austrocochlea$Zone, function(x) t.test(x)$conf.int[1])
Austro.ci.up = tapply(Austrocochlea$Abundance, Austrocochlea$Zone, function(x) t.test(x)$conf.int[2])
barplot2(Austro.mean, plot.ci = TRUE, ci.l = Austro.ci.low, ci.u = Austro.ci.up, ylab = "Abundance (Austrocochlea)")

Cellana.mean = tapply(Cellana$Abundance, Cellana$Zone, mean)
Cellana.ci.low = tapply(Cellana$Abundance, Cellana$Zone, function(x) t.test(x)$conf.int[1])
Cellana.ci.up = tapply(Cellana$Abundance, Cellana$Zone, function(x) t.test(x)$conf.int[2])
barplot2(Cellana.mean, plot.ci = TRUE, ci.l = Cellana.ci.low, ci.u = Cellana.ci.up, ylab = "Abundance (Cellana)")


Nerita.ANOVA = aov(Abundance ~ Zone, data = Nerita)

hist(Nerita.ANOVA$residuals)

plot(Nerita.ANOVA)

summary(Nerita.ANOVA)

TukeyHSD(Nerita.ANOVA)

Cellana.ANOVA = aov(Abundance ~ Zone, data = Cellana)
plot(Cellana.ANOVA)
summary(Cellana.ANOVA)
TukeyHSD(Cellana.ANOVA)

Austrocochlea.ANOVA = aov(Abundance ~ Zone, data = Austrocochlea)
summary(Austrocochlea.ANOVA)
TukeyHSD(Austrocochlea.ANOVA)

