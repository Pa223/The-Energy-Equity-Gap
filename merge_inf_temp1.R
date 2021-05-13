library(readstata13)
library(tidyverse)
library(ggpubr)
library(plyr)
library(gapminder)
library(gridExtra)
library(xlsx)
setwd("C:/Users/scong/Desktop/PhD Materials/Research/Energy Poverty Project/transforming data")

########################################
# inf_1516 <- read.dta13("IPT Second Stage 2015-2016-p.dta")
# inf_1617 <- read.dta13("IPT Second Stage 2016-2017-p.dta")
# inf_1718 <- read.dta13("IPT Second Stage 2017-2018-p.dta")
# inf_1819 <- read.dta13("IPT Second Stage 2018-2019-p.dta")
# inf_1519 <- read.dta13("IPT Second Stage 2015-2019-p.dta")
#  
# names(inf_1516)[names(inf_1516) == "inf_temp"] <- "inf_1516"
# names(inf_1617)[names(inf_1617) == "inf_temp"] <- "inf_1617"
# names(inf_1718)[names(inf_1718) == "inf_temp"] <- "inf_1718"
# names(inf_1819)[names(inf_1819) == "inf_temp"] <- "inf_1819"
# all_inf <- merge(x = inf_1516[,c("BILACCT_K","inf_1516")], y = inf_1519, by = "BILACCT_K", all.y = TRUE)
# all_inf <- merge(x = inf_1617[,c("BILACCT_K","inf_1617")], y =all_inf, by = "BILACCT_K", all.y = TRUE)
# all_inf <- merge(x = inf_1718[,c("BILACCT_K","inf_1718")], y =all_inf, by = "BILACCT_K", all.y = TRUE)
# all_inf <- merge(x = inf_1819[,c("BILACCT_K","inf_1819")], y =all_inf, by = "BILACCT_K", all.y = TRUE)
# save.dta13(all_inf, file = "all_inf.dta")
# all_inf <- read.dta13("all_inf.dta")
# inf_temp = all_inf[!(all_inf$VINCOME==""), ]
# inf_temp = inf_temp[!(inf_temp$VETHNIC==""), ]
# inf_temp$VINCOME_new <- inf_temp$VINCOME
# inf_temp$VINCOME_new[inf_temp$VINCOME_new == 'Less than $15,000'] <- '1'
# inf_temp$VINCOME_new[inf_temp$VINCOME_new == '$15,000 to $24,999'] <- '2'
# inf_temp$VINCOME_new[inf_temp$VINCOME_new == '$25,000 to $34,999'] <- '3'
# inf_temp$VINCOME_new[inf_temp$VINCOME_new == '$35,000 to $49,999'] <- '4'
# inf_temp$VINCOME_new[inf_temp$VINCOME_new == '$50,000 to $74,999'] <- '5'
# inf_temp$VINCOME_new[inf_temp$VINCOME_new == '$75,000 to $99,999'] <- '6'
# inf_temp$VINCOME_new[inf_temp$VINCOME_new == '$100,000 to $149,999'] <- '7'
# inf_temp$VINCOME_new[inf_temp$VINCOME_new == '$150,000 or more'] <- '8'

# save.dta13(inf_temp, file = 'full_inf_temp_15-19.dta')

# inf_temp$VETHNIC_new <- inf_temp$VETHNIC
# inf_temp$VETHNIC_new[inf_temp$VETHNIC_new == 'White/Caucasian'] <- '1'
# inf_temp$VETHNIC_new[inf_temp$VETHNIC_new == 'Asian'] <- '2'
# inf_temp$VETHNIC_new[inf_temp$VETHNIC_new == 'Hispanic'] <- '3'
# inf_temp$VETHNIC_new[inf_temp$VETHNIC_new == 'Other'] <- '8'
# inf_temp$VETHNIC_new[inf_temp$VETHNIC_new == 'Black or African American'] <- '4'
# inf_temp$VETHNIC_new[inf_temp$VETHNIC_new == 'Pacific Islander'] <- '5'
# inf_temp$VETHNIC_new[inf_temp$VETHNIC_new == 'American Indian/Alaska Native'] <- '6'
# inf_temp$VETHNIC_new[inf_temp$VETHNIC_new == 'Native Hawaiian or Other'] <- '7'

