# Static transformations
# (stat) 

library(ggplot2)
library(dplyr)

ggplot(mpg, mapping = aes(x=cty, y=hwy)) +
  geom_point() +
  geom_line() +
  geom_smooth()

# every geometry has a default stat
ggplot(mpg, mapping = aes(x=cty, y=hwy)) +
  geom_point(stat = "smooth")


ggplot(mpg, mapping = aes(x=cty, y=hwy)) +
  geom_smooth(stat = "identity")

#and each stat has a default geom
# stat_smooth() dafault geom is geom_smooth()
# stat_count() dafault geom is geom_bar()
# stat_sum() dafault geom is geom_point()

ggplot(mpg, mapping = aes(x=cty, y=hwy)) +
  stat_smooth()

ggplot(mpg, mapping = aes(x=cty)) +
  stat_count()

ggplot(mpg, mapping = aes(x=cty, y=hwy)) +
  stat_sum()

# interesting stat

# stat_smooth(geom_smooth)

ggplot(data=mpg, mapping = aes(x=cty, y=hwy)) + 
  geom_point() + 
  geom_smooth()

# install nlme

library(nlme)
head(Oxboys)

ggplot(data=Oxboys, mapping = aes(x=age,y=height)) +
  geom_line(aes(group=Subject)) +
  geom_smooth(size=2)


#stat_unique()

ggplot(data = mpg, aes(x=class, y=hwy)) +
  geom_point(alpha=0.3)

ggplot(data = mpg, aes(x=class, y=hwy)) +
  stat_unique(alpha=0.3)

ggplot(data = mpg, aes(x=class, y=hwy)) +
  geom_point(alpha=0.3, stat = "unique")

# stat_sum(geom_poinrange)

ggplot(data = mpg, aes(x=class, y=hwy)) +
  stat_summary()

ggplot(data = mpg, aes(x=class, y=hwy)) +
  stat_summary(fun = mean)


ggplot(data = mpg, aes(x=class, y=hwy)) +
  geom_point(alpha=0.3, position="jitter") +
  stat_summary(fun = min, color = "red")


ggplot(data = mpg, aes(x=class, y=hwy)) +
  geom_point(alpha=0.3, position="jitter") +
  geom_point(stat="summary", fun = mean, color = "red", size=3)

#stat_count(geom_bar)
#stat_bin(geom_histogram)
#stat_density(geom_density)
#stat_boxplot(geom_boxplot)
#stat_ydensity(geom_violin)

#computed aesthetics 
## before ..name.. name of variable
## now: stat(name)

ggplot(data=mpg, mapping = aes(displ)) + 
  geom_histogram()

ggplot(data=mpg, mapping = aes(displ)) + 
  geom_histogram(aes(y=..count..))

ggplot(data=mpg, mapping = aes(displ)) + 
  geom_histogram(aes(y=stat(count/max(count))))

# Distribution
#Histograms & freq polygons

head(diamonds)

ggplot(diamonds, aes(x=price)) +
  geom_histogram()

ggplot(diamonds, aes(x=price)) +
  geom_bar(stat="bin")

ggplot(diamonds, aes(x=price)) +
  geom_histogram(binwidth = 50)

ggplot(diamonds, aes(x=price)) +
  geom_histogram(bins = 150)

ggplot(diamonds, aes(x=price)) +
  geom_freqpoly()

ggplot(diamonds, aes(x=price)) +
  stat_bin(geom = "line") +
  geom_freqpoly(color="red", alpha=0.5)


ggplot(diamonds, aes(x=price, fill=cut)) +
  geom_histogram(binwidth = 500)

ggplot(diamonds, aes(x=price, color=cut)) +
  geom_freqpoly(binwidth = 500)

# Density plots

ggplot(diamonds, aes(x=depth, color=cut)) +
  geom_density()


ggplot(diamonds, aes(x=depth, color=cut)) +
  geom_line(stat = "density")

ggplot(diamonds, aes(x=depth, color=cut, fill= cut)) +
  geom_density(alpha=0.4)


# geom area needs aesthetics
ggplot(diamonds, aes(x=depth, color=cut)) +
  geom_area()


# install.packages("ggridges")

library(ggridges)
ggplot(diamonds, aes(x=depth, fill=cut)) +
  geom_density_ridges(aes(y=cut),alpha=0.5)

##
ggplot(mpg, aes(x=displ)) + 
  geom_histogram(bins=10, fill="darkblue", alpha=0.5) + 
  geom_text(stat="bin", bins=10, 
            aes(label=..count.., y=stat(count)), 
            nudge_y = 2, color="darkblue", size=3) +
  scale_x_continuous(breaks=1:7)


# Boxplot

ggplot(mpg, aes(x=class, y=hwy)) + 
  geom_boxplot(varwidth = T, 
               aes(fill=class), 
               show.legend = F, 
               alpha=0.3, 
               outlier.alpha = 1) +
  scale_fill_viridis(discrete=T) +
  geom_point(position = "jitter", alpha=0.5)
  
  
#install.packages("forcats")
library(forcats)


ggplot(mpg, aes(y=fct_reorder(class, hwy, .fun = median, .desc = T), x=hwy)) + 
  geom_boxplot(varwidth = T, 
               aes(fill=class), 
               show.legend = F, 
               alpha=0.3, 
               outlier.alpha = 1) +
  scale_fill_viridis(discrete=T) +
  labs(y="Class")

ggplot(mpg, aes(y=fct_reorder(class, hwy, .fun = median, .desc = T), x=hwy)) + 
  geom_violin(
    aes(fill=class),
    trim=F, 
    scale = "count",
    show.legend = F,
    alpha=0.4, 
    color=NA
  ) +
  scale_fill_viridis(discrete = T)


# Boxplot Exercise

ggplot(mpg, aes(x=hwy, y=class)) + 
  geom_boxplot(aes(fill=class), 
               show.legend = FALSE,
               alpha=0.4,
               outlier.alpha = 1) +
  scale_fill_viridis(discrete = TRUE) +
  geom_point(stat = "summary", fun = "mean", shape=15)

ggplot(mpg, aes(x=hwy, y=class)) +
  geom_violin(aes(fill=class),
              show.legend = FALSE,
              alpha=0.4,
              color=NA) +
  scale_fill_viridis(discrete = TRUE) +
  geom_boxplot(fill=NA,
               width = 0.2)



