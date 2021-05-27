library(readstata13)
library(tidyverse)
library(ggpubr)
library(plyr)
library(gapminder)
library(gridExtra)
library(gdata)
library(readxl)

inf_temp <- read.dta13('full_inf_temp_15-19_FULL.dta')


## define low, medium, high bounds of each income group

inf_temp$income_low <- 0
inf_temp$income_med <- 0
inf_temp$income_high <- 0

inf_temp$income_low[inf_temp$VINCOME_new == '1'] <- 5000
inf_temp$income_low[inf_temp$VINCOME_new == '2'] <- 15000
inf_temp$income_low[inf_temp$VINCOME_new == '3'] <- 25000
inf_temp$income_low[inf_temp$VINCOME_new == '4'] <- 35000
inf_temp$income_low[inf_temp$VINCOME_new == '5'] <- 50000
inf_temp$income_low[inf_temp$VINCOME_new == '6'] <- 75000
inf_temp$income_low[inf_temp$VINCOME_new == '7'] <- 100000
inf_temp$income_low[inf_temp$VINCOME_new == '8'] <- 150000

inf_temp$income_med[inf_temp$VINCOME_new == '1'] <- 10000
inf_temp$income_med[inf_temp$VINCOME_new == '2'] <- 20000
inf_temp$income_med[inf_temp$VINCOME_new == '3'] <- 30000
inf_temp$income_med[inf_temp$VINCOME_new == '4'] <- 42500
inf_temp$income_med[inf_temp$VINCOME_new == '5'] <- 62500
inf_temp$income_med[inf_temp$VINCOME_new == '6'] <- 87500
inf_temp$income_med[inf_temp$VINCOME_new == '7'] <- 125000
inf_temp$income_med[inf_temp$VINCOME_new == '8'] <- 175000

inf_temp$income_high[inf_temp$VINCOME_new == '1'] <- 14999
inf_temp$income_high[inf_temp$VINCOME_new == '2'] <- 24999
inf_temp$income_high[inf_temp$VINCOME_new == '3'] <- 34999
inf_temp$income_high[inf_temp$VINCOME_new == '4'] <- 49999
inf_temp$income_high[inf_temp$VINCOME_new == '5'] <- 74999
inf_temp$income_high[inf_temp$VINCOME_new == '6'] <- 99999
inf_temp$income_high[inf_temp$VINCOME_new == '7'] <- 149999
inf_temp$income_high[inf_temp$VINCOME_new == '8'] <- 200000

## calculate TEP of each household based on low, medium, high income estimates

inf_temp$p1516_low <- 0
inf_temp$p1516_med <- 0
inf_temp$p1516_high <- 0

inf_temp$p1617_low <- 0
inf_temp$p1617_med <- 0
inf_temp$p1617_high <- 0

inf_temp$p1718_low <- 0
inf_temp$p1718_med <- 0
inf_temp$p1718_high <- 0

inf_temp$p1819_low <- 0
inf_temp$p1819_med <- 0
inf_temp$p1819_high <- 0


inf_temp$p1516_low <- inf_temp$cost_1516/inf_temp$income_low
inf_temp$p1516_med <- inf_temp$cost_1516/inf_temp$income_med
inf_temp$p1516_high <- inf_temp$cost_1516/inf_temp$income_high

inf_temp$p1617_low <- inf_temp$cost_1617/inf_temp$income_low
inf_temp$p1617_med <- inf_temp$cost_1617/inf_temp$income_med
inf_temp$p1617_high <- inf_temp$cost_1617/inf_temp$income_high

inf_temp$p1718_low <- inf_temp$cost_1718/inf_temp$income_low
inf_temp$p1718_med <- inf_temp$cost_1718/inf_temp$income_med
inf_temp$p1718_high <- inf_temp$cost_1718/inf_temp$income_high

inf_temp$p1819_low <- inf_temp$cost_1819/inf_temp$income_low
inf_temp$p1819_med <- inf_temp$cost_1819/inf_temp$income_med
inf_temp$p1819_high <- inf_temp$cost_1819/inf_temp$income_high

