from api_connections import RequestLibraryRawData
#from .models import PercentLibraries
#from .models import PercentPublicOrPrivateLibrary

def get_all_libraries():
    request = RequestLibraryRawData("2012-01-01 15:47:38.337553")

    libraries = request.data

    return libraries

def get_public_libraries():

    count = 0
    for librarie in get_all_libraries():
        if(librarie["esfera"] != None and librarie["esfera"] == 'Pública'):
            count  = count + 1

    return count


def get_private_libraries():
    count = 0

    for librarie in get_all_libraries():
        if(librarie["esfera"] != None and librarie["esfera"] == 'Privada'):
            count  = count + 1

    return count


def get_undefined_library():
    count = 0
    for librarie in get_all_libraries():
        if(librarie["esfera"] == None ):
            count  = count + 1

    return count

print(get_undefined_library())
