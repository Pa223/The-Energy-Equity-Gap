# -*- coding: utf-8 -*-

import requests
from bs4 import BeautifulSoup
import re
import pandas as pd


temps_df = pd.DataFrame(columns=['Time','Time_in_hrs','Day','Month','Year','Temp_in_Fahrenheit', 'Year_month_day_time']) 


non_leap_year = {}
non_leap_year[1] = [i for i in range(1,32)]
non_leap_year[2] = [i for i in range(1,29)]
non_leap_year[3] = [i for i in range(1,32)]
non_leap_year[4] = [i for i in range(1,31)]
non_leap_year[5] = [i for i in range(1,32)]
non_leap_year[6] = [i for i in range(1,31)]
non_leap_year[7] = [i for i in range(1,32)]
non_leap_year[8] = [i for i in range(1,32)]
non_leap_year[9] = [i for i in range(1,31)]
non_leap_year[10] = [i for i in range(1,32)]
non_leap_year[11] = [i for i in range(1,31)]
non_leap_year[12] = [i for i in range(1,32)]

leap_year = {}
leap_year[1] = [i for i in range(1,32)]
leap_year[2] = [i for i in range(1,30)]
leap_year[3] = [i for i in range(1,32)]
leap_year[4] = [i for i in range(1,31)]
leap_year[5] = [i for i in range(1,32)]
leap_year[6] = [i for i in range(1,31)]
leap_year[7] = [i for i in range(1,32)]
leap_year[8] = [i for i in range(1,32)]
leap_year[9] = [i for i in range(1,31)]
leap_year[10] = [i for i in range(1,32)]
leap_year[11] = [i for i in range(1,31)]
leap_year[12] = [i for i in range(1,32)]

year_2019 = {}
year_2019[1] = [i for i in range(1,32)]
year_2019[2] = [i for i in range(1,29)]
year_2019[3] = [i for i in range(1,32)]
year_2019[4] = [i for i in range(1,31)]

year_2015 = {}
year_2015[1] = [i for i in range(2,32)]
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

day = 1
year = 2015
month = 1
if len(str(day)) == 1:
    day_s = '0' + str(day)
else:
    day_s = str(day)
if len(str(month)) == 1:
    month_s = '0' + str(month)
else:
    month_s = str(month)
year_s = str(year)
        
httpString ='https://www.weatherforyou.com/reports/index.php?forecast=pass&pass=archivenws&zipcode=&pands=arizona+state+university%2Carizona&place=arizona+state+university&state=az&icao=KPHX&country=us&month='+month_s+'&day='+day_s+'&year='+year_s+'&dosubmit=Go'
print(httpString)

page = requests.get(httpString)
soup = BeautifulSoup(page.content, 'html.parser')

mpc=soup.find(id='middlepagecontent')

tbody1 = mpc.select('tr')

pattern_time = r'[0-9]{1,2}:[0-9][0-9][A-Z]{2}'
pattern_temp = r'">[0-9]{1,3}.F'


temps = []
for a in tbody1:
    b = str(a)
    if re.search(pattern_time, b) != None and re.search(pattern_temp, b) != None:  
        temps.append(b)

temps_updated = temps[1:]

counter = 0
time_checker = {}
for a in temps_updated:
    attempt_time = re.search(pattern_time, a)
    attempt_temp = re.search(pattern_temp, a)
    time_word = a[attempt_time.start():attempt_time.end()]
    temp_word = int(a[attempt_temp.start()+2:attempt_temp.end()-2].strip())
    if time_word[-2:] == 'AM' and int(time_word[:-5]) == 12:
        time_word_hr = 1 
    elif time_word[-2:] == 'PM' and int(time_word[:-5]) == 12:
        time_word_hr = int(time_word[:-5])+1
    elif time_word[-2:] == 'PM':
        time_word_hr = int(time_word[:-5])+13
    else:
        time_word_hr = int(time_word[:-5]) + 1
    if time_word_hr not in time_checker.keys():
        time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
        if len(str(time_word_hr)) == 1:
            time_word_hr_s = '0' + str(time_word_hr)
        else:
            time_word_hr_s = str(time_word_hr)
        if len(str(day)) == 1:
            day_s = '0' + str(day)
        else:
            day_s = str(day)
        if len(str(month)) == 1:
            month_s = '0' + str(month)
        else:
            month_s = str(month)
        ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)
        temps_df.loc[counter] = [time_word, time_word_hr, day, month, year, temp_word, ymdt]
        counter+=1
    else:
        continue


