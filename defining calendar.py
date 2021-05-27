# -*- coding: utf-8 -*-

import pandas as pd


days = ['Wednesday','Thursday','Friday','Saturday','Sunday', 'Monday', 'Tuesday']

x = (4*365)+1+31+28+31+30
dow_df = pd.DataFrame([i for i in range(1,x+1)], columns = ['Day Number'])

year_2015 = {}
year_2015[1] = [i for i in range(1,32)]
year_2015[2] = [i for i in range(1,29)]
year_2015[3] = [i for i in range(1,32)]
year_2015[4] = [i for i in range(1,31)]
year_2015[5] = [i for i in range(1,32)]
year_2015[6] = [i for i in range(1,31)]
year_2015[7] = [i for i in range(1,32)]
year_2015[8] = [i for i in range(1,32)]
year_2015[9] = [i for i in range(1,31)]
year_2015[10] = [i for i in range(1,32)]
year_2015[11] = [i for i in range(1,31)]
year_2015[12] = [i for i in range(1,32)]

year_2016 = {}
year_2016[1] = [i for i in range(1,32)]
year_2016[2] = [i for i in range(1,30)]
year_2016[3] = [i for i in range(1,32)]
year_2016[4] = [i for i in range(1,31)]
year_2016[5] = [i for i in range(1,32)]
year_2016[6] = [i for i in range(1,31)]
year_2016[7] = [i for i in range(1,32)]
year_2016[8] = [i for i in range(1,32)]
year_2016[9] = [i for i in range(1,31)]
year_2016[10] = [i for i in range(1,32)]
year_2016[11] = [i for i in range(1,31)]
year_2016[12] = [i for i in range(1,32)]

year_2017 = {}
year_2017[1] = [i for i in range(1,32)]
year_2017[2] = [i for i in range(1,29)]
year_2017[3] = [i for i in range(1,32)]
year_2017[4] = [i for i in range(1,31)]
year_2017[5] = [i for i in range(1,32)]
year_2017[6] = [i for i in range(1,31)]
year_2017[7] = [i for i in range(1,32)]
year_2017[8] = [i for i in range(1,32)]
year_2017[9] = [i for i in range(1,31)]
year_2017[10] = [i for i in range(1,32)]
year_2017[11] = [i for i in range(1,31)]
year_2017[12] = [i for i in range(1,32)]

year_2018 = {}
year_2018[1] = [i for i in range(1,32)]
year_2018[2] = [i for i in range(1,29)]
year_2018[3] = [i for i in range(1,32)]
year_2018[4] = [i for i in range(1,31)]
year_2018[5] = [i for i in range(1,32)]
year_2018[6] = [i for i in range(1,31)]
year_2018[7] = [i for i in range(1,32)]
year_2018[8] = [i for i in range(1,32)]
year_2018[9] = [i for i in range(1,31)]
year_2018[10] = [i for i in range(1,32)]
year_2018[11] = [i for i in range(1,31)]
year_2018[12] = [i for i in range(1,32)]

year_2019 = {}
year_2019[1] = [i for i in range(1,32)]
year_2019[2] = [i for i in range(1,29)]
year_2019[3] = [i for i in range(1,32)]
year_2019[4] = [i for i in range(1,31)]


        
year_2015_list = []
for a in year_2015.keys():
    for b in year_2015[a]:
        day = b
        month = a
        if len(str(day)) == 1:
            day_s = '0' + str(day)
        else:
            day_s = str(day)
        if len(str(month)) == 1:
            month_s = '0' + str(month)
        else:
            month_s = str(month)
        year_2015_list.append('2015'+month_s+day_s)
        
year_2016_list = []
for a in year_2016.keys():
    for b in year_2016[a]:
        day = b
        month = a
        if len(str(day)) == 1:
            day_s = '0' + str(day)
        else:
            day_s = str(day)
        if len(str(month)) == 1:
            month_s = '0' + str(month)
        else:
            month_s = str(month)
        year_2016_list.append('2016'+month_s+day_s)
        
        
year_2017_list = []
for a in year_2017.keys():
    for b in year_2017[a]:
        day = b
        month = a
        if len(str(day)) == 1:
            day_s = '0' + str(day)
        else:
            day_s = str(day)
        if len(str(month)) == 1:
            month_s = '0' + str(month)
        else:
            month_s = str(month)
        year_2017_list.append('2017'+month_s+day_s)
        
        
year_2018_list = []
for a in year_2018.keys():
    for b in year_2018[a]:
        day = b
        month = a
        if len(str(day)) == 1:
            day_s = '0' + str(day)
        else:
            day_s = str(day)
        if len(str(month)) == 1:
            month_s = '0' + str(month)
        else:
            month_s = str(month)
        year_2018_list.append('2018'+month_s+day_s)
        
        
year_2019_list = []
for a in year_2019.keys():
    for b in year_2019[a]:
        day = b
        month = a
        if len(str(day)) == 1:
            day_s = '0' + str(day)
        else:
            day_s = str(day)
        if len(str(month)) == 1:
            month_s = '0' + str(month)
        else:
            month_s = str(month)
        year_2019_list.append('2019'+month_s+day_s)
        
years_list = year_2015_list + year_2016_list + year_2017_list+ year_2018_list+ year_2019_list

dow_df['date_s'] = years_list

dow_df['dow'] = dow_df['Day Number'].apply(lambda x: days[(x-1)%7])

weekend = ['Saturday', 'Sunday']

dow_df['weekend'] = dow_df['dow'].apply(lambda x:1 if x in weekend else 0)

dow_df.to_csv('Calender 2015-2019.csv', index = False)

