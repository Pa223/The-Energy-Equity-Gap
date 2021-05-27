library(readstata13)
library(tidyverse)
library(ggpubr)
library(plyr)
library(gapminder)
library(gridExtra)
library(xlsx)


## first find the median inflection temperature of each ethnicity and income group for all years. Then find the EEG between income group within each ethnicity and age group.

eth_median <- read_xlsx("eth_age.xlsx", sheet = "ethnicity")
age_median <- read_xlsx("eth_age.xlsx", sheet = "age_group")

eth_median_plot <- ggplot(eth_median, aes(x = year, y = inf_temp, group = Ethnicity, color = Ethnicity))+
  geom_point(aes(shape = Ethnicity), size = 4)+
  geom_line(size = 1.5)+
  scale_y_continuous(limits = c(47.5,67.5), breaks = seq(47.5,72.5,2.5))+
  xlab("Year")+
  ylab(expression(paste("Inflection Temperature (",degree,"F)")))+
  labs(color = "Ethnicity", linetype = "Ethnicity", shape = "Ethnicity")+
  theme_bw(base_family = "Lato")+
  scale_color_manual(values = c("#E69F00", "#2D2926", "#56B4E9", "#999999", "#009E73", "#0072B2", "#D55E00", "#CC79A7"))+
  scale_shape_manual(values = c(15, 16, 17, 18, 0, 1, 2, 3))+
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 20),
    axis.title.x = element_text(size = 20, margin = margin(t = -15)),
    axis.title.y = element_text(size = 20, margin = margin(r = 15)),
    axis.text = element_text(size = 18, color = "black"),
    axis.text.x = element_text(size = 18, color = "black", angle = 30, margin = margin(t = 30)),
    legend.text = element_text(size = 18, margin = margin(b = 5)),
    legend.title = element_text(size = 18),
    legend.key.width = unit(1.5, "cm")
  )

eth_eeg_plot <- ggplot(eth_median, aes(x = year, y = EEG, group = Ethnicity, color = Ethnicity))+
  geom_point(aes(shape = Ethnicity), size = 4)+
  geom_line(size = 1.5)+
  scale_y_continuous(limits = c(4.5,17.5), breaks = seq(0,17.5,2.5))+
  xlab("Year")+
  ylab(expression(paste("Energy Equity Gap (",degree,"F)")))+
  labs(color = "Ethnicity", linetype = "Ethnicity", shape = "Ethnicity")+
  theme_bw(base_family = "Lato")+
  scale_color_manual(values = c("#E69F00", "#2D2926", "#56B4E9", "#999999", "#009E73", "#0072B2", "#D55E00", "#CC79A7"))+
  scale_shape_manual(values = c(15, 16, 17, 18, 0, 1, 2, 3))+
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 20),
    axis.title.x = element_text(size = 20, margin = margin(t = -15)),
    axis.title.y = element_text(size = 20, margin = margin(r = 15)),
    axis.text = element_text(size = 18, color = "black"),
    axis.text.x = element_text(size = 18, color = "black", angle = 30, margin = margin(t = 30)),
    legend.text = element_text(size = 18, margin = margin(b = 5)),
    legend.title = element_text(size = 18),
    legend.key.width = unit(1.5, "cm")
  )

ggarrange(eth_median_plot, eth_eeg_plot, ncol = 2, nrow = 1)


age_median_plot <- ggplot(age_median, aes(x = year, y = inf_temp, group = Age_Group, color = Age_Group))+
  geom_point(aes(shape = Age_Group), size = 4)+
  geom_line(size = 1.5)+
  scale_y_continuous(limits = c(50,70), breaks = seq(50,72.5,2.5))+
  xlab("Year")+
  ylab(expression(paste("Inflection Temperature (",degree,"F)")))+
  labs(color = "Age Group", linetype = "Age Group", shape = "Age Group")+
  theme_bw(base_family = "Lato")+
  scale_color_manual(values = c("#009E73", "#E69F00", "#2D2926", "#999999", "#CC79A7", "#0072B2", "#D55E00", "#56B4E9"))+
  scale_shape_manual(values = c(15, 16, 17, 18, 0, 1, 2, 3))+
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 20),
    axis.title.x = element_text(size = 20, margin = margin(t = -15)),
    axis.title.y = element_text(size = 20, margin = margin(r = 15)),
    axis.text = element_text(size = 18, color = "black"),
    axis.text.x = element_text(size = 18, color = "black", angle = 30, margin = margin(t = 30)),
    legend.text = element_text(size = 18, margin = margin(b = 5)),
    legend.title = element_text(size = 18),
    legend.key.width = unit(1.5, "cm")
  )

age_eeg_plot <- ggplot(age_median, aes(x = year, y = EEG, group = Age_Group, color = Age_Group))+
  geom_point(aes(shape = Age_Group), size = 4)+
  geom_line(size = 1.5)+
  scale_y_continuous(limits = c(2.5,20), breaks = seq(0,20,2.5))+
  xlab("Year")+
  ylab(expression(paste("Energy Equity Gap (",degree,"F)")))+
  labs(color = "Age Group", linetype = "Age Group", shape = "Age Group")+
  theme_bw(base_family = "Lato")+
  scale_color_manual(values = c("#009E73", "#E69F00", "#2D2926", "#999999", "#CC79A7", "#0072B2", "#D55E00", "#56B4E9"))+
  scale_shape_manual(values = c(15, 16, 17, 18, 0, 1, 2, 3))+
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 20),
    axis.title.x = element_text(size = 20, margin = margin(t = -15)),
    axis.title.y = element_text(size = 20, margin = margin(r = 15)),
    axis.text = element_text(size = 18, color = "black"),
    axis.text.x = element_text(size = 18, color = "black", angle = 30, margin = margin(t = 30)),
    legend.text = element_text(size = 18, margin = margin(b = 5)),
    legend.title = element_text(size = 18),
    legend.key.width = unit(1.5, "cm")
  )

ggarrange(age_median_plot, age_eeg_plot, ncol = 2, nrow = 1)