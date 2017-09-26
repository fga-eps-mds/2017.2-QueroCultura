from pymongo import MongoClient
from .api import MapPointsApi
from .models import MapPoint


class MapPointsDao(object):

    def __init__(self):
        self._databaseName = "teste-database"
        self._connection = MongoClient('localhost', 27017)
        self._db = self._connection[self._databaseName]
        self._employees = self._db['employees']

    @property
    def employees(self):
        return self._employees

    def saveMapPoints(self):
        if MapPointsApi().response.status_code == 200:
            self._employees.insert(MapPointsApi().data)
