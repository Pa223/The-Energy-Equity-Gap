library(readstata13)
library(tidyverse)
library(ggpubr)
library(plyr)
library(gapminder)
library(gridExtra)
library(xlsx)
        

        
## first construct csv with median inflection temperatures of each income group for each year


income_median <- read.csv("income_median.csv")
income_median_plot <- ggplot(income_median, aes(x = year, y = inf_temp, group = Income, color = Income))+
  geom_point(aes(shape = Income), size = 4)+
  geom_line(size = 1.5)+
  scale_y_continuous(limits = c(50,70), breaks = seq(50,72.5,2.5))+
  xlab("Year")+
  ylab(expression(paste("Inflection Temperature (",degree,"F)")))+
  labs(color = "Income Group", linetype = "Income Group", shape = "Income Group")+
  scale_color_manual(values = c("#009E73", "#E69F00", "#CC79A7", "#999999", "#2D2926", "#0072B2", "#D55E00", "#56B4E9"))+
  scale_shape_manual(values = c(15, 16, 17, 18, 0, 1, 2, 3))+
  theme_bw(base_family = "Lato")+
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    axis.title.x = element_text(size = 20, margin = margin(t = 15)),
    axis.title.y = element_text(size = 20, margin = margin(r = 15)),
    axis.text = element_text(size = 16, color = "black"),
    axis.text.x = element_text(size = 16, color = "black", margin = margin(t = 24)),
    legend.text = element_text(size = 16, margin = margin(b = 5)),
    legend.title = element_text(size = 16),
    legend.key.width = unit(1.5, "cm")
  )