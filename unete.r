# Static transformations
# (stat) 

library(ggplot2)
library(dplyr)

library(viridis)


sueldos <- read.csv("Nomina_csv.csv")

ggplot(data = sueldos, mapping = aes(x=sueldo, color = Clase)) +
  geom_freqpoly()

library(ggridges)
ggplot(sueldos, aes(x=sueldo, fill=Clase)) +
  geom_density_ridges(aes(y=Clase),alpha=0.5)

ggplot(sueldos, aes(x=sueldo, color=Clase, fill= Clase)) +
  geom_density(alpha=0.4) +
  scale_x_continuous(n.breaks = 7)


ggplot(sueldos, aes(y=Clase, x=sueldo)) + 
  geom_boxplot(varwidth = T, 
               aes(fill=Clase), 
               show.legend = F,
               alpha=0.4,
               outlier.alpha = 1) +
  scale_fill_viridis(discrete=T) +
  geom_point(position = "nudge", alpha=0.5)+
  scale_x_continuous(n.breaks = 7)



ggplot(sueldos, aes(y=Clase, x=sueldo)) +
  geom_violin(aes(fill=Clase),
              trim=F, 
              scale = "count",
              show.legend = F,
              alpha=0.4, 
              color=NA) 


ggplot(data = sueldos, mapping = aes(x=Clase)) +
  geom_bar(aes(x=Clase, y=sueldo), stat = "summary", fun = sum)

head(sueldos)

## top bar plot
df_sueldos <- filter(sueldos, Clase %in% c("Oficina","Oficina-proyecto","Director"))


## bar plot
ggplot(data = df_sueldos, aes(y=Nombre_Receptor, x=sueldo, fill=sueldo)) +
   geom_col()

# reorder 
library(forcats)

df_sueldos$Nombre_Receptor <- fct_reorder(df_sueldos$Nombre_Receptor, df_sueldos$sueldo) 

ggplot(data = df_sueldos, aes(y=Nombre_Receptor, x=sueldo, fill=sueldo)) +
  geom_col()

# palette 
library(viridis)

ggplot(data = df_sueldos, aes(y=Nombre_Receptor, x=sueldo, fill=sueldo)) +
  geom_col(width = 0.7) + 
  scale_fill_viridis_b(name = "sueldo \nmensual", 
                       n.breaks=6) + 
  scale_x_continuous(n.breaks = 7,
                     name = "Importe mensual") +
  scale_y_discrete(name = "") +
  ggtitle("Ranking de sueldos en UNETE")

# Bar filter
ggplot(df_sueldos, aes(x=sueldo, color=Clase, fill= Clase)) +
  geom_bar(aes(y=Nombre_Receptor, x=sueldo, color=Clase, fill= Clase),
           width = 0.7,
           alpha=0.4,
           position = position_dodge(preserve = "single"),
           stat = "summary", fun = sum) +
  scale_x_continuous(n.breaks = 7,
                     name = "Importe mensual") +
  scale_y_discrete(name = "")+
  ggtitle("Ranking de sueldos en UNETE por clase")

# density filter
ggplot(df_sueldos, aes(x=sueldo, color=Clase, fill= Clase)) +
  geom_density(alpha=0.4) +
  scale_x_continuous(n.breaks = 7) +
  ggtitle("Distribución de sueldo UNETE")
  
  
