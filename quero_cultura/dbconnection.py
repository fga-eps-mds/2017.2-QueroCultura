import json
import requests
import pprint
from pymongo import MongoClient


class DbConnection(object):

    __mongo_connection = None
    # mongo_connection will recebe the database
    __db = None
    __url = 'http://mapas.cultura.gov.br/api/agent/find/'

    def __init__(self, name_database):
        self.__mongo_connection = MongoClient('localhost',27017)
        self.__mongo_connection = self.__mongo_connection.test_database
        self.__db = self.__mongo_connection[name_database]

    def get_agents(self,id):
        parameters = {'@select': 'id,name','id' : id}
        response = requests.get(self.__url, parameters)
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

    #Only to check the database's working
    def show_results(self):
        results = self.__db.find()
        for element in results:
            pprint.pprint(element)
        #self.__db.close()


    def insert_point_map(self, map_point):
            data = [{'_id' : map_point.idPoint,
                     'type' : map_point.typePoint,
                     'name' : map_point.namePoint,
                     'latitude' : map_point.latitudePoint,
                     'longitude' : map_point.longitudePoint,
                     'description' : map_point.shortDescription
                      }]
            self.__db.insert(data)

    def select_point_map(self, map_point_id):
            pprint.pprint(result)
            result = list(self.__db.find({"_id": map_point_id}))
            #print(result)

    def delete_point_map(self, map_point_id):
            result = list(self.__db.find({"_id": map_point_id}))
            self.__db.delete_one({"_id": map_point_id})
