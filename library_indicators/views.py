from api_connections import RequestLibraryRawData
#from models import PercentLibraries
#from models import PercentPublicOrPrivateLibrary
import datetime

def get_all_libraries():
    request = RequestLibraryRawData("2012-01-01 15:47:38.337553")
    libraries = request.data
    return libraries

def get_public_libraries():
    count = 0
    for librarie in get_all_libraries():
        if librarie["esfera"] != None and librarie["esfera"] == 'Pública':
            count = count + 1
    return count

def get_private_libraries():
    count = 0

    for librarie in get_all_libraries():
        if librarie["esfera"] != None and librarie["esfera"] == 'Privada':
            count = count + 1
    return count


def get_undefined_library():
    count = 0
    for librarie in get_all_libraries():
        if( librarie["esfera"] == None ):
            count = count + 1
    return count

#def update_library_indicator():
#    if(len(PercentPublicOrPrivateLibrary.objects) == 0):
#        PercentPublicOrPrivateLibrary(0, "2012-01-01 15:47:38.337553", 0, 0).save()
#    else:
#        undefined_library = get_undefined_library()
#        public_libraries = get_public_libraries()
#        private_libraries = get_private_libraries()
#        total_libraries = undefined_library + public_libraries + private_libraries
#        PercentPublicOrPrivateLibrary(total_libraries, datetime.datetime.now(), public_libraries, private_libraries)


def get_all_occupation_area():
    count = 0
    areas = {}
    for librarie in get_all_libraries():
        for area in librarie["terms"]["area"]:
            filter_types(area, areas)


#return dictionary with value of each area
def filter_types_area(actual_area, areas):
    if not (actual_area in areas):
        areas[actual_area] = 1
    else:
        areas[actual_area] += 1



get_occupation_area()
