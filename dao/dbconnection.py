import json
import requests
#from mongoengine import *
import pprint
from pymongo import MongoClient

client = MongoClient('localhost',27017)
db = client.test_database

collection = db["trainning"]

#########################################################
#connect('training_DB', username='root', password='root')

#class Training(Document):
#    _id = IntField(required=True)
#    name = StringField(max_length=100)
#########################################################

url = 'http://mapas.cultura.gov.br/api/agent/find/'

parameters = {'@select': 'id,name','id': 'BET(111683,111684)'}

response = requests.get(url,parameters)

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