inf_temp$p1920_low <- inf_temp$cost_1920/inf_temp$income_low
inf_temp$p1920_med <- inf_temp$cost_1920/inf_temp$income_med
inf_temp$p1920_high <- inf_temp$cost_1920/inf_temp$income_high


income_order <- c('1', '2', '3', '4', 
                  '5', '6', '7', '8')


## plot using the medium income TEP calculation


sum(inf_temp$p1516_med > 0.1, na.rm = TRUE)/ sum(!is.na(inf_temp$p1516_med))
ggcost1516_med <- ggplot(inf_temp, aes(x = p1516_med))+
  geom_histogram()+
  scale_y_continuous(limits = c(0, 1150))+
  scale_x_continuous(trans = "log10", breaks = c(10^-5,10^-4, 10^-3, 10^-2, 10^-1, 10^0), limits = c(10^-5, 10^0))+
  annotation_logticks(sides = "b", outside = FALSE, size = 1)+
  xlab("TEP (log scale)")+
  ylab("Number of households")+
  ggtitle("Year 2015-2016", subtitle = "TEP > 10%: 2.7%")+
  theme(
    plot.title = element_text(size = 14, face = "bold.italic"),
    plot.subtitle = element_text(size = 14),
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    axis.text = element_text(size = 12)
  )


sum(inf_temp$p1617_med > 0.1, na.rm = TRUE)/ sum(!is.na(inf_temp$p1617_med))
ggcost1617_med <- ggplot(inf_temp, aes(x = p1617_med))+
  geom_histogram()+
  scale_y_continuous(limits = c(0, 1150))+
  scale_x_continuous(trans = "log10", breaks = c(10^-5,10^-4, 10^-3, 10^-2, 10^-1, 10^0), limits = c(10^-5, 10^0))+
  annotation_logticks(sides = "b", outside = FALSE, size = 1)+
  xlab("TEP (log scale)")+
  ylab("Number of households")+
  ggtitle("Year 2016-2017", subtitle = "TEP > 10%: 2.4%")+
  theme(
    plot.title = element_text(size = 14, face = "bold.italic"),
    plot.subtitle = element_text(size = 14),
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    axis.text = element_text(size = 12)
  )


sum(inf_temp$p1718_med > 0.1, na.rm = TRUE)/ sum(!is.na(inf_temp$p1718_med))
ggcost1718_med <- ggplot(inf_temp, aes(x = p1718_med))+
  geom_histogram()+
  scale_y_continuous(limits = c(0, 1150))+
  scale_x_continuous(trans = "log10", breaks = c(10^-5,10^-4, 10^-3, 10^-2, 10^-1, 10^0), limits = c(10^-5, 10^0))+
  annotation_logticks(sides = "b", outside = FALSE, size = 1)+
  xlab("TEP (log scale)")+
  ylab("Number of households")+
  ggtitle("Year 2017-2018", subtitle = "TEP > 10%: 2.5%")+
  theme(
    plot.title = element_text(size = 14, face = "bold.italic"),
    plot.subtitle = element_text(size = 14),
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    axis.text = element_text(size = 12)
  )


sum(inf_temp$p1819_med > 0.1, na.rm = TRUE)/ sum(!is.na(inf_temp$p1819_med))
ggcost1819_med <- ggplot(inf_temp, aes(x = p1819_med))+
  geom_histogram()+
  scale_y_continuous(limits = c(0, 1150))+
  scale_x_continuous(trans = "log10", breaks = c(10^-5,10^-4, 10^-3, 10^-2, 10^-1, 10^0), limits = c(10^-5, 10^0))+
  annotation_logticks(sides = "b", outside = FALSE, size = 1)+
  xlab("TEP (log scale)")+
  ylab("Number of households")+
  ggtitle("Year 2018-2019", subtitle = "TEP > 10%: 2.7%")+
  theme(
    plot.title = element_text(size = 14, face = "bold.italic"),
    plot.subtitle = element_text(size = 14),
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    axis.text = element_text(size = 12)
  )

