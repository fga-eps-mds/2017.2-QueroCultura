from models import MapPoint
from dbconnection import DbConnection

database = DbConnection('Iago_teste')

mapa = MapPoint(typePoint = "Cookie",
                idPoint = 12345678,
                namePoint = "Asdf",
                latitudePoint = "15",
                longitudePoint = "97",
                shortDescription = "Asdffdsa")
mapa2 = MapPoint(typePoint = "Cookie",
                 idPoint = 1234567,
                 namePoint = "Asdf",
                 latitudePoint = "15",
                 longitudePoint = "97",
                 shortDescription = "Asdffdsa")

#database.insert_point_map(mapa)
#database.insert_point_map(mapa2)
#database.show_results()
#database.select_point_map(12345678)
#database.delete_point_map(2345678)
database.delete_all_point_map()
database.show_results()
