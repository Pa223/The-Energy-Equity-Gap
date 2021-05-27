library(readstata13)
library(tidyverse)
library(ggpubr)
library(plyr)
library(gapminder)
library(gridExtra)
library(xlsx)

inf_temp <- read.dta13('full_inf_temp_15-19_FULL.dta')

income_order <- c('1', '2', '3', '4', 
                  '5', '6', '7', '8')


median1516 <- aggregate(inf_1516 ~ VINCOME_new, inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120),], median)
gg_1516 <- ggplot(inf_temp, aes(x = factor(VINCOME_new, level = income_order), y = inf_1516))+
  geom_boxplot()+
  xlab("Income Group")+
  ylab(expression(paste("Inflection Temperature (",degree,"F)")))+
  scale_y_continuous(limits = c(30,120), breaks = seq(30,120,30))+
  geom_text(data = median1516, aes(label = round(inf_1516, 1), y = inf_1516 + 5), size = 6)+
  ggtitle("Year 2015-2016", subtitle = "EEG = 5.9 degrees")+ 
  theme_bw(base_family = "Lato")+
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 20),
    axis.title.x = element_text(size = 20, margin = margin(t = 15)),
    axis.title.y = element_text(size = 20, margin = margin(r = 15)),
    axis.text = element_text(size = 18, color = "black")
  )


median1617 <- aggregate(inf_1617 ~ VINCOME_new, inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120),], median)
gg_1617 <- ggplot(inf_temp, aes(x = factor(VINCOME_new, level = income_order), y = inf_1617))+
  geom_boxplot()+
  xlab("Income Group")+
  ylab(expression(paste("Inflection Temperature (",degree,"F)")))+
  scale_y_continuous(limits = c(30,120), breaks = seq(30,120,30))+
  geom_text(data = median1617, aes(label = round(inf_1617, 1), y = inf_1617 + 5), size = 6)+
  ggtitle("Year 2016-2017", subtitle = "EEG = 4.7 degrees")+ 
  theme_bw(base_family = "Lato")+
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 20),
    axis.title.x = element_text(size = 20, margin = margin(t = 15)),
    axis.title.y = element_text(size = 20, margin = margin(r = 15)),
    axis.text = element_text(size = 18, color = "black")
  )


median1718 <- aggregate(inf_1718 ~ VINCOME_new, inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120),], median)
gg_1718 <- ggplot(inf_temp, aes(x = factor(VINCOME_new, level = income_order), y = inf_1718))+
  geom_boxplot()+
  xlab("Income Group")+
  ylab(expression(paste("Inflection Temperature (",degree,"F)")))+
  scale_y_continuous(limits = c(30,120), breaks = seq(30,120,30))+
  geom_text(data = median1718, aes(label = round(inf_1718, 1), y = inf_1718 + 5), size = 6)+
  ggtitle("Year 2017-2018", subtitle = "EEG = 5.2 degrees")+ 
  theme_bw(base_family = "Lato")+
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 20),
    axis.title.x = element_text(size = 20, margin = margin(t = 15)),
    axis.title.y = element_text(size = 20, margin = margin(r = 15)),
    axis.text = element_text(size = 18, color = "black")
  )

median1819 <- aggregate(inf_1819 ~ VINCOME_new, inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120),], median)
gg_1819 <- ggplot(inf_temp, aes(x = factor(VINCOME_new, level = income_order), y = inf_1819))+
  geom_boxplot()+
  xlab("Income Group")+
  ylab(expression(paste("Inflection Temperature (",degree,"F)")))+
  scale_y_continuous(limits = c(30,120), breaks = seq(30,120,30))+
  geom_text(data = median1819, aes(label = round(inf_1819, 1), y = inf_1819 + 5), size = 6)+
  ggtitle("Year 2018-2019", subtitle = "EEG = 7.5 degrees")+ 
  theme_bw(base_family = "Lato")+
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 20),
    axis.title.x = element_text(size = 20, margin = margin(t = 15)),
    axis.title.y = element_text(size = 20, margin = margin(r = 15)),
    axis.text = element_text(size = 18, color = "black")
  )

ggarrange(gg_1516, gg_1617, gg_1718, gg_1819, ncol = 2, nrow = 2)