# inf_temp$VHH_AGECODE_new <- inf_temp$VHH_AGECODE
# inf_temp$VHH_AGECODE_new[inf_temp$VHH_AGECODE_new == "18-24 yrs old"] <- '1'
# inf_temp$VHH_AGECODE_new[inf_temp$VHH_AGECODE_new == "25-34 yrs old"] <- '2'
# inf_temp$VHH_AGECODE_new[inf_temp$VHH_AGECODE_new == "35-44 yrs old"] <- '3'
# inf_temp$VHH_AGECODE_new[inf_temp$VHH_AGECODE_new == "45-54 yrs old"] <- '4'
# inf_temp$VHH_AGECODE_new[inf_temp$VHH_AGECODE_new == "55-64 yrs old"] <- '5'
# inf_temp$VHH_AGECODE_new[inf_temp$VHH_AGECODE_new == "65-74 yrs old"] <- '6'
# inf_temp$VHH_AGECODE_new[inf_temp$VHH_AGECODE_new == "75+ yrs old"] <- '7'
########################################

inf_temp <- read.dta13('full_inf_temp_15-19_FULL.dta')

income_order <- c('1', '2', '3', '4', 
                  '5', '6', '7', '8')
race_order <- c('1', '2', '3', '4', 
                  '5', '6', '7', '8')
age_order <- c('1', '2', '3', '4', 
               '5', '6', '7')

# inf_temp = inf_temp[!(inf_temp$inf_1516 < 40), ]
# inf_temp = inf_temp[!(inf_temp$inf_1617 < 40), ]
# inf_temp = inf_temp[!(inf_temp$inf_1718 < 40), ]
# inf_temp = inf_temp[!(inf_temp$inf_1819 < 40), ]
# 
# inf_temp = inf_temp[!(inf_temp$inf_1516 > 110), ]
# inf_temp = inf_temp[!(inf_temp$inf_1617 > 110), ]
# inf_temp = inf_temp[!(inf_temp$inf_1718 > 110), ]
# inf_temp = inf_temp[!(inf_temp$inf_1819 > 110), ]
####################################################################################
## income

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
ggarrange(gg_1516, gg_1617, gg_1718, gg_1819, ncol = 4, nrow = 1)
####################################################################################
## race

eth_median1516 <- aggregate(inf_1516 ~ VETHNIC_new, inf_temp, median)
eth_gg_1516 <- ggplot(inf_temp, aes(x = factor(VETHNIC_new, level = race_order), y = inf_1516))+
  geom_boxplot()+
  xlab("Ethnicity")+
  ylab("Inflection Temperature (F)")+
  coord_cartesian(ylim = c(40,100))+
  geom_text(data = eth_median1516, aes(label = round(inf_1516, 1), y = inf_1516 + 1.5), size = 4.5)+
  ggtitle("Year 2015-2016")+ 
  theme(
    plot.title = element_text(size = 14, face = "bold.italic"),
    plot.subtitle = element_text(size = 14),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14)
  )


eth_median1617 <- aggregate(inf_1617 ~ VETHNIC_new, inf_temp, median)
eth_gg_1617 <- ggplot(inf_temp, aes(x = factor(VETHNIC_new, level = race_order), y = inf_1617))+
  geom_boxplot()+
  xlab("Ethnicity")+
  ylab("Inflection Temperature (F)")+
  coord_cartesian(ylim = c(40,100))+
  geom_text(data = eth_median1617, aes(label = round(inf_1617, 1), y = inf_1617 + 1.5), size = 4.5)+
  ggtitle("Year 2016-2017")+ 
  theme(
    plot.title = element_text(size = 14, face = "bold.italic"),
    plot.subtitle = element_text(size = 14),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14)
  )


eth_median1718 <- aggregate(inf_1718 ~ VETHNIC_new, inf_temp, median)
eth_gg_1718 <- ggplot(inf_temp, aes(x = factor(VETHNIC_new, level = race_order), y = inf_1718))+
  geom_boxplot()+
  xlab("Ethnicity")+
  ylab("Inflection Temperature (F)")+
  coord_cartesian(ylim = c(40,100))+
  geom_text(data = eth_median1718, aes(label = round(inf_1718, 1), y = inf_1718 + 1.5), size = 4.5)+
  ggtitle("Year 2017-2018")+ 
  theme(
    plot.title = element_text(size = 14, face = "bold.italic"),
    plot.subtitle = element_text(size = 14),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14)
  )


