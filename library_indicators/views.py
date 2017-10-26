from api_connections import RequestLibraryRawData
#from models import PercentLibraries
#from models import PercentPublicOrPrivateLibrary
#from models import PercentLibraryPerAreaOfActivity
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

#def update_library_public_private_indicator():
#    if(len(PercentPublicOrPrivateLibrary.objects) == 0):
#        PercentPublicOrPrivateLibrary(0, "2012-01-01 15:47:38.337553", 0, 0).save()
#
#    else:
#        undefined_library = get_undefined_library()
#        public_libraries = get_public_libraries()
#        private_libraries = get_private_libraries()
#        total_libraries = undefined_library + public_libraries + private_libraries
#        PercentPublicOrPrivateLibrary(total_libraries, datetime.datetime.now(), public_libraries, private_libraries)


#def update_library_per_area_activity():
#     if(len(PercentLibraryPerAreaOfActivity.objects) == 0):
#
#
#

def get_all_occupation_area():
    areas = {}
    for librarie in get_all_libraries():
        for area in librarie["terms"]["area"]:
            filter_types_area(area, areas)


#return dictionary with value of each area
def filter_types_area(actual_area, areas):
    if not (actual_area in areas):
        areas[actual_area] = 1
    else:
        areas[actual_area] += 1

def get_libraries_per_year():
    create_dates = {}
    for librarie in get_all_libraries():
        date = format_date(librarie["createTimestamp"]["date"])
        filter_libraries_per_year(create_dates,date)
    print(create_dates)

def format_date(date):
    right_date = date.split(" ")
    year_date = right_date[0].split("-")
    return year_date[0]

def filter_libraries_per_year(create_dates, date):
    if not (date in create_dates):
        create_dates[date] = 1
    else:
        create_dates[date] += 1

get_libraries_per_year()
