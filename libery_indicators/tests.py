from datetime import datetime
from .api_connections import RequestLibraryRawData
from .models import PercentLibraryPerAreaOfActivity
from .models import PercentPublicOrPrivateLibrary
from .models import PercentLibrariesTypeSphere
from .models import QuantityOfRegisteredLibrarys
from .models import PercentLibraryForState


class TestPercentLibraryPerAreaOfActivity(object):

    def test_total_library_per_area_of_activity(self):
        PercentLibraryPerAreaOfActivity.drop_collection()
        totalLibraryPerAreaOfActivity = {'activity area': 20}
        libery_indicator = PercentLibraryPerAreaOfActivity(totalLibraryPerAreaOfActivity, 20, datetime.now())
        libery_indicator.save()
        querry = PercentLibraryPerAreaOfActivity.objects.first()
        assert querry._totalLibraryPerAreaOfActivity == totalLibraryPerAreaOfActivity

    def test_total_library(self):
        PercentLibraryPerAreaOfActivity.drop_collection()
        totalLibrary = 50
        libery_indicator = PercentLibraryPerAreaOfActivity({'activity area': 20}, totalLibrary, datetime.now())
        libery_indicator.save()
        querry = PercentLibraryPerAreaOfActivity.objects.first()
        assert querry._totalLibrary == totalLibrary


class TestPercentPublicOrPrivateLibrary(object):

    def test_total_public_library(self):
        PercentPublicOrPrivateLibrary.drop_collection()
        totalPublicLibrary = 50
        libery_indicator = PercentPublicOrPrivateLibrary(totalPublicLibrary, 20, 100, datetime.now())
        libery_indicator.save()
        querry = PercentPublicOrPrivateLibrary.objects.first()
        assert querry._totalPublicLibrary == totalPublicLibrary

    def test_total_private_library(self):
        PercentPublicOrPrivateLibrary.drop_collection()
        totalPrivateLibrary = 50
        libery_indicator = PercentPublicOrPrivateLibrary(20, totalPrivateLibrary, 100, datetime.now())
        libery_indicator.save()
        querry = PercentPublicOrPrivateLibrary.objects.first()
        assert querry._totalPrivateLibrary == totalPrivateLibrary

    def test_total_library(self):
        PercentPublicOrPrivateLibrary.drop_collection()
        totalLibrary = 50
        libery_indicator = PercentPublicOrPrivateLibrary(20, 20, totalLibrary, datetime.now())
        libery_indicator.save()
        querry = PercentPublicOrPrivateLibrary.objects.first()
        assert querry._totalLibrary == totalLibrary


class TestPercentLibrariesTypeSphere(object):

    def test_total_libraries_type_sphere(self):
        PercentLibrariesTypeSphere.drop_collection()
        totalLibrariesTypeSphere = {"tipo esfera": 50}
        library_indicator = PercentLibrariesTypeSphere(totalLibrariesTypeSphere, 20, datetime.now())
        library_indicator.save()
        querry = PercentLibrariesTypeSphere.objects.first()
        assert querry._totalLibrariesTypeSphere == totalLibrariesTypeSphere

    def test_total_library(self):
        PercentLibrariesTypeSphere.drop_collection()
        totalLibraries = 50
        library_indicator = PercentLibrariesTypeSphere({"df": 20}, totalLibraries, datetime.now())
        library_indicator.save()
        querry = PercentLibrariesTypeSphere.objects.first()
        assert querry._totalLibrary == totalLibraries


class TestQuantityOfRegisteredLibrarys(object):

    def test_total_librarys_registered_per_mouth_per_year(self):
        QuantityOfRegisteredLibrarys.drop_collection()
        totaLibrarys = {"mes e ano": "7 2017"}
        library_indicator = QuantityOfRegisteredLibrarys(totaLibrarys,{"2017":"março"}, 12 , datetime.now())
        library_indicator.save()
        querry = QuantityOfRegisteredLibrarys.objects.first()
        assert querry._totalLibrarysRegisteredPerMounthPerYear == totaLibrarys

    def test_total_librarys_registered_per_year(self):
        QuantityOfRegisteredLibrarys.drop_collection()
        totaLibrarys = {"mes e ano": "7 2017"}
        library_indicator = QuantityOfRegisteredLibrarys({"2017":"março"}, totaLibrarys, 12 , datetime.now())
        library_indicator.save()
        querry = QuantityOfRegisteredLibrarys.objects.first()
        assert querry._totalLibrarysRegisteredPerYear == totaLibrarys

    def test_total_librarys(self):
        QuantityOfRegisteredLibrarys.drop_collection()
        totaLibrarys = 20
        library_indicator = QuantityOfRegisteredLibrarys({"2017":"março"}, {"mes e ano": "7 2017"}, totaLibrarys , datetime.now())
        library_indicator.save()
        querry = QuantityOfRegisteredLibrarys.objects.first()
        assert querry._totalLibrarys == totaLibrarys


class TestPercentLibraryForState(object):

    def test_percent_library_for_state(self):
        PercentLibraryForState.drop_collection()
        totalLibraries = {"df": 20}
        library_indicator = PercentLibraryForState(totalLibraries,20,datetime.now())
        library_indicator.save()
        querry = PercentLibraryForState.objects.first()
        assert querry._totalLibraryForState == totalLibraries


def test_success_request():
    current_time = datetime.now().__str__()
    request_library_raw_data = RequestLibraryRawData(current_time)
    response_library_raw_data = request_library_raw_data.response
    response_status_code = response_library_raw_data.status_code
    assert response_status_code == 200

def test_data_content():
    current_time = datetime.now().__str__()
    request_library_raw_data = RequestLibraryRawData(current_time)
    library_raw_data = request_library_raw_data.data
    type_library_raw_data = type(library_raw_data)
    empty_list = []
    assert type_library_raw_data == type(empty_list)


def test_data_lenght():
    current_time = datetime.now().__str__()
    request_library_raw_data = RequestLibraryRawData(current_time)
    library_raw_data = request_library_raw_data.data_length
    type_library_raw_data = type(library_raw_data)
    intenger = 1
    assert type_library_raw_data == type(intenger)
