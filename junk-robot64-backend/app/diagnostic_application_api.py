from flask import Flask
from flask_restful import Api
from flask_restful_swagger import swagger

from app.endpoint.Person import Person
from app.endpoint.Metrics import Metrics

app = Flask(__name__)
api = swagger.docs(Api(app), apiVersion='1', api_spec_url="/spec")

api.add_resource(Metrics, '/metrics')
api.add_resource(Person, '/person')

#
# api.add_resource(Model,
#                 '/model/<string:metric_name>')

@app.route('/')
def hello_world():
    return 'Hello, World!'


if __name__ == "__main__":
    app.run(threaded=True, debug=True, host='10.100.31.96', port=9999)
