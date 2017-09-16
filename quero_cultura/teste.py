from models import MapPoint
from dbconnection import DbConnection

database = DbConnection('Iago_teste')

mapa = MapPoint(typePoint = "Cookie",
                idPoint = 2345678,
                namePoint = "Asdf",
                latitudePoint = "15",
                longitudePoint = "97",
                shortDescription = "Asdffdsa")

database.insert_point_map(mapa)
database.show_results()
