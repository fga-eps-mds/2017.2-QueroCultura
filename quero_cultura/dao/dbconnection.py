import json
import requests
#from mongoengine import *
import pprint
from pymongo import MongoClient

class DbConnection:

    __mongo_connection = MongoClient('localhost',27017)
    # mongo_connection will recebe the database
    __db = mongo_connection['quero_cultura_db']
    __url = 'http://mapas.cultura.gov.br/api/agent/find/'

    def __init__():

    def get_agents(self,name,id,inicial_valory_id,final_valory_id):
        parameters = {'@select': id,name,'id': BET(inicial_valory_id,final_valory_id)}
        response = requests.get(url,parameters)
        return response

#pprint.pprint(collection.find_one({"name": "WELLINGTON FRANCISCO DA SILVA"}))

if(response.status_code == 200):
    data = json.loads(response.text)
    peeps = collection.find()
    collection.insert(data)
#    for agent in peeps:
#    	print(agent)

for agents in peeps:
    pprint.pprint(agents)

x = collection.count()
print(x)
#client.drop_database("trainning")
#collection.delete_many({"name": "WELLINGTON FRANCISCO DA SILVA"})
#collection.delete_many({"name": "FRANCIVALDO ARAUJO DE ALMEIDA"})