eth_median1819 <- aggregate(inf_1819 ~ VETHNIC_new, inf_temp, median)
eth_gg_1819 <- ggplot(inf_temp, aes(x = factor(VETHNIC_new, level = race_order), y = inf_1819))+
  geom_boxplot()+
  xlab("Ethnicity")+
  ylab("Inflection Temperature (F)")+
  coord_cartesian(ylim = c(40,100))+
  geom_text(data = eth_median1819, aes(label = round(inf_1819, 1), y = inf_1819 + 1.5), size = 4.5)+
  ggtitle("Year 2018-2019")+ 
  theme(
    plot.title = element_text(size = 14, face = "bold.italic"),
    plot.subtitle = element_text(size = 14),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14)
  )

ggarrange(eth_gg_1516, eth_gg_1617, eth_gg_1718, eth_gg_1819, ncol = 4, nrow = 1)


####################################################################################
## age

age_median1516 <- aggregate(inf_1516 ~ VHH_AGECODE_new, inf_temp, median)
age_gg_1516 <- ggplot(inf_temp, aes(x = factor(VHH_AGECODE_new, level = age_order), y = inf_1516))+
  geom_boxplot()+
  xlab("Age Group")+
  ylab("Inflection Temperature (F)")+
  coord_cartesian(ylim = c(40,100))+
  geom_text(data = age_median1516, aes(label = round(inf_1516, 1), y = inf_1516 + 1.5), size = 4.5)+
  ggtitle("Year 2015-2016")+ 
  theme(
    plot.title = element_text(size = 14, face = "bold.italic"),
    plot.subtitle = element_text(size = 14),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14)
  )


age_median1617 <- aggregate(inf_1617 ~ VHH_AGECODE_new, inf_temp, median)
age_gg_1617 <- ggplot(inf_temp, aes(x = factor(VHH_AGECODE_new, level = age_order), y = inf_1617))+
  geom_boxplot()+
  xlab("Age Group")+
  ylab("Inflection Temperature (F)")+
  coord_cartesian(ylim = c(40,100))+
  geom_text(data = age_median1617, aes(label = round(inf_1617, 1), y = inf_1617 + 1.5), size = 4.5)+
  ggtitle("Year 2016-2017")+ 
  theme(
    plot.title = element_text(size = 14, face = "bold.italic"),
    plot.subtitle = element_text(size = 14),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14)
  )


age_median1718 <- aggregate(inf_1718 ~ VHH_AGECODE_new, inf_temp, median)
age_gg_1718 <- ggplot(inf_temp, aes(x = factor(VHH_AGECODE_new, level = age_order), y = inf_1718))+
  geom_boxplot()+
  xlab("Age Group")+
  ylab("Inflection Temperature (F)")+
  coord_cartesian(ylim = c(40,100))+
  geom_text(data = age_median1718, aes(label = round(inf_1718, 1), y = inf_1718 + 1.5), size = 4.5)+
  ggtitle("Year 2017-2018")+ 
  theme(
    plot.title = element_text(size = 14, face = "bold.italic"),
    plot.subtitle = element_text(size = 14),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14)
  )


age_median1819 <- aggregate(inf_1819 ~ VHH_AGECODE_new, inf_temp, median)
age_gg_1819 <- ggplot(inf_temp, aes(x = factor(VHH_AGECODE_new, level = age_order), y = inf_1819))+
  geom_boxplot()+
  xlab("Age Group")+
  ylab("Inflection Temperature (F)")+
  coord_cartesian(ylim = c(40,100))+
  geom_text(data = age_median1819, aes(label = round(inf_1819, 1), y = inf_1819 + 1.5), size = 4.5)+
  ggtitle("Year 2018-2019")+ 
  theme(
    plot.title = element_text(size = 14, face = "bold.italic"),
    plot.subtitle = element_text(size = 14),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14)
  )

ggarrange(age_gg_1516, age_gg_1617, age_gg_1718, age_gg_1819, ncol = 4, nrow = 1)
####################################################################################
## legends


