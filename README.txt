Data processing

1. webscraping temperature data.py: webscrapes hourly temperature from the study region, 2015-2019.
2. defining calendar.py: define calendar, 2015-2019, whether each day is a weekday/weekend, and/or holiday.
3. hourly to daily meter.py: aggregates hourly electricity consumption into daily, adds on calendar and daily mean temperature data. Repeat for all years.
4. inflection temperature.py: calculates anual inflection temperatures for each household identified as primary (as opposed to secondary residences, vacation homes). Repeat for all years.
5. inf_temp survey merge.py: merge annual inflection temperatures with household survey by account number. Repeat for all years.


Graphs

Figure 2: EEG_boxplots.R
Figure 3: income_line graph.R
Figure 4: ethnicity_age_line graph.R
Figure 6: TEP_histogram.R