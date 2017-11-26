from flask_restful import Resource, abort
from flask import jsonify, request
from flask_restful_swagger import swagger

import pandas as pd
import numpy as np


class Person(Resource):

    def get_data(self):
        labs_path = '/home/nikolay/study/junction/junk-robot64/junk-robot64-backend/resources/datasamples/labs_43'
        lab = pd.read_csv(labs_path)
        del lab['diabetes_patients.diabetic_id']
        lab.columns = [column.split('.')[1] for column in lab.columns]
        person_stats = lab[
            ['person_id', 'gender', 'date_of_birth', 'date_of_death', 'municipality_code', 'population_density',
             'postal_code', 'diabetic_id']].iloc[0].to_json()
        print(person_stats)
        return person_stats


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
            person= self.get_data()
            return jsonify(person)
        else:
            abort(404, message="Component not found")