tab <- as.data.frame(
  c(
    ' ' = 'Income Group',
    '1. ' = 'Less than $15,000',
    '2. ' = '$15,000 to $24,999',
    '3. ' = '$25,000 to $34,999',
    '4. ' = '$35,000 to $49,999',
    '5. ' = '$50,000 to $74,999',
    '6. ' = '$75,000 to $99,999',
    '7. ' = '$100,000 to $149,999',
    '8. ' = '$150,000 or more'
  )
)

tab1 <- as.data.frame(
  c(
    ' ' = 'Ethnicity',
    '1. ' = 'White/Caucasian',
    '2. ' = 'Asian',
    '3. ' = 'Hispanic',
    '4. ' = 'Black or African American',
    '5. ' = 'Pacific Islander',
    '6. ' = 'American Indian/Alaska Native',
    '7. ' = 'Native Hawaiian or Other',
    '8. ' = 'Other'
  )
)


tab2 <- as.data.frame(
  c(
    ' ' = 'Age Group',
    '1. ' = '18-24 yrs old',
    '2. ' = '25-34 yrs old',
    '3. ' = '35-44 yrs old',
    '4. ' = '45-54 yrs old',
    '5. ' = '55-64 yrs old',
    '6. ' = '65-74 yrs old',
    '7. ' = '75+ yrs old'
  )
)


t1 <- ttheme_minimal(
  core=list(fg_params=list(hjust=0, x=0, fontfamily = "Lato", fontsize = 18)),
  rowhead=list(fg_params=list(hjust=1, x=0.95, fontfamily = "Lato", fontsize = 18, fontface = "plain"))
)


legend <- tableGrob(unname(tab), theme = t1)
legend1 <- tableGrob(unname(tab1), theme = t1)
legend2 <- tableGrob(unname(tab2), theme = t1)

ggarrange(legend)
ggarrange(legend1)
ggarrange(legend2)




##############################################################################################
## difference between ethnic groups

white_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VETHNIC_new == "1", "inf_1516"], na.rm = TRUE)
white_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VETHNIC_new == "1", "inf_1617"], na.rm = TRUE)
white_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VETHNIC_new == "1", "inf_1718"], na.rm = TRUE)
white_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VETHNIC_new == "1", "inf_1819"], na.rm = TRUE)

white_median <- data.frame(ethnicity = "White",
                           "15-16" = white_median_1516,
                           "16-17" = white_median_1617,
                           "17-18" = white_median_1718,
                           "18-19" = white_median_1819)

asian_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VETHNIC_new == "2", "inf_1516"], na.rm = TRUE)
asian_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VETHNIC_new == "2", "inf_1617"], na.rm = TRUE)
asian_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VETHNIC_new == "2", "inf_1718"], na.rm = TRUE)
asian_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VETHNIC_new == "2", "inf_1819"], na.rm = TRUE)

asian_median <- data.frame(ethnicity = "Asian",
                           "15-16" = asian_median_1516,
                           "16-17" = asian_median_1617,
                           "17-18" = asian_median_1718,
                           "18-19" = asian_median_1819)

hisp_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VETHNIC_new == "3", "inf_1516"], na.rm = TRUE)
hisp_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VETHNIC_new == "3", "inf_1617"], na.rm = TRUE)
hisp_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VETHNIC_new == "3", "inf_1718"], na.rm = TRUE)
hisp_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VETHNIC_new == "3", "inf_1819"], na.rm = TRUE)

hisp_median <- data.frame(ethnicity = "Hispanic",
                           "15-16" = hisp_median_1516,
                           "16-17" = hisp_median_1617,
                           "17-18" = hisp_median_1718,
                           "18-19" = hisp_median_1819)

black_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VETHNIC_new == "5", "inf_1516"], na.rm = TRUE)
black_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VETHNIC_new == "5", "inf_1617"], na.rm = TRUE)
black_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VETHNIC_new == "5", "inf_1718"], na.rm = TRUE)
black_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VETHNIC_new == "5", "inf_1819"], na.rm = TRUE)

