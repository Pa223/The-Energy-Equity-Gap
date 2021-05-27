# -*- coding: utf-8 -*-


import pandas as pd

temp = pd.read_csv('Temp Data.csv')
temp = temp.astype({'ymdtc': str})
temp['date_s'] = temp['ymdtc'].apply(lambda x:x[:8])
temp_avg = temp.groupby(['date_s']).mean()
temp_avg = temp_avg['Temp_in_Fahrenheit']

calendar = pd.read_csv('Calender 2015-2019.csv')
calendar['date_s'] = calendar['date_s'].apply(lambda x:str(x))

f = pd.read_stata('control2015.dta')
#f.columns
f.drop(columns = ['LOCATN_K','MTR_NB','CHNM'], inplace = True)
f = f[f['he01'] != 'NULL']
f = f[f['he02'] != 'NULL']
f = f[f['he03'] != 'NULL']
f = f[f['he04'] != 'NULL']
f = f[f['he05'] != 'NULL']
f = f[f['he06'] != 'NULL']
f = f[f['he07'] != 'NULL']
f = f[f['he08'] != 'NULL']
f = f[f['he09'] != 'NULL']
f = f[f['he10'] != 'NULL']
f = f[f['he11'] != 'NULL']
f = f[f['he12'] != 'NULL']
f = f[f['he13'] != 'NULL']
f = f[f['he14'] != 'NULL']
f = f[f['he15'] != 'NULL']
f = f[f['he16'] != 'NULL']
f = f[f['he17'] != 'NULL']
f = f[f['he18'] != 'NULL']
f = f[f['he19'] != 'NULL']
f = f[f['he20'] != 'NULL']
f = f[f['he21'] != 'NULL']
f = f[f['he22'] != 'NULL']
f = f[f['he23'] != 'NULL']
f = f[f['he24'] != 'NULL']
f = f.astype({'he01':float,'he02':float,'he03':float,'he04':float,'he05':float,'he06':float,'he07':float,'he08':float,'he09':float,'he10':float,'he11':float,'he12':float,'he13':float,'he14':float,'he15':float,'he16':float,'he17':float,'he18':float,'he19':float,'he20':float,'he21':float,'he22':float,'he23':float,'he24':float})
f['he_d'] = f['he01'] + f['he02'] +f['he03'] +f['he04'] +f['he05'] +f['he06'] +f['he07'] +f['he08'] +f['he09'] +f['he10'] +f['he11'] +f['he12'] +f['he13'] +f['he14'] +f['he15'] +f['he16'] +f['he17'] +f['he18'] +f['he19'] +f['he20'] +f['he21'] +f['he22'] +f['he23'] +f['he24'] 
f['date_s'] = f['DATE'].apply(lambda x: x[:4] + x[5:7] + x[8:])
f.drop(columns = ['he01','he02','he03','he04','he05','he06','he07','he08','he09','he10','he11','he12','he13','he14','he15','he16','he17','he18','he19','he20','he21','he22','he23','he24',], inplace = True)
f.drop(columns = ['DATE'], inplace = True)

f = f.set_index('date_s').join(temp_avg)
f.rename({'Temp_in_Fahrenheit':'temp_avg'}, axis = 1, inplace = True)
f.reset_index(inplace = True)

f['month'] = f['date_s'].apply(lambda x: x[4:6])
f = f.astype({'month':int})
f['summer'] = f['month'].apply(lambda x: 1 if (x in [5,6,9,10]) else 0)
f['winter'] = f['month'].apply(lambda x: 1 if (x in [11,12,1,2,3,4]) else 0)
f['summer_peak'] = f['month'].apply(lambda x: 1 if (x in [7,8]) else 0)

f_s = f[f['summer'] == 1]
f_w = f[f['winter'] == 1]
f_sp = f[f['summer_peak'] == 1]

f = f[['date_s', 'BILACCT_K', 'RATE', 'he_d', 'temp_avg', 'month', 'summer', 'winter', 'summer_peak']]
f = f[f['RATE'] != 'NU']

f = f.set_index('date_s').join(calendar.set_index('date_s'))
f.drop(columns= ['Day Number'], inplace = True)
f.reset_index(inplace = True)

f['month'] = f['month'].apply(lambda x:int(x))
f = pd.get_dummies(f, columns = ['dow'], drop_first = False, prefix = 'dow')
f = pd.get_dummies(f, columns = ['month'], drop_first = False, prefix = 'month')

f['month'] = f['date_s'].apply(lambda x:x[4:6])
f['month'] = f['month'].apply(lambda x:int(x))

