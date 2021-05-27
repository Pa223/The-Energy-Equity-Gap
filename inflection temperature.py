# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
import sympy as sym
import matplotlib.pyplot as plt
from scipy import optimize
import seaborn as sns
from statsmodels.tsa.ar_model import AR
import statsmodels.api as sm
from statsmodels.tsa.api import VAR
from statsmodels.tsa.base.datetools import dates_from_str
from sklearn.linear_model import LinearRegression

survey = pd.read_stata('Survey.dta')
list(survey.columns)
survey['VRESIDENCE']
survey.groupby(['VRESIDENCE']).count()
survey['PRIMARY'] = survey['VRESIDENCE'].apply(lambda x: 1 if (x == 'Primary residence') else 0)
survey.groupby(['PRIMARY']).count()
survey = survey[survey['PRIMARY'] == 1]
primary_list = list(survey['BILACCT_K'])

def test_func(x, a, b, c):
    return a*(x**2) + (b*x) + c

f = pd.read_stata('2015-2016_daily.dta')
f.drop(columns = ['index'], inplace = True)
f.columns

f['PRIMARY'] = f['BILACCT_K'].apply(lambda x:1 if (x in primary_list) else 0)
f = f[f['PRIMARY'] == 1]
f = f[f['RATE'] != ' ']
f['RATE'] = f['RATE'].apply(lambda x: int(x))
f = f[f['RATE'] != 27]

c_c = f.groupby(['BILACCT_K']).count()
c_c = c_c[['date_s','RATE']]
c_c = c_c[c_c['date_s'] > 250]
c_c = list(c_c.index)

f['c_c'] = f['BILACCT_K'].apply(lambda x: 1 if (x in c_c) else 0)
f = f[f['c_c'] == 1]


inf_list = []
counter = 1
for a in c_c:
    g = f[f['BILACCT_K'] == a]
    if max(list(f[f['BILACCT_K'] == a]['he_d'])) >= 0.05:
        y = g['he_d'].astype(float).to_numpy() 
        x = g[['temp_avg','temp_avg_sq', 'elec_cost', 'weekend', 'holiday', 'dow_Friday', 'dow_Monday','dow_Saturday', 'dow_Sunday', 'dow_Thursday', 'dow_Tuesday', 'dow_Wednesday', 'month_1', 'month_2', 'month_3', 'month_4', 'month_5', 'month_6', 'month_7', 'month_8', 'month_9', 'month_10', 'month_11','month_12']].to_numpy()
    
        model = LinearRegression(fit_intercept= True).fit(x,y)    
        t_a = model.coef_[1]
        t_b = model.coef_[0]
        t_c = model.intercept_
    
        x = sym.Symbol('x')
        diff = sym.diff(t_a*(x**2) + (t_b*x) + t_c, x)
        sol = sym.solveset(diff, x)
        sol_l = list(sol)
        sol_daily_t = round(float(sol_l[0]), 3)
        inf_list.append([a, sol_daily_t])
    else:
        continue
    print(counter)
    counter += 1
    print(a)
    print('----------------------------')
    print('----------------------------')
    print('----------------------------')
    print()


inf_df = pd.DataFrame(inf_list, columns = ['BILACCT_K', 'inf_temp'])
inf_df.set_index(['BILACCT_K'], inplace = True)


inf_df.to_stata('Inflection Point Temperatures 2015-2016-p.dta')