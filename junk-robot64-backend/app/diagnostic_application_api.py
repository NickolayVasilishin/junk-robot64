from flask import Flask
from flask_restful import Api
from flask_restful_swagger import swagger

app = Flask(__name__)
api = swagger.docs(Api(app), apiVersion='1', api_spec_url="/spec")

api.add_resource(Metrics,
                '/metrics/<string:component_id>/timeseries/<string:metric_name>',
                '/metrics/<string:component_id>/timeseries/<string:metric_name>/startdate/<int:start>/enddate/<int:end>')


api.add_resource(Model,
                '/model/<string:metric_name>')

@app.route('/')
def hello_world():
    return 'Hello, World!'


if __name__ == "__main__":
    app.run(threaded=True, debug=True, host='localhost', port=9999)