def holiday(x):
    if x == '20150525':
        return 1
    elif x == '20150907':
        return 1
    elif x == '20151126':
        return 1
    elif x == '20150101':
        return 1
    elif x == '20150704':
        return 1
    elif x == '20151225':
        return 1

    elif x == '20160530':
        return 1
    elif x == '20160905':
        return 1
    elif x == '20161124':
        return 1
    elif x == '20160101':
        return 1
    elif x == '20160704':
        return 1
    elif x == '20161225':
        return 1
            
    elif x == '20170529':
        return 1
    elif x == '20170904':
        return 1
    elif x == '20171123':
        return 1
    elif x == '20170102':
        return 1
    elif x == '20170704':
        return 1
    elif x == '20171225':
        return 1
    
    elif x == '20180528':
        return 1
    elif x == '20180903':
        return 1
    elif x == '20181128':
        return 1
    elif x == '20180101':
        return 1
    elif x == '20180704':
        return 1
    elif x == '20181225':
        return 1
            
    elif x == '20190101':
        return 1
    else:
        return 0

f['holiday'] = f['date_s'].apply(holiday)

f['temp_avg_sq'] = f['temp_avg']*f['temp_avg']

f = f.astype({'month':int})
f = f.astype({'weekend':int})
f = f.astype({'RATE':str})
f = f.astype({'holiday':int})

f.columns


f['On-peak D'] = f['weekend'] + f['holiday']
f['On-peak Day'] = f['On-peak D'].apply(lambda x:0 if (x >= 1) else 1)
f['Off-peak Day'] = f['On-peak D'].apply(lambda x:1 if (x >= 1) else 0)
f['W_On-peak Day'] = f['winter']*f['On-peak Day']
f['W_Off-peak Day'] = f['winter']*f['Off-peak Day']
f['S_On-peak Day'] = f['summer']*f['On-peak Day']
f['S_Off-peak Day'] = f['summer']*f['Off-peak Day']
f['SP_On-peak Day'] = f['summer_peak']*f['On-peak Day']
f['SP_Off-peak Day'] = f['summer_peak']*f['Off-peak Day']

f['W_On-peak Day_s'] = f['W_On-peak Day'].apply(lambda x: 'W_On-peak' if (x==1) else '')
f['W_Off-peak Day_s'] = f['W_Off-peak Day'].apply(lambda x: 'W_Off-peak' if (x==1) else '')
f['S_On-peak Day_s'] = f['S_On-peak Day'].apply(lambda x: 'S_On-peak' if (x==1) else '')
f['S_Off-peak Day_s'] = f['S_Off-peak Day'].apply(lambda x: 'S_Off-peak' if (x==1) else '')
f['SP_On-peak Day_s'] = f['SP_On-peak Day'].apply(lambda x: 'SP_On-peak' if (x==1) else '')
f['SP_Off-peak Day_s'] = f['SP_Off-peak Day'].apply(lambda x: 'SP_Off-peak' if (x==1) else '')

#f[['date_s','S_Off-peak Day_s','S_On-peak Day_s']].iloc[20000:20050]


f['c_peak'] = f['W_On-peak Day_s'] + f['W_Off-peak Day_s'] + f['S_On-peak Day_s'] + f['S_Off-peak Day_s'] + f['SP_On-peak Day_s'] + f['SP_Off-peak Day_s'] 
f['RATE_peak'] = f['c_peak'] + f['RATE']

#f.groupby(['RATE_peak']).count()

br_21_s_onpd = round(((3/24)*0.3022) + ((21/24)*0.0829), 4)
br_21_s_offpd = 0.0829
br_21_sp_onpd = round(((3/24)*0.3577) + ((21/24)*0.0853), 4)
br_21_sp_offpd = 0.0853
br_21_w_onpd = round(((3/24)*0.1215) + ((21/24)*0.0758), 4)
br_21_w_offpd = 0.0758

br_22_s_onpd = round(((3/24)*0.3022) + ((21/24)*0.0829), 4)
br_22_s_offpd = 0.0829
br_22_sp_onpd = round(((3/24)*0.3577) + ((21/24)*0.0853), 4)
br_22_sp_offpd = 0.0853
br_22_w_onpd = round(((3/24)*0.1215) + ((21/24)*0.0758), 4)
br_22_w_offpd = 0.0758

br_23_s = 0.1091
br_23_sp = 0.1157
br_23_w = 0.0803

br_24_s = 0.1089
br_24_sp = 0.1159
br_24_s = 0.0942

br_25_s_onpd = round(((3/24)*0.3022) + ((21/24)*0.0829), 4)
br_25_s_offpd = 0.0829
br_25_sp_onpd = round(((3/24)*0.3577) + ((21/24)*0.0853), 4)
br_25_sp_offpd = 0.0853
br_25_w_onpd = round(((3/24)*0.1215) + ((21/24)*0.0758), 4)
br_25_w_offpd = 0.0758


br_26_s_onpd = round(((7/24)*0.1946) + ((17/24)*0.0727), 4)
br_26_s_offpd = 0.0727
br_26_sp_onpd = round(((7/24)*0.2215) + ((17/24)*0.0730), 4)
br_26_sp_offpd = 0.0730
br_26_w_onpd = round(((8/24)*0.1020) + ((16/24)*0.0711), 4)
br_26_w_offpd = 0.0711