black_median <- data.frame(ethnicity = "Black",
                          "15-16" = black_median_1516,
                          "16-17" = black_median_1617,
                          "17-18" = black_median_1718,
                          "18-19" = black_median_1819)

eth_median <- rbind(white_median, asian_median, hisp_median, black_median)

pop_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) , "inf_1516"], na.rm = TRUE)
pop_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) , "inf_1617"], na.rm = TRUE)
pop_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) , "inf_1718"], na.rm = TRUE)
pop_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) , "inf_1819"], na.rm = TRUE)

pop_median <- data.frame(ethnicity = "pop",
                           "15-16" = pop_median_1516,
                           "16-17" = pop_median_1617,
                           "17-18" = pop_median_1718,
                           "18-19" = pop_median_1819)

white_1516 <- aggregate(inf_1516 ~ VINCOME_new, inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VETHNIC_new == "1",], median)
white_1617 <- aggregate(inf_1617 ~ VINCOME_new, inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VETHNIC_new == "1",], median)
white_1718 <- aggregate(inf_1718 ~ VINCOME_new, inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VETHNIC_new == "1",], median)
white_1819 <- aggregate(inf_1819 ~ VINCOME_new, inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VETHNIC_new == "1",], median)
white_inf_temp <- cbind(white_1516, white_1617, white_1718, white_1819)
write.csv(white_inf_temp, file = "white_inf_temp.csv")

asian_1516 <- aggregate(inf_1516 ~ VINCOME_new, inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VETHNIC_new == "2",], median)
asian_1617 <- aggregate(inf_1617 ~ VINCOME_new, inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VETHNIC_new == "2",], median)
asian_1718 <- aggregate(inf_1718 ~ VINCOME_new, inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VETHNIC_new == "2",], median)
asian_1819 <- aggregate(inf_1819 ~ VINCOME_new, inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VETHNIC_new == "2",], median)
asian_inf_temp <- cbind(asian_1516, asian_1617, asian_1718, asian_1819)
write.csv(asian_inf_temp, file = "asian_inf_temp.csv")

hisp_1516 <- aggregate(inf_1516 ~ VINCOME_new, inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VETHNIC_new == "3",], median)
hisp_1617 <- aggregate(inf_1617 ~ VINCOME_new, inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VETHNIC_new == "3",], median)
hisp_1718 <- aggregate(inf_1718 ~ VINCOME_new, inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VETHNIC_new == "3",], median)
hisp_1819 <- aggregate(inf_1819 ~ VINCOME_new, inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VETHNIC_new == "3",], median)
hisp_inf_temp <- cbind(hisp_1516, hisp_1617, hisp_1718, hisp_1819)
write.csv(hisp_inf_temp, file = "hisp_inf_temp.csv")

black_1516 <- aggregate(inf_1516 ~ VINCOME_new, inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VETHNIC_new == "4",], median)
black_1617 <- aggregate(inf_1617 ~ VINCOME_new, inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VETHNIC_new == "4",], median)
black_1718 <- aggregate(inf_1718 ~ VINCOME_new, inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VETHNIC_new == "4",], median)
black_1819 <- aggregate(inf_1819 ~ VINCOME_new, inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VETHNIC_new == "4",], median)
black_inf_temp <- cbind(black_1516, black_1617, black_1718, black_1819)
write.csv(black_inf_temp, file = "black_inf_temp.csv")


##############################################################################################
## difference between income groups

g1_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & (inf_temp$VINCOME_new == "1"), "inf_1516"], na.rm = TRUE)
g1_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & (inf_temp$VINCOME_new == "1"), "inf_1617"], na.rm = TRUE)
g1_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & (inf_temp$VINCOME_new == "1"), "inf_1718"], na.rm = TRUE)
g1_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & (inf_temp$VINCOME_new == "1"), "inf_1819"], na.rm = TRUE)

g1_median <- data.frame(income = "g1",
                           "15-16" = g1_median_1516,
                           "16-17" = g1_median_1617,
                           "17-18" = g1_median_1718,
                           "18-19" = g1_median_1819)

g2_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & (inf_temp$VINCOME_new == "2"), "inf_1516"], na.rm = TRUE)
g2_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & (inf_temp$VINCOME_new == "2"), "inf_1617"], na.rm = TRUE)
g2_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & (inf_temp$VINCOME_new == "2"), "inf_1718"], na.rm = TRUE)
g2_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & (inf_temp$VINCOME_new == "2"), "inf_1819"], na.rm = TRUE)

