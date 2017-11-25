from flask_restful import Resource, abort
from flask import jsonify, request
from flask_restful_swagger import swagger


class Metrics(Resource):

    def include_request_args(*args, **kwargs):
        return request.url

    @swagger.operation(
        notes="Retrieves list of metrics for each component_id",
        nickname='metrics',
        parameters=[]
    )
    def get(self, component_id):
        """Get method for the metrics endpoint
        """
        if True:
            return jsonify(out)
        else:
            abort(404, message="Component not found")