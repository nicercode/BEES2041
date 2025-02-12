#work
setwd("H:/Work/Teaching-Undergrad/Data analysis for life and earth sciences  2041/Practicals-new/B3-Linear models3")
#home
setwd("C:/Documents and Settings/A&L/Desktop/Current work/Practicals-new/B2-Linear models2")


# 9) Gastropod abundance vs. height on the shore and species

Gastropods = read.csv(file = "MaroubraZones.csv", header = TRUE)
Gastropods$Zone = factor(Gastropods$Zone, levels = c("Low", "Mid", "High"))

boxplot(Abundance ~ Zone*Species,data = Gastropods, names = c("A.low", "A.mid", "A.high", "C.low", "C.mid", "C.high", "N.low", "N.mid", "N.high"))

Gastropods.ANOVA = aov(Abundance ~ Zone*Species, data = Gastropods)

hist(Gastropods.ANOVA$residuals)
plot(Gastropods.ANOVA)
summary(Gastropods.ANOVA)

Gastropods$LogAbundance = log(Gastropods$Abundance + 1)
Gastropods.logANOVA = aov(LogAbundance ~ Zone*Species, data = Gastropods)

hist(Gastropods.logANOVA$residuals)
summary(Gastropods.logANOVA)

interaction.plot(Gastropods$Zone,Gastropods$Species,Gastropods$Abundance)

TukeyHSD(Gastropods.ANOVA)



library(dplyr)
library(ggplot2)


Gastropods_summary <- Gastropods %>% 
  group_by(Species, Zone) %>% 
    summarise(mean_Abundance = mean(Abundance),
            sd_Abundance = sd(Abundance),
            SE_Abundance = sd(Abundance)/sqrt(n()))

ggplot(Gastropods_summary , aes(Zone, mean_Abundance, fill=Species)) +
  geom_col(position = position_dodge()) +
  geom_errorbar(aes(ymin = mean_Abundance - SE_Abundance,
                    ymax = mean_Abundance + SE_Abundance),
                width=0.2,position = position_dodge(0.9))



#Balanced and unbalanced designs
library(car)
Gastropods.ANOVA = aov(Abundance ~ Zone*Species, data = Gastropods)
Anova(Gastropods.ANOVA, type=c("III"))


# 10) Effects of predator removal

Mink = read.csv(file = "Mink.csv", header = TRUE)

Mink.nested = aov(Voles ~ Treatment + Error(Area), data = Mink)
summary(Mink.nested)

minkSum = summary(Mink.nested)
FixedEff = (unlist(minkSum[[1]])[[5]] - unlist(minkSum[[1]])[[6]])/((length(Mink$Treatment)/length(unique(Mink$Area)))*(length(unique(Mink$Area))/length(unique(Mink$Treatment))))
FixedEff

RandEff = (unlist(minkSum[[1]])[[6]] - unlist(minkSum[[2]])[[3]])/(length(Mink$Treatment)/length(unique(Mink$Area)))
RandEff

WithinErr = unlist(minkSum[[2]])[[3]]
WithinErr

cat("Treatment:" ,(FixedEff/(FixedEff + RandEff + WithinErr))*100, "%")
cat("Area:", (RandEff/(FixedEff + RandEff + WithinErr))*100, "%")
cat("Error:", (WithinErr/(FixedEff + RandEff + WithinErr))*100, "%")


# 11) Gastropod abundance vs species and proximity to rockpools


plot(Abundance~Distance, data= Gastropods, col=c("red","blue","green")[Species])
Austrocochlea = subset(Gastropods, Species == "Austrocochlea")
Cellana = subset(Gastropods, Species == "Cellana")
Nerita = subset(Gastropods, Species == "Nerita")
abline(lm(Abundance~Distance, data = Austrocochlea), col = "red")
abline(lm(Abundance~Distance, data = Cellana), col = "blue")
abline(lm(Abundance~Distance, data = Nerita), col = "green")

Gastropods.ANCOVA = lm(Abundance ~ Species*Distance, data = Gastropods)
summary(Gastropods.ANCOVA)
anova(Gastropods.ANCOVA)

# 12) Life expectancy vs. infant mortality rate

UN.pop = read.csv(file = "Unpopstats.csv", header = TRUE)
Un.pop.ANCOVA = lm(LifeExp ~ InfMort*Gender, data = UN.pop)
summary(Un.pop.ANCOVA)
anova(Un.pop.ANCOVA)
plot(Un.pop.ANCOVA)