g2_median <- data.frame(income = "g2",
                        "15-16" = g2_median_1516,
                        "16-17" = g2_median_1617,
                        "17-18" = g2_median_1718,
                        "18-19" = g2_median_1819)

g3_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & (inf_temp$VINCOME_new == "3"), "inf_1516"], na.rm = TRUE)
g3_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & (inf_temp$VINCOME_new == "3"), "inf_1617"], na.rm = TRUE)
g3_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & (inf_temp$VINCOME_new == "3"), "inf_1718"], na.rm = TRUE)
g3_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & (inf_temp$VINCOME_new == "3"), "inf_1819"], na.rm = TRUE)

g3_median <- data.frame(income = "g3",
                        "15-16" = g3_median_1516,
                        "16-17" = g3_median_1617,
                        "17-18" = g3_median_1718,
                        "18-19" = g3_median_1819)

g4_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & (inf_temp$VINCOME_new == "4"), "inf_1516"], na.rm = TRUE)
g4_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & (inf_temp$VINCOME_new == "4"), "inf_1617"], na.rm = TRUE)
g4_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & (inf_temp$VINCOME_new == "4"), "inf_1718"], na.rm = TRUE)
g4_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & (inf_temp$VINCOME_new == "4"), "inf_1819"], na.rm = TRUE)

g4_median <- data.frame(income = "g4",
                        "15-16" = g4_median_1516,
                        "16-17" = g4_median_1617,
                        "17-18" = g4_median_1718,
                        "18-19" = g4_median_1819)

g5_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & (inf_temp$VINCOME_new == "5"), "inf_1516"], na.rm = TRUE)
g5_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & (inf_temp$VINCOME_new == "5"), "inf_1617"], na.rm = TRUE)
g5_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & (inf_temp$VINCOME_new == "5"), "inf_1718"], na.rm = TRUE)
g5_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & (inf_temp$VINCOME_new == "5"), "inf_1819"], na.rm = TRUE)

g5_median <- data.frame(income = "g5",
                        "15-16" = g5_median_1516,
                        "16-17" = g5_median_1617,
                        "17-18" = g5_median_1718,
                        "18-19" = g5_median_1819)

g6_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & (inf_temp$VINCOME_new == "6"), "inf_1516"], na.rm = TRUE)
g6_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & (inf_temp$VINCOME_new == "6"), "inf_1617"], na.rm = TRUE)
g6_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & (inf_temp$VINCOME_new == "6"), "inf_1718"], na.rm = TRUE)
g6_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & (inf_temp$VINCOME_new == "6"), "inf_1819"], na.rm = TRUE)

g6_median <- data.frame(income = "g6",
                        "15-16" = g6_median_1516,
                        "16-17" = g6_median_1617,
                        "17-18" = g6_median_1718,
                        "18-19" = g6_median_1819)

g7_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & (inf_temp$VINCOME_new == "7"), "inf_1516"], na.rm = TRUE)
g7_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & (inf_temp$VINCOME_new == "7"), "inf_1617"], na.rm = TRUE)
g7_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & (inf_temp$VINCOME_new == "7"), "inf_1718"], na.rm = TRUE)
g7_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & (inf_temp$VINCOME_new == "7"), "inf_1819"], na.rm = TRUE)

g7_median <- data.frame(income = "g7",
                        "15-16" = g7_median_1516,
                        "16-17" = g7_median_1617,
                        "17-18" = g7_median_1718,
                        "18-19" = g7_median_1819)

g8_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & (inf_temp$VINCOME_new == "8"), "inf_1516"], na.rm = TRUE)
g8_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & (inf_temp$VINCOME_new == "8"), "inf_1617"], na.rm = TRUE)
g8_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & (inf_temp$VINCOME_new == "8"), "inf_1718"], na.rm = TRUE)
g8_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & (inf_temp$VINCOME_new == "8"), "inf_1819"], na.rm = TRUE)

g8_median <- data.frame(income = "g8",
                        "15-16" = g8_median_1516,
                        "16-17" = g8_median_1617,
                        "17-18" = g8_median_1718,
                        "18-19" = g8_median_1819)

