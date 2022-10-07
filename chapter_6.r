#get library
library(dplyr)
library(ggplot2)

# position to resolve overlaping
ggplot(data = mpg, aes(x=class, y=hwy) ) + 
  geom_point(position = position_identity()) # position="identity"

ggplot(data = mpg, aes(x=class, y=hwy) ) + 
  geom_point(position = position_jitter(seed = 123)) # position="jitter"

ggplot(data = mpg, aes(x=class, y=hwy, color=class) ) + 
  geom_point(show.legend = FALSE,
             position = position_jitter(width=0.4,
                                        height=0)) # position="jitter"
#nudge (pushing)

x <- 1:5
y <- x
lab <- LETTERS[x]
df <- data.frame(x,y,lab)

ggplot(data = df, mapping = aes(x = x, y = y)) +
  geom_point(size=4, color="lightblue") +
  geom_text(aes(label=lab),
            position = position_nudge(x=0.2,y=0.4))

ggplot(data = df, mapping = aes(x = x, y = y)) +
  geom_point(size=4, color="lightblue") +
  geom_text(aes(label=lab),
            nudge_y = 0.4)

# Position adjustment
#position_stack()
#position_fill()

ggplot(mtcars, aes(factor(cyl), fill=factor(vs))) +
  geom_bar(alpha=0.5, position = position_fill(reverse = T))

q <- ggplot(mtcars, aes(mpg, group=cyl, fill=cyl))
q + geom_density(alpha=0.5)
q + geom_density(alpha=0.5, position = "fill")

q2 <- ggplot(mtcars, aes(factor(cyl), fill=factor(vs)))
q2 + geom_bar(alpha=0.5, position = "dodge")

q2 + geom_bar(alpha=0.5, 
              position = position_dodge2(preserve="single",
                                         padding = 0.4,
                                         reverse = T))

#scales

ggplot(data=mtcars, mapping = aes(x=mpg, y=wt, color=cyl)) +
  geom_point() + theme_dark() +
  scale_x_continuous()+
  scale_y_continuous()+
  scale_color_continuous()

ggplot(data=mtcars, mapping = aes(x=mpg, y=wt, color=cyl)) +
  geom_point() + theme_classic() +
  scale_x_continuous()+
  scale_y_continuous()+
  scale_color_continuous(name="Number of \nCylinders")

ggplot(data=mtcars, mapping = aes(x=mpg, y=wt, color=cyl)) +
  geom_point() + theme_classic() +
  scale_x_continuous()+
  scale_y_continuous()+
  scale_color_binned()

## scale position 
ggplot(mtcars, aes(x=mpg, y=wt)) + geom_point(size=3) +
  scale_x_continuous(name="Miles per gallon", 
                     breaks = c(10,20,30))

ggplot(mtcars, aes(x=mpg, y=wt)) + geom_point(size=3) +
  scale_x_continuous(name="Miles per gallon", 
                     n.breaks = 5)

ggplot(mtcars, aes(x=mpg, y=wt)) + geom_point(size=3) +
  scale_x_continuous(name="Miles per gallon", 
                     n.breaks = 6,
                     labels = LETTERS[1:6])

ggplot(mtcars, aes(x=mpg, y=wt)) + geom_point(size=3) +
  scale_x_continuous(name="Miles per gallon", 
                     limits = c(15,30))  

ggplot(mtcars, aes(x=mpg, y=wt)) + geom_point(size=3) +
  scale_x_continuous(name="Miles per gallon", 
                     trans = "log10") # or reverse

ggplot(mtcars, aes(x=mpg, y=wt)) + geom_point(size=3) +
  scale_x_continuous(name="Miles per gallon", 
                     position =  "top")

ggplot(mtcars, aes(x=mpg, y=wt)) + geom_point(size=3) +
  scale_x_binned(nice.breaks = T)

### discrete
q <- ggplot(data=mpg, aes(x=class, y=hwy)) + geom_point()
q
q + scale_x_discrete(breaks = c("compact", "midsize","subcompact"))
q + scale_x_discrete(limits = c("compact", "subcompact"))
q + scale_x_discrete(name="Class of cars", labels=abbreviate)

## scale date
Sys.Date()
x <- Sys.Date()-1:90
x
y <- runif(length(x))

dfd <- data.frame(x,y)
dfd