br_29_s_onpd = round(((7/24)*0.1946) + ((11/24)*0.0765) + ((6/24)*0.0616), 4)
br_29_s_offpd = round(((18/24)*0.0765) + ((6/24)*0.0616), 4)
br_29_sp_onpd = round(((7/24)*0.2215) + ((11/24)*0.077) + ((6/24)*0.0619), 4)
br_29_sp_offpd = round(((18/24)*0.077) + ((6/24)*0.0619), 4)
br_29_w_onpd = round(((8/24)*0.102) + ((10/24)*0.0757) + ((6/24)*0.06), 4)
br_29_w_offpd = round(((18/24)*0.0757) + ((6/24)*0.06), 4)


def rate_peak(x):
    if x == 'SP_Off-peak21':
        return br_21_sp_offpd
    elif x == 'SP_Off-peak22':
        return br_22_sp_offpd
    elif x == 'SP_Off-peak23':
        return br_23_sp
    elif x == 'SP_Off-peak25':
        return br_25_sp_offpd
    elif x == 'SP_Off-peak26':
        return br_26_sp_offpd
    elif x == 'SP_Off-peak29':
        return br_29_sp_offpd
    elif x == 'SP_On-peak21':
        return br_21_sp_onpd
    elif x == 'SP_On-peak22':
        return br_22_sp_onpd 
    elif x == 'SP_On-peak23':
        return br_23_sp
    elif x == 'SP_On-peak25':
        return br_25_sp_onpd
    elif x == 'SP_On-peak26':
        return br_26_sp_onpd
    elif x == 'SP_On-peak29':
        return br_29_sp_onpd
    elif x == 'S_Off-peak21':
        return br_21_s_offpd
    elif x == 'S_Off-peak22':
        return br_22_s_offpd
    elif x == 'S_Off-peak23':
        return br_23_s
    elif x == 'S_Off-peak25':
        return br_25_s_offpd
    elif x == 'S_Off-peak26':
        return br_26_s_offpd
    elif x == 'S_Off-peak29':
        return br_29_s_offpd
    elif x == 'S_On-peak21':
        return br_21_s_onpd
    elif x == 'S_On-peak22':
        return br_22_s_onpd
    elif x == 'S_On-peak23':
        return br_23_s
    elif x == 'S_On-peak25':
        return br_25_s_onpd
    elif x == 'S_On-peak26':
        return br_26_s_onpd
    elif x == 'S_On-peak29':
        return br_29_s_onpd
    elif x == 'W_Off-peak21':
        return br_21_w_offpd
    elif x == 'W_Off-peak22':
        return br_22_w_offpd
    elif x == 'W_Off-peak23':
        return br_23_w
    elif x == 'W_Off-peak25':
        return br_25_w_offpd
    elif x == 'W_Off-peak26':
        return br_26_w_offpd
    elif x == 'W_Off-peak29':
        return br_29_w_offpd
    elif x == 'W_On-peak21':
        return br_21_w_onpd
    elif x == 'W_On-peak22':
        return br_22_w_onpd
    elif x == 'W_On-peak23':
        return br_23_w
    elif x == 'W_On-peak25':
        return br_25_w_onpd
    elif x == 'W_On-peak26':
        return br_26_w_onpd
    elif x == 'W_On-peak29':
        return br_29_w_onpd
        
f['elec_cost'] = f['RATE_peak'].apply(rate_peak)

f.drop(columns = ['On-peak D', 'On-peak Day', 'Off-peak Day', 'W_On-peak Day', 'W_Off-peak Day', 'S_On-peak Day', 'S_Off-peak Day', 'SP_On-peak Day', 'SP_Off-peak Day', 'W_On-peak Day_s', 'W_Off-peak Day_s', 'S_On-peak Day_s', 'S_Off-peak Day_s', 'SP_On-peak Day_s', 'SP_Off-peak Day_s', 'c_peak', 'RATE_peak'], inplace = True)

f_s = f[f['summer'] == 1]
f_w = f[f['winter'] == 1]
f_sp = f[f['summer_peak'] == 1]

f_w.to_stata('2015_w_daily.dta')
f_s.to_stata('2015_s_daily.dta')
f_sp.to_stata('2015_sp_daily.dta')

f_s = pd.read_stata('2015_2016_s_daily.dta')
f_w = pd.read_stata('2015_2016_w_daily.dta')
f_sp = pd.read_stata('2015_2016_sp_daily.dta')

f = pd.concat([f_s,f_w,f_sp])

f.sort_values(by=['date_s'], inplace=True)
f.drop(columns = ['index'], inplace = True)

f.to_stata('2015_2016_daily.dta')