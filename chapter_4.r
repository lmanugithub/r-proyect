
library(ggplot2)
library(dplyr)

ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point(aes(color=hwy), size=2)
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point(color="darkblue", size=2)


ggplot(data=mpg, aes(x=displ, y=hwy), color="darkblue") + geom_point()

# wide format data
d <- read.csv("longWidedata.csv")

ggplot(data=d, aes(x=Year, color = Town)) +
  geom_line(aes(y=Males)) + geom_line(aes(y=Females), linetype="dashed") +
  geom_point(aes(y=Males)) + geom_point(aes(y=Females))

# Melt data

# install.packages("reshape2")
library(reshape2)

melt(data = d, id.vars = c("Town", "Year"), 
     variable.name = "variable", value.name = "value") -> new_d

ggplot(new_d, 
       aes(x = Year, 
           y = value, 
           group = interaction(variable,Town), 
           color = Town,
           linetype = variable)) +  
         geom_line() +  geom_point()

# Practice
# scatter plot
theme_set(theme_minimal())

starwars

humans <- filter(starwars, species=="Human")
humans
is.na(humans$mass)
humans <- humans[!is.na(humans$mass),]

ggplot(humans, aes(x=mass, y=height)) + 
  geom_point(size=4, alpha=0.4, position="jitter")

# body mass index of the humans

humans <- mutate(humans, BMI = mass / (height/100)^2)
humans  

ggplot(humans, aes(x=mass, y=height)) + 
  geom_point(aes(color=BMI), size=4, position="jitter") +
  scale_color_gradient(low="blue", high="orange")

ggplot(humans, aes(x=mass, y=height)) + 
  geom_point(aes(color=BMI), size=4, position="jitter") +
  scale_color_gradient2(low="blue", mid="violet", midpoint=25, high="orange")

ggplot(humans, aes(x=mass, y=height)) + 
  geom_point(aes(color=BMI), size=4, position="jitter") +
  scale_color_gradientn(colors = cm.colors(3))

mypalette = c("royalblue", "forestgreen", "gold", "darkorange", "firebrick")

# transform our data from continuos to discrete

humans$BMI_categories <- cut(humans$BMI, breaks = c(0, 18.5, 25, 30, 35, Inf),
                             labels = c("Underweight","Normal", "Overweight","Obese","Extremly obese"),
                             right = FALSE)
humans$BMI_categories

ggplot(humans, aes(x=mass, y=height)) + 
  geom_point(aes(color=BMI_categories), size = 4) +
  scale_color_manual(values = mypalette, name = "BMI")

ggplot(humans, aes(x=mass, y=height)) + 
  geom_point(aes(color=BMI_categories), size = 8, alpha=0.5) +
  scale_color_manual(values = mypalette, name = "BMI") +
  geom_text(aes(label=name))
  
library(ggrepel)

ggplot(humans, aes(x=mass, y=height)) + 
  geom_point(aes(color=BMI_categories), size = 8, alpha=0.5) +
  scale_color_manual(values = mypalette, name = "BMI") +
  geom_text_repel(aes(label=name))


# ejercicio
class_info <- summarise(group_by(mpg, class), n=n(), hwy=mean(hwy))


ggplot(data=mpg, mapping = aes(x=class, y=hwy, color = class)) + 
  geom_point(position = "jitter", alpha=0.4) +
  geom_point(data = class_info, size=4) +
  geom_text(data = class_info, aes(label = paste0("n=",n), y = 5, color = NULL))+
  labs("title"="Fuel consumption per class of vehicle",
       x = "Class of vehicle",
       y = "Highway fuel consumption")

