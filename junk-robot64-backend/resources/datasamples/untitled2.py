#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov 25 12:29:35 2017

@author: nikolay
"""

import pandas as pd
import numpy as np

medications_path = '/home/nikolay/study/junction/junk-robot64/junk-robot64-backend/resources/datasamples/medications_43'
labs_path = '/home/nikolay/study/junction/junk-robot64/junk-robot64-backend/resources/datasamples/labs_43'

med = pd.read_csv(medications_path)
lab = pd.read_csv(labs_path)

del lab['diabetes_patients.diabetic_id']
lab.columns = [column.split('.')[1] for column in lab.columns]

person_stats = lab[['person_id', 'gender', 'date_of_birth', 'date_of_death', 'municipality_code', 'population_density', 'postal_code', 'diabetic_id']].iloc[0]

diabetics_history = lab[[column for column in lab.columns if column not in person_stats]]
diabetics_history.measurement_time = pd.to_datetime(diabetics_history.measurement_time, format='%Y-%m-%d %H:%M:%S')
diabetics_history = diabetics_history.set_index('measurement_time')

reshaped = diabetics_history.pivot_table(
        values=['result', 'reference_min', 'reference_max', 'outside_ref_values', 'unit'], 
        index=diabetics_history.index, 
        columns='measurement_code', 
        aggfunc='first')

def get_most_valuable_json(reshaped, number):
    measurement_codes = reshaped.count().nlargest(number*4).index.get_level_values(1).unique()
    result = {}
    for feature, code in reshaped.columns:
        if code in measurement_codes:
            if code not in result:
                result[code] = {'reference_max':None, 'reference_min':None, 'unit':None, 'data':None}
            if feature in ['unit', 'reference_max', 'reference_min']:
                result[code][feature] = reshaped[feature][code].loc[reshaped[feature][code].first_valid_index()]
            else:
                data = reshaped[feature][code].copy()
                data.index = data.index.astype(np.int64) // 10 ** 9
                result[code]['data'] = data.interpolate().reset_index().as_matrix()
                
    return result
    
    
    
    


def pickle_model(version):
    
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.datasets import make_classification
    
    X = lab[['result', 'reference_min', 'reference_max', 'outside_ref_values']]
    X = X.dropna(how='any')
    X, y = X[['result', 'reference_min', 'reference_max']], X[['outside_ref_values']]
    #y = y.astype('category')
    #y.cat.categories = [0, 1]
    
    
    X, X_test = X.as_matrix()[:-1], X.as_matrix()[-1]
    y, y_test = y.as_matrix()[:-1], y.as_matrix()[-1]
    
    clf = RandomForestClassifier(max_depth=2, random_state=0)
    clf.fit(X, y)
    print(clf.predict(X_test))
    print(y_test)
    
    import pickle
    with open('kek_model.pkl-v%s' % version, 'wb') as f:
        pickle.dump(clf, f, protocol=version)
    #from sklearn.externals import joblib
    #joblib.dump(clf, 'kek_model1.pcl') 
    """
    
    E-MCH (1558)
    """