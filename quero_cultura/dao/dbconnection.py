import json
import requests
#from mongoengine import *
import pprint
from pymongo import MongoClient


class DbConnection(object):

    __mongo_connection = None
    # mongo_connection will recebe the database
    __db = None
    #__url = 'http://mapas.cultura.gov.br/api/agent/find/'

    def __init__(self):
        self.__mongo_connection = MongoClient('localhost',27017)
        self.__mongo_connection = self.__mongo_connection.test_database
        self.__db = self.__mongo_connection['quero_cultura_db']

    def get_agents(self,id):
        parameters = {'@select': 'id,name','id' : id}
        response = requests.get('http://mapas.cultura.gov.br/api/agent/find/',parameters)
        return response

    def check_connection(self,response):
        verify_connection = True

        if(response.status_code == 200):
            verify_connection = True
        else:
            verify_connection = False

        return verify_connection

    def insert_agent(self,response):
        if(self.check_connection(response) == True):
            data = json.loads(response.text)
            self.__db.insert(data)
            print("deu bom")
        else:
            print("deu ruim")

    def show_results(self):
        peeps = self.__db.find()
        for agents in peeps:
            pprint.pprint(agents)
        #self.__db.close()

#TEST:
#qualquer = DbConnection()
#teste = qualquer.get_agents('BET(111683,111684)')
#qualquer.insert_agent(teste)
#qualquer.show_results()
