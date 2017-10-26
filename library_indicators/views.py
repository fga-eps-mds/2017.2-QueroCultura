from api_connections import RequestLibraryRawData
#from .models import PercentLibraries
#from .models import PercentPublicOrPrivateLibrary

def get_all_libraries():
    request = RequestLibraryRawData("2012-01-01 15:47:38.337553")

    libraries = request.response
    return libraries