d <- ggplot(data = dfd, aes(x,y)) + geom_line()
d + scale_x_date(name = "Date")

myBreaks <- seq(min(dfd$x), max(dfd$x), by=20)
myBreaks

d + scale_x_date(breaks = myBreaks)
d + scale_x_date(date_breaks = "months")
#strftime
d + scale_x_date(date_labels = "%b-%d")


## scale_._manual

ggplot(mtcars, aes(x=mpg, y=wt, color=factor(cyl))) +
  geom_point(size=3)+
  scale_color_manual(values = c("pink", "violet", "midnightblue"))

ggplot(mtcars, aes(x=mpg, y=wt, shape=factor(cyl))) +
  geom_point(size=3)+
  scale_shape_manual(values = c(23,7,8))

## identity scales
a <- seq(1,6)
set.seed(123)
b <- runif(length(a))
set.seed(123)
col <- sample(colors(), length(a))
dfa <- data.frame(a,b,col)

ggplot(data=dfa, aes(x=a, y=b,color=col))+ 
  geom_point(size=4)+
  scale_color_identity(guide="legend")

#shortcuts
# xlab, ylab or labs (title,x,y,subtitle,caption,tag)

ggplot(mtcars, aes(x=mpg,y=wt)) +
  geom_point() +
  labs(x="Milles per gallon",
       y="Weight",
       title="Title of plot",
       subtitle = "This would be a subtitle",
       caption = "This a caption",
       tag = "a)")
# xlim, ylim, lims
ggplot(mtcars, aes(x=mpg,y=wt)) +
  geom_point() +
  labs(x="Milles per gallon",
       y="Weight",
       title="Title of plot",
       subtitle = "This would be a subtitle",
       caption = "This a caption",
       tag = "a)") +
  lims(x=c(10,25), y=c(2,5))


### Practice bar plot
# geom_histogram() stat_bin()
# geom_bar() stat_count() categorical

diam <- diamonds[1:100,]
head(diam)

ggplot(diam, aes(x=depth)) +
  geom_histogram()

ggplot(diam, aes(x=depth)) +
  geom_bar()

ggplot(diam, aes(x=cut)) +
  geom_bar()

# geom_col() stat="identity"
# stacked grouped filled or small multiples

ggplot(diam, aes(x=cut, fill=clarity)) +
  geom_bar(position = "stack")

ggplot(diam, aes(x=cut, fill=clarity)) +
  geom_bar(position = "fill")

ggplot(diam, aes(x=cut, fill=clarity)) +
  geom_bar(position = "dodge")

ggplot(diam, aes(x=cut, fill=clarity)) +
  geom_bar(position = position_dodge(preserve = "single"))

ggplot(diam, aes(x=cut, fill=clarity)) +
  geom_bar() + facet_wrap(vars(clarity))

## 

il <- filter(midwest, state=="IL", poptotal > 100000 & poptotal <500000)
il

first<-ggplot(data = il, mapping = aes(x=county, y=poptotal, fill=poptotal)) +
  geom_col()

# flip
ggplot(data = il, mapping = aes(y=county, x=poptotal, fill=poptotal)) +
  geom_col()

# order by value
library(forcats)

# turn into factor
il$county <- factor(il$county)
# re-order
il$county <- fct_reorder(il$county, il$poptotal)

ggplot(data = il, mapping = aes(y=county, x=poptotal, fill=poptotal)) +
  geom_col()

# palette 
library(viridis)

ggplot(data = il, mapping = aes(y=county, x=poptotal, fill=poptotal)) +
  geom_col(width = 0.8) +
  scale_fill_viridis_b(option="E", direction = -1)


## Final exercise

candidates <- c("Biden", "Trump")
results <- c(306,232)
election <-  c("2020 Election", "2020 Election")
df_election <- data.frame(candidates, results, election)

## solution

#vectors of colors
UScolors <- c("Biden"="midnightblue", "Trump"="firebrick")

ggplot(data = df_election, aes(y=election, x=results, fill= candidates)) +
  geom_col(position = position_fill(reverse = T), width = 0.1) +
  scale_fill_manual(values = UScolors, guide=NULL) +
  geom_segment(aes(x=0.50, xend=0.50, y=1-0.1, yend=1+0.1)) +
  theme_void()




