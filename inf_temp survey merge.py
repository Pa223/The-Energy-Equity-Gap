# -*- coding: utf-8 -*-
"""
Created on Thu Aug 13 21:07:20 2020

@author: ali_1
"""

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

ret = pd.read_stata('Survey.dta')
ret.drop(columns = ['level_0', 'index'], inplace = True)
ret_list = list(ret.columns)

f = pd.read_stata('Inflection Point Temperatures 2015-2016.dta')
f = f.set_index('BILACCT_K').join(ret.set_index('BILACCT_K'))
f_list = list(f.columns)

f.to_stata('inf_temp_survey.dta')



