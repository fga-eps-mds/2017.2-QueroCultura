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
        print(librarie['esfera'])
        if(librarie["esfera"] != None and librarie["esfera"] == 'Pública'):
            count  = count + 1

    return count





print(get_public_libraries())