income_median <- rbind(g1_median, g2_median, g3_median, g4_median, g5_median, g6_median, g7_median, g8_median)
write.csv(income_median, file = "income_median.csv")


##############################################################################################
## difference between age groups

age1_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "1", "inf_1516"], na.rm = TRUE)
age1_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "1", "inf_1617"], na.rm = TRUE)
age1_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "1", "inf_1718"], na.rm = TRUE)
age1_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "1", "inf_1819"], na.rm = TRUE)

age1_median <- data.frame(age = "age1",
                        "15-16" = age1_median_1516,
                        "16-17" = age1_median_1617,
                        "17-18" = age1_median_1718,
                        "18-19" = age1_median_1819)

age2_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "2", "inf_1516"], na.rm = TRUE)
age2_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "2", "inf_1617"], na.rm = TRUE)
age2_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "2", "inf_1718"], na.rm = TRUE)
age2_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "2", "inf_1819"], na.rm = TRUE)

age2_median <- data.frame(age = "age2",
                        "15-16" = age2_median_1516,
                        "16-17" = age2_median_1617,
                        "17-18" = age2_median_1718,
                        "18-19" = age2_median_1819)

age3_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "3", "inf_1516"], na.rm = TRUE)
age3_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "3", "inf_1617"], na.rm = TRUE)
age3_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "3", "inf_1718"], na.rm = TRUE)
age3_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "3", "inf_1819"], na.rm = TRUE)

age3_median <- data.frame(age = "age3",
                        "15-16" = age3_median_1516,
                        "16-17" = age3_median_1617,
                        "17-18" = age3_median_1718,
                        "18-19" = age3_median_1819)

age4_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "4", "inf_1516"], na.rm = TRUE)
age4_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "4", "inf_1617"], na.rm = TRUE)
age4_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "4", "inf_1718"], na.rm = TRUE)
age4_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "4", "inf_1819"], na.rm = TRUE)

age4_median <- data.frame(age = "age4",
                        "15-16" = age4_median_1516,
                        "16-17" = age4_median_1617,
                        "17-18" = age4_median_1718,
                        "18-19" = age4_median_1819)

age5_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "5", "inf_1516"], na.rm = TRUE)
age5_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "5", "inf_1617"], na.rm = TRUE)
age5_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "5", "inf_1718"], na.rm = TRUE)
age5_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "5", "inf_1819"], na.rm = TRUE)

age5_median <- data.frame(age = "age5",
                        "15-16" = age5_median_1516,
                        "16-17" = age5_median_1617,
                        "17-18" = age5_median_1718,
                        "18-19" = age5_median_1819)

age6_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "6", "inf_1516"], na.rm = TRUE)
age6_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "6", "inf_1617"], na.rm = TRUE)
age6_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "6", "inf_1718"], na.rm = TRUE)
age6_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "6", "inf_1819"], na.rm = TRUE)

age6_median <- data.frame(age = "age6",
                        "15-16" = age6_median_1516,
                        "16-17" = age6_median_1617,
                        "17-18" = age6_median_1718,
                        "18-19" = age6_median_1819)

age7_median_1516 <- median(inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "7", "inf_1516"], na.rm = TRUE)
age7_median_1617 <- median(inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "7", "inf_1617"], na.rm = TRUE)
age7_median_1718 <- median(inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "7", "inf_1718"], na.rm = TRUE)
age7_median_1819 <- median(inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "7", "inf_1819"], na.rm = TRUE)

age7_median <- data.frame(age = "age7",
                        "15-16" = age7_median_1516,
                        "16-17" = age7_median_1617,
                        "17-18" = age7_median_1718,
                        "18-19" = age7_median_1819)


age_median <- rbind(age1_median, age2_median, age3_median, age4_median, age5_median, age6_median, age7_median)
write.csv(age_median, file = "age_median.csv")

age1_1516 <- aggregate(inf_1516 ~ VINCOME_new, inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "1",], median)
age1_1617 <- aggregate(inf_1617 ~ VINCOME_new, inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "1",], median)
age1_1718 <- aggregate(inf_1718 ~ VINCOME_new, inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "1",], median)
age1_1819 <- aggregate(inf_1819 ~ VINCOME_new, inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "1",], median)
age1_inf_temp <- cbind(age1_1516, age1_1617, age1_1718, age1_1819)
write.csv(age1_inf_temp, file = "age1_inf_temp.csv")

