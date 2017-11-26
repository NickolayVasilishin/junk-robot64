from flask_restful import Resource, abort
from flask import jsonify, request
from flask_restful_swagger import swagger

import pandas as pd
import numpy as np


class Metrics(Resource):

    def get_data(self):
        labs_path = '/home/nikolay/study/junction/junk-robot64/junk-robot64-backend/resources/datasamples/labs_43'
        lab = pd.read_csv(labs_path)
        del lab['diabetes_patients.diabetic_id']
        lab.columns = [column.split('.')[1] for column in lab.columns]
        person_stats = lab[
            ['person_id', 'gender', 'date_of_birth', 'date_of_death', 'municipality_code', 'population_density',
             'postal_code', 'diabetic_id']].iloc[0]
        diabetics_history = lab[[column for column in lab.columns if column not in person_stats]]
        diabetics_history.measurement_time = pd.to_datetime(diabetics_history.measurement_time,
                                                            format='%Y-%m-%d %H:%M:%S')
        diabetics_history = diabetics_history.set_index('measurement_time')
        reshaped = diabetics_history.pivot_table(
            values=['result', 'reference_min', 'reference_max', 'outside_ref_values', 'unit'],
            index=diabetics_history.index,
            columns='measurement_code',
            aggfunc='first')
        result = self.get_most_valuable_json(reshaped, 4)
        return person_stats, result


    @classmethod
    def get_most_valuable_json(cls, reshaped, number):
        measurement_codes = reshaped.count().nlargest(number * 4).index.get_level_values(1).unique()
        result = {}
        for feature, code in reshaped.columns:
            if code in measurement_codes:
                if code not in result:
                    result[code] = {'reference_max': None, 'reference_min': None, 'unit': None, 'data': None}
                if feature in ['unit', 'reference_max', 'reference_min']:
                    result[code][feature] = reshaped[feature][code].loc[reshaped[feature][code].first_valid_index()]
                else:
                    data = reshaped[feature][code].copy()
                    data.index = data.index.astype(np.int64) // 10 ** 9
                    print(data.reset_index())
                    result[code]['data'] = data.interpolate().fillna(method='bfill').reset_index().as_matrix().tolist()

        for key in result:
            result[key]['name'] = key

        print(result.values())
        return list(result.values())

    def include_request_args(*args, **kwargs):
        return request.url

    @swagger.operation(
        notes="Retrieves list of metrics for each component_id",
        nickname='metrics',
        parameters=[]
    )
    def get(self):
        """Get method for the metrics endpoint
        """


        if True:
            person, data = self.get_data()
            print(person, data)
            return jsonify(data)
        else:
            abort(404, message="Component not found")