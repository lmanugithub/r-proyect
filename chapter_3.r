install.packages("babynames")
library(dplyr)
library(ggplot2)
library(babynames)

Estefania <- filter(babynames, name=="Stephania")

anna <- filter(babynames, name=="Anna", sex=="F")

theme_set(theme_minimal())

ggplot(Estefania, aes(x=year, y=n)) + geom_line()
ggplot(filter(babynames, name=="Stephie"), aes(x=year, y=n)) + geom_line()
ggplot(anna, aes(x=year, y=n)) + geom_line()
install.packages("viridis")
library(viridis)

baby <- filter(babynames, name %in% c("Anna", "Emma",  "Clara", "Stephania"), sex=="F")

ggplot(baby, aes(x=year, y=n)) + geom_line()

ggplot(baby, aes(x=year, y=n, group=name)) + geom_line()

ggplot(baby, aes(x = year, y = n, group = name, color = name)) + 
  geom_line() + 
  scale_color_viridis(discrete = TRUE)



#ejercicio
baby2 <- filter(babynames, name %in% c("Jessica", "Natalie", "Saray"), sex=="F")

baby2 <- filter(baby2, year>1980 & year<max(baby2$year))
       
ggplot(baby2, aes(x=year, y=n, group=name, color=name)) + 
  geom_line(linetype="dashed") + 
  scale_color_viridis(discrete = TRUE) +
  geom_point(size=3, alpha=0.5)
       
       