age2_1516 <- aggregate(inf_1516 ~ VINCOME_new, inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "2",], median)
age2_1617 <- aggregate(inf_1617 ~ VINCOME_new, inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "2",], median)
age2_1718 <- aggregate(inf_1718 ~ VINCOME_new, inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "2",], median)
age2_1819 <- aggregate(inf_1819 ~ VINCOME_new, inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "2",], median)
age2_inf_temp <- cbind(age2_1516, age2_1617, age2_1718, age2_1819)
write.csv(age2_inf_temp, file = "age2_inf_temp.csv")

age3_1516 <- aggregate(inf_1516 ~ VINCOME_new, inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "3",], median)
age3_1617 <- aggregate(inf_1617 ~ VINCOME_new, inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "3",], median)
age3_1718 <- aggregate(inf_1718 ~ VINCOME_new, inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "3",], median)
age3_1819 <- aggregate(inf_1819 ~ VINCOME_new, inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "3",], median)
age3_inf_temp <- cbind(age3_1516, age3_1617, age3_1718, age3_1819)
write.csv(age3_inf_temp, file = "age3_inf_temp.csv")

age4_1516 <- aggregate(inf_1516 ~ VINCOME_new, inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "4",], median)
age4_1617 <- aggregate(inf_1617 ~ VINCOME_new, inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "4",], median)
age4_1718 <- aggregate(inf_1718 ~ VINCOME_new, inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "4",], median)
age4_1819 <- aggregate(inf_1819 ~ VINCOME_new, inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "4",], median)
age4_inf_temp <- cbind(age4_1516, age4_1617, age4_1718, age4_1819)
write.csv(age4_inf_temp, file = "age4_inf_temp.csv")

age5_1516 <- aggregate(inf_1516 ~ VINCOME_new, inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "5",], median)
age5_1617 <- aggregate(inf_1617 ~ VINCOME_new, inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "5",], median)
age5_1718 <- aggregate(inf_1718 ~ VINCOME_new, inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "5",], median)
age5_1819 <- aggregate(inf_1819 ~ VINCOME_new, inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "5",], median)
age5_inf_temp <- cbind(age5_1516, age5_1617, age5_1718, age5_1819)
write.csv(age5_inf_temp, file = "age5_inf_temp.csv")

age6_1516 <- aggregate(inf_1516 ~ VINCOME_new, inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "6",], median)
age6_1617 <- aggregate(inf_1617 ~ VINCOME_new, inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "6",], median)
age6_1718 <- aggregate(inf_1718 ~ VINCOME_new, inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "6",], median)
age6_1819 <- aggregate(inf_1819 ~ VINCOME_new, inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "6",], median)
age6_inf_temp <- cbind(age6_1516, age6_1617, age6_1718, age6_1819)
write.csv(age6_inf_temp, file = "age6_inf_temp.csv")

age7_1516 <- aggregate(inf_1516 ~ VINCOME_new, inf_temp[(inf_temp$inf_1516 >30) & (inf_temp$inf_1516 <120) & inf_temp$VHH_AGECODE_new == "7",], median)
age7_1617 <- aggregate(inf_1617 ~ VINCOME_new, inf_temp[(inf_temp$inf_1617 >30) & (inf_temp$inf_1617 <120) & inf_temp$VHH_AGECODE_new == "7",], median)
age7_1718 <- aggregate(inf_1718 ~ VINCOME_new, inf_temp[(inf_temp$inf_1718 >30) & (inf_temp$inf_1718 <120) & inf_temp$VHH_AGECODE_new == "7",], median)
age7_1819 <- aggregate(inf_1819 ~ VINCOME_new, inf_temp[(inf_temp$inf_1819 >30) & (inf_temp$inf_1819 <120) & inf_temp$VHH_AGECODE_new == "7",], median)
age7_inf_temp <- cbind(age7_1516, age7_1617, age7_1718, age7_1819)
write.csv(age7_inf_temp, file = "age7_inf_temp.csv")