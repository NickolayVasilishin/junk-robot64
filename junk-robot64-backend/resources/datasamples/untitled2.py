#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov 25 12:29:35 2017

@author: nikolay
"""

import pandas as pd
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
        values=['result', 'reference_min', 'reference_max', 'outside_ref_values'], 
        index=diabetics_history.index, 
        columns='measurement_code', 
        aggfunc='first')



def pickle_model():
    
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
    with open('kek_model.pkl0', 'wb') as f:
        pickle.dump(clf, f, protocol=0)
    #from sklearn.externals import joblib
    #joblib.dump(clf, 'kek_model1.pcl') 
    """
    
    E-MCH (1558)
    """