for year in range(2015, 2020):
    if year == 2015:
        for month in year_2015.keys():
            for day in year_2015[month]:
                year_s = str(year)
                if len(str(day)) == 1:
                    day_s = '0' + str(day)
                else:
                    day_s = str(day)
                if len(str(month)) == 1:
                    month_s = '0' + str(month)
                else:
                    month_s = str(month)
                    
                
                httpString ='https://www.weatherforyou.com/reports/index.php?forecast=pass&pass=archivenws&zipcode=&pands=arizona+state+university%2Carizona&place=arizona+state+university&state=az&icao=KPHX&country=us&month='+month_s+'&day='+day_s+'&year='+year_s+'&dosubmit=Go'
                print(httpString)
                
                page = requests.get(httpString)
                soup = BeautifulSoup(page.content, 'html.parser')
                
                mpc=soup.find(id='middlepagecontent')
                
                tbody1 = mpc.select('tr')
                
                temps = []
                for a in tbody1:
                    b = str(a)
                    if re.search(pattern_time, b) != None and re.search(pattern_temp, b) != None:  
                        temps.append(b)
                
                temps_updated = temps[1:]
                
                time_checker = {}
                for a in temps_updated:
                    attempt_time = re.search(pattern_time, a)
                    attempt_temp = re.search(pattern_temp, a)
                    time_word = a[attempt_time.start():attempt_time.end()]
                    temp_word = int(a[attempt_temp.start()+2:attempt_temp.end()-2].strip())
                    
                    if time_word[-2:] == 'AM' and int(time_word[:-5]) == 12:
                        time_word_hr = 1 
                    elif time_word[-2:] == 'PM' and int(time_word[:-5]) == 12:
                        time_word_hr = int(time_word[:-5])+1
                    elif time_word[-2:] == 'PM':
                        time_word_hr = int(time_word[:-5])+13
                    else:
                        time_word_hr = int(time_word[:-5]) + 1
                        
                    if time_word_hr not in time_checker.keys():
                        if time_word_hr == 24 and day == 1 and month == 1:
                            day_df = day
                            month_df = month
                            year_df = year
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day_df)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month_df)
                            else:
                                month_s = str(month)
                            ymdt = str(year_df) + str(month_s) + str(day_s) + str(time_word_hr_s)
                            temps_df.loc[counter] = [time_word, time_word_hr, day_df, month_df, year_df, temp_word, ymdt]
                        elif time_word_hr == 24 and day == 1:
                            day_df = day
                            month_df = month
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day_df)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month_df)
                            else:
                                month_s = str(month)
                            ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)
                            temps_df.loc[counter] = [time_word, time_word_hr, day_df, month_df, year, temp_word, ymdt]
                        elif time_word_hr == 24:
                            day_df = day
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day_df)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month)
                            else:
                                month_s = str(month)
                            ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)
                            temps_df.loc[counter] = [time_word, time_word_hr, day_df, month, year, temp_word, ymdt]    
                        else:
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month)
                            else:
                                month_s = str(month)
                            ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)            
                            temps_df.loc[counter] = [time_word, time_word_hr, day, month, year, temp_word, ymdt]
                        counter+=1
                    else:
                        continue
    elif year == 2016:
        for month in leap_year.keys():
            for day in leap_year[month]:
                year_s = str(year)
                if len(str(day)) == 1:
                    day_s = '0' + str(day)
                else:
                    day_s = str(day)
                if len(str(month)) == 1:
                    month_s = '0' + str(month)
                else:
                    month_s = str(month)
                    
                
                httpString ='https://www.weatherforyou.com/reports/index.php?forecast=pass&pass=archivenws&zipcode=&pands=arizona+state+university%2Carizona&place=arizona+state+university&state=az&icao=KPHX&country=us&month='+month_s+'&day='+day_s+'&year='+year_s+'&dosubmit=Go'
                print(httpString)
                
                page = requests.get(httpString)
                soup = BeautifulSoup(page.content, 'html.parser')
                
                mpc=soup.find(id='middlepagecontent')
                
                tbody1 = mpc.select('tr')
                
                temps = []
                for a in tbody1:
                    b = str(a)
                    if re.search(pattern_time, b) != None and re.search(pattern_temp, b) != None:  
                        temps.append(b)
                
                temps_updated = temps[1:]
                
                time_checker = {}
                for a in temps_updated:
                    attempt_time = re.search(pattern_time, a)
                    attempt_temp = re.search(pattern_temp, a)
                    time_word = a[attempt_time.start():attempt_time.end()]
                    temp_word = int(a[attempt_temp.start()+2:attempt_temp.end()-2].strip())
                    
                    if time_word[-2:] == 'AM' and int(time_word[:-5]) == 12:
                        time_word_hr = 1 
                    elif time_word[-2:] == 'PM' and int(time_word[:-5]) == 12:
                        time_word_hr = int(time_word[:-5])+1
                    elif time_word[-2:] == 'PM':
                        time_word_hr = int(time_word[:-5])+13
                    else:
                        time_word_hr = int(time_word[:-5]) + 1
                        
                    if time_word_hr not in time_checker.keys():
                        if time_word_hr == 24 and day == 1 and month == 1:
                            day_df = day
                            month_df = month
                            year_df = year
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day_df)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month_df)
                            else:
                                month_s = str(month)
                            ymdt = str(year_df) + str(month_s) + str(day_s) + str(time_word_hr_s)
                            temps_df.loc[counter] = [time_word, time_word_hr, day_df, month_df, year_df, temp_word, ymdt]
                        elif time_word_hr == 24 and day == 1:
                            day_df = day
                            month_df = month
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day_df)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month_df)
                            else:
                                month_s = str(month)
                            ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)
                            temps_df.loc[counter] = [time_word, time_word_hr, day_df, month_df, year, temp_word, ymdt]
                        elif time_word_hr == 24:
                            day_df = day
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day_df)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month)
                            else:
                                month_s = str(month)
                            ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)
                            temps_df.loc[counter] = [time_word, time_word_hr, day_df, month, year, temp_word, ymdt]    
                        else:
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month)
                            else:
                                month_s = str(month)
                            ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)            
                            temps_df.loc[counter] = [time_word, time_word_hr, day, month, year, temp_word, ymdt]
                        counter+=1
                    else:
                        continue      
    elif year == 2019:
        for month in year_2019.keys():
            for day in year_2019[month]:
                year_s = str(year)
                if len(str(day)) == 1:
                    day_s = '0' + str(day)
                else:
                    day_s = str(day)
                if len(str(month)) == 1:
                    month_s = '0' + str(month)
                else:
                    month_s = str(month)
                    
                
                httpString ='https://www.weatherforyou.com/reports/index.php?forecast=pass&pass=archivenws&zipcode=&pands=arizona+state+university%2Carizona&place=arizona+state+university&state=az&icao=KPHX&country=us&month='+month_s+'&day='+day_s+'&year='+year_s+'&dosubmit=Go'
                print(httpString)
                
                page = requests.get(httpString)
                soup = BeautifulSoup(page.content, 'html.parser')
                
                mpc=soup.find(id='middlepagecontent')
                
                tbody1 = mpc.select('tr')
                
                temps = []
                for a in tbody1:
                    b = str(a)
                    if re.search(pattern_time, b) != None and re.search(pattern_temp, b) != None:  
                        temps.append(b)
                
                temps_updated = temps[1:]
                
                time_checker = {}
                for a in temps_updated:
                    attempt_time = re.search(pattern_time, a)
                    attempt_temp = re.search(pattern_temp, a)
                    time_word = a[attempt_time.start():attempt_time.end()]
                    temp_word = int(a[attempt_temp.start()+2:attempt_temp.end()-2].strip())
                    
                    if time_word[-2:] == 'AM' and int(time_word[:-5]) == 12:
                        time_word_hr = 1 
                    elif time_word[-2:] == 'PM' and int(time_word[:-5]) == 12:
                        time_word_hr = int(time_word[:-5])+1
                    elif time_word[-2:] == 'PM':
                        time_word_hr = int(time_word[:-5])+13
                    else:
                        time_word_hr = int(time_word[:-5]) + 1
                        
                    if time_word_hr not in time_checker.keys():
                        if time_word_hr == 24 and day == 1 and month == 1:
                            day_df = day
                            month_df = month
                            year_df = year
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day_df)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month_df)
                            else:
                                month_s = str(month)
                            ymdt = str(year_df) + str(month_s) + str(day_s) + str(time_word_hr_s)
                            temps_df.loc[counter] = [time_word, time_word_hr, day_df, month_df, year_df, temp_word, ymdt]
                        elif time_word_hr == 24 and day == 1:
                            day_df = day
                            month_df = month
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day_df)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month_df)
                            else:
                                month_s = str(month)
                            ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)
                            temps_df.loc[counter] = [time_word, time_word_hr, day_df, month_df, year, temp_word, ymdt]
                        elif time_word_hr == 24:
                            day_df = day
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day_df)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month)
                            else:
                                month_s = str(month)
                            ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)
                            temps_df.loc[counter] = [time_word, time_word_hr, day_df, month, year, temp_word, ymdt]    
                        else:
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month)
                            else:
                                month_s = str(month)
                            ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)            
                            temps_df.loc[counter] = [time_word, time_word_hr, day, month, year, temp_word, ymdt]
                        counter+=1
                    else:
                        continue

    else:
        for month in non_leap_year.keys():
            for day in non_leap_year[month]:
                year_s = str(year)
                if len(str(day)) == 1:
                    day_s = '0' + str(day)
                else:
                    day_s = str(day)
                if len(str(month)) == 1:
                    month_s = '0' + str(month)
                else:
                    month_s = str(month)
                    
                
                httpString ='https://www.weatherforyou.com/reports/index.php?forecast=pass&pass=archivenws&zipcode=&pands=arizona+state+university%2Carizona&place=arizona+state+university&state=az&icao=KPHX&country=us&month='+month_s+'&day='+day_s+'&year='+year_s+'&dosubmit=Go'
                print(httpString)
                
                page = requests.get(httpString)
                soup = BeautifulSoup(page.content, 'html.parser')
                
                mpc=soup.find(id='middlepagecontent')
                
                tbody1 = mpc.select('tr')
                
                temps = []
                for a in tbody1:
                    b = str(a)
                    if re.search(pattern_time, b) != None and re.search(pattern_temp, b) != None:  
                        temps.append(b)
                
                temps_updated = temps[1:]
                
                time_checker = {}
                for a in temps_updated:
                    attempt_time = re.search(pattern_time, a)
                    attempt_temp = re.search(pattern_temp, a)
                    time_word = a[attempt_time.start():attempt_time.end()]
                    temp_word = int(a[attempt_temp.start()+2:attempt_temp.end()-2].strip())
                    
                    if time_word[-2:] == 'AM' and int(time_word[:-5]) == 12:
                        time_word_hr = 1 
                    elif time_word[-2:] == 'PM' and int(time_word[:-5]) == 12:
                        time_word_hr = int(time_word[:-5])+1
                    elif time_word[-2:] == 'PM':
                        time_word_hr = int(time_word[:-5])+13
                    else:
                        time_word_hr = int(time_word[:-5]) + 1
                        
                    if time_word_hr not in time_checker.keys():
                        if time_word_hr == 24 and day == 1 and month == 1:
                            day_df = day
                            month_df = month
                            year_df = year
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day_df)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month_df)
                            else:
                                month_s = str(month)
                            ymdt = str(year_df) + str(month_s) + str(day_s) + str(time_word_hr_s)
                            temps_df.loc[counter] = [time_word, time_word_hr, day_df, month_df, year_df, temp_word, ymdt]
                        elif time_word_hr == 24 and day == 1:
                            day_df = day
                            month_df = month
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day_df)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month_df)
                            else:
                                month_s = str(month)
                            ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)
                            temps_df.loc[counter] = [time_word, time_word_hr, day_df, month_df, year, temp_word, ymdt]
                        elif time_word_hr == 24:
                            day_df = day
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day_df)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month)
                            else:
                                month_s = str(month)
                            ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)
                            temps_df.loc[counter] = [time_word, time_word_hr, day_df, month, year, temp_word, ymdt]    
                        else:
                            time_checker[time_word_hr] = [time_word, time_word_hr, temp_word]
                            if len(str(time_word_hr)) == 1:
                                time_word_hr_s = '0' + str(time_word_hr)
                            else:
                                time_word_hr_s = str(time_word_hr)
                            if len(str(day)) == 1:
                                day_s = '0' + str(day)
                            else:
                                day_s = str(day)
                            if len(str(month)) == 1:
                                month_s = '0' + str(month)
                            else:
                                month_s = str(month)
                            ymdt = str(year) + str(month_s) + str(day_s) + str(time_word_hr_s)            
                            temps_df.loc[counter] = [time_word, time_word_hr, day, month, year, temp_word, ymdt]
                        counter+=1
                    else:
                        continue

print(temps_df)

temps_df.to_csv('Temp Data.csv', index = False)
