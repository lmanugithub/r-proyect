# Coordinate system

#   coord_cartesian()

#coord_flip()
#coord_fixed()
#coord_map()
#coord_trans()

#   coord_polar()


p <- ggplot(mtcars, aes(x=mpg, y=hp)) +
  geom_point()+
  geom_smooth()
p
p + coord_cartesian()

# with scale se eliminan los datos fuera del rango
p + scale_x_continuous(limits = c(15,20))

# with coord
p + coord_cartesian(xlim = c(15,20)) + theme_minimal()

p + coord_cartesian(expand = T)

p + coord_cartesian(expand = F, clip = "off")

# coord_flip()
ggplot(diamonds, aes(x=carat)) +
  geom_histogram() + 
  coord_flip()


# coord_fixed()
# sets the aspect ratio of the plot y/x

x <- 1:10
y <- x
df <- data.frame(x,y)

ggplot(df, aes(x, y/10)) +
  geom_point() +
  coord_fixed(ratio = 10/1)


# coord_quickmap()
library(maps)
library(mapproj)
nz <- map_data("nz")
ggplot(nz, aes( x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()


# coord_polar()

ggplot(mpg, aes(x=displ)) +
  geom_bar() +
  coord_polar(theta = "x") #default

ggplot(mpg, aes(x=displ)) +
  geom_bar() +
  coord_polar(theta = "y") #default

# pie chart

ggplot(mpg, aes(x=1, fill=factor(cyl))) +
  geom_bar() +
  coord_polar(theta = "y") +
  theme_void()

# theme system

p <- ggplot(mtcars, aes(x=wt, y=mpg, color=factor(cyl))) + geom_point(size=3)
p

f <- p + facet_grid(cols = vars(factor(cyl)))
f

#plot + theme (element.name = element_function() )

# plot element
# axis element
# legend element
# panel element
# facet element

# text: element_text()
# lines: element_line()
# rectangles: element_rect()
# nothing: element_blanck()
# units: e.g. unit(1,"cm")
# margin: margin()

#plot() + theme(axis.title = element_text(color="red"))


# maps

usa.states <- map_data("state")
head(usa.states)
unique(usa.states$group)


# merging data USArrest

arrest <- USArrests
arrest$region <- tolower(rownames(USArrests))
head(arrest)
usa.crimes <- merge(usa.states, arrest, by="region")
head(usa.crimes)
usa.crimes <- usa.crimes[order(usa.crimes$order),]
head(usa.crimes)


library(viridis)
ggplot(data=usa.crimes, mapping = (aes(x=long, y=lat, group=group))) +
  geom_polygon(aes(fill=Assault)) +
  coord_quickmap() +
  theme_void() +
  scale_fill_viridis_c(option="E", name="Number of Assaults per 100.000 inh")+
  theme(legend.position="bottom")
  

# Annotated

state.center <- read.csv("state_centers_data.csv")

head(state.center)


ggplot(data=usa.crimes, mapping = (aes(x=long, y=lat))) +
  geom_polygon(aes(fill=Assault, group=group)) +
  geom_text(data = state.center, 
            aes(x=avg_long, y=avg_lat, label=state_initials),
            size=2.5, fontface="bold")+
  coord_quickmap() +
  theme_void() +
  scale_fill_viridis_c(name="Number of Assaults per 100.000 inh")+
  theme(legend.position="bottom")
  

## Bubble maps

state.center <- merge(state.center, arrest, by="region")
head(state.center)

ggplot(usa.crimes, aes(x=long, y=lat)) +
  geom_polygon(aes(group=group), 
               fill="NA", 
               color="gray",
               size=0.3) +
  geom_point(state.center, 
             mapping = aes(x=avg_long, 
                           y=avg_lat,
                           size=Assault,
                           color=Assault),
             alpha=0.5) +
  scale_color_continuous(limits = range(usa.crimes$Assault),
                         name = "Assault per 100.000 inh") +
  scale_size_continuous(limits = range(usa.crimes$Assault),
                        name = "Assault per 100.000 inh",
                        range = c(3,10)) +
  guides(color=guide_legend(), size=guide_legend()) +
  coord_quickmap() +
  theme_void() +
  theme(legend.position = "bottom")


## Dealing with GIS data

# install.packages("sf")
library(sf)

setwd("E:/ultimo back up/Proyectos_de_R/")

world <- read_sf("ne_50m_admin_0_countries/ne_50m_admin_0_countries.shp")

head(world)

cities <- read.csv("cities_to_visit.csv")
head(cities)

ggplot(world) +
  geom_sf(fill = "NA", color="grey", size = 0.2) +
  geom_point(data=cities, mapping = aes(x=lon, y=lat),
             color="indianred",
             size=2) +
  coord_sf() +
  theme_void()





