# Facet

# facet_wrap()

# get library
library(dplyr)
library(ggplot2)
library(maps)
library(mapproj)
library(forcats)
setwd("E:/ultimo back up/Proyectos_de_R/")

p <- ggplot(mtcars, mapping = aes(x=mpg, y=hp, color=factor(cyl))) +
  geom_point(size=3)
p

p + facet_wrap(vars(cyl))

# vars(a,b) or a ~ b row ans columns
p + facet_wrap(vars(cyl, am))

# nrow, ncol

# dir
p + facet_wrap(vars(cyl, am), dir = "v")

## scales

p + facet_wrap(vars(cyl, am), scale="fixed")

p + facet_wrap(vars(cyl, am), scale="free_y")
p + facet_wrap(vars(cyl, am), scale="free_x")
p + facet_wrap(vars(cyl, am), scale="free")


## strip.position

p + facet_wrap(vars(cyl, am), strip.position = "right") + 
  theme(strip.text.y = element_text(angle=0))


# facet_grid
## cols=vars(a), rows=vars(b)
## Or the classical form: a~b

p

p + facet_grid(cyl~.)
p + facet_grid(.~cyl)

p + facet_grid(vs~cyl)

## scales
p + facet_grid(vs~cyl, scale="free")


# - - - - -  Example - - - - - 
head(iris)

ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point(aes(color=Species))

ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point(aes(color=Species))+ 
  facet_wrap(vars(Species))

## new dataset without "Species"

iris2 <- iris[-5]
head(iris2)

ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point(data=iris2, color="grey") +
  geom_point(aes(color=Species)) + 
  facet_wrap(vars(Species)) +
  theme(strip.background = element_rect(fill="grey40", color = "NA"),
        strip.text = element_text(color = "white"))


# - - - - - 
map <- map_data("state")

USColor <- c("DEMOCRAT" = "darkblue",
              "REPUBLICAN" = "firebrick")
 
 
## load data
elec <- read.csv("US_Election_1976-2020.csv")
head(elec) 

## merge

electionmap <- merge(map, elec, by.x = "region", by.y = "state_low")
head(electionmap)


ggplot(electionmap, aes(x=long, y=lat)) +
  geom_polygon(aes(group=group, fill=party_simplified), alpha=0.85) +
  scale_fill_manual(values = USColor, name="", labels=c("Democrat", "Republican")) +
  coord_quickmap() +
  facet_wrap(vars(year)) + 
  theme_void() +
  labs(title = "US Presidential Elections 1976-2020") +
  theme(legend.position = "top",
        plot.title = element_text(size=15, 
                                  face = "bold", 
                                  hjust = 0.5,
                                  margin = margin(b=20,t=10)),
        strip.text = element_text(size = 10, 
                                  face = "bold"))

# - - - - - - -  lollipop plot

election <- read.csv("election2019.csv", stringsAsFactors = TRUE)
head(election)

## reorder
library(forcats)
election$CANDIDATES.2019 <- fct_reorder(election$CANDIDATES.2019, 
                                        election$SEATS.2019)

myColor="#3C3B53"

 
ggplot(data = election, aes(x=SEATS.2019, y=CANDIDATES.2019)) +
  geom_point(size = 6, color = myColor) +
  geom_segment(aes(x=0,
                   xend=SEATS.2019,
                   y=CANDIDATES.2019,
                   yend=CANDIDATES.2019), 
               color= myColor,
               size=1) +
  geom_text(aes(label=SEATS.2019),
            color="white",
            size=2.5) +
  scale_y_discrete(name="") +
  scale_x_continuous(name="Number of seats obtained", position = "bottom") +
  labs(title = "Results of the 2019 election :)", 
       caption = "Source of the data") +
  theme_minimal(base_family = "PT Sans",
                base_size = 9) +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major.y = element_blank(),
        plot.title = element_text(face = "bold",
                                  size = 12,
                                  hjust = 0.95),
        axis.text.y = element_text(face = "bold"))
 

# - - - - - - - - - Dumbbell
presidential

pres <- presidential

pres[8,]$name <- "Bush Sr." 
pres[10,]$name <- "Bush Jr." 

pres
theme_set(theme_minimal())

## reorder

pres$name <- fct_reorder(pres$name, pres$start, .desc = TRUE)

presidential.colors <- c("Republican"="firebrick4","Democratic"="dodgerblue4")

presidential.colors

ggplot(pres, aes(y=name, color=party)) +
  geom_point(aes(x=start)) +
  geom_point(aes(x=end)) +
  geom_segment(aes(x=start, xend=end, y=name, yend=name)) +
  scale_color_manual(values=presidential.colors, guide="none") +
  geom_text(aes(label=name, x=start), size=3, nudge_y = 0.35, hjust=0) +
  scale_x_date(date_breaks = "4 years", date_labels = "%Y") +
  labs(title = "Presidentes of the United States of America 1953-2017") +
  theme_minimal(base_family = "PT Sans") +
  theme(axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_line(size = 0.25),
        plot.title = element_text(hjust = 0.5))
  
  
  
# - - - - - - - - fire  

# We'll use diamonds dataset instead
diam <- sample_n(diamonds,2500)

# Colors
low_yellow <- "#F9CE19"
mid_orange <- "#F47C2A"	 
high_red   <- "#EF3733"
background_color <- "#3F2737"
font_color <- "#99766E"


p <- ggplot(diam, aes(x=cut, y=price)) + 
  geom_point(aes(color=price),
             position=position_jitter(width=0.15), 
             alpha=0.3, shape=16, size=3) +
  scale_color_gradientn(colors=c(low_yellow,
                                 mid_orange, 
                                 high_red), 
                        values=c(0,0.05,0.15, 1), 
                        guide="none")	

# Modify theme
fireplot <- p + 
  theme_minimal() + 
  theme(plot.background = element_rect(fill=background_color),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text =element_text(color=font_color, size=8),
        panel.grid.major.y = element_line(color=alpha("black",0.1)))

print(fireplot)
  
