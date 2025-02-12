setwd("H:/Work/Teaching-Undergrad/Data analysis for life and earth sciences  2041/Practicals-new/F-Experimental design")

# 4) are men wimps

men = 84.3
women = 100.4
men.var = 50
women.var = 60

mean.diff = women - men

SEx = sqrt(men.var/3+women.var/3)
t = mean.diff/SEx

P = pt(t, df = 4, lower.tail=FALSE)*2
P



# 5) Does bush regeneration work?

Bush_regen <- read.csv("Bush_regen.csv", header = TRUE)
t.test(Species~Time, data=Bush_regen,paired = TRUE)


# 6 Can beer deter slugs


Slugs <- read.csv("Slugs.csv", header = TRUE)
slugs.ANOVA = aov(Slugs~Product*Duration, data = Slugs)
summary(slugs.ANOVA)
plot(slugs.ANOVA)
