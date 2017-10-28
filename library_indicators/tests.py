from datetime import datetime
import unittest
from .api_connections import RequestLibraryRawData
from .models import PercentLibraryPerAreaOfActivity
from .models import PercentPublicOrPrivateLibrary
from .models import PercentLibraryPerAreaOfActivityPerState
from .models import PercentPublicOrPrivateLibraryPerState
from .models import QuantityOfRegisteredlibraries
from .models import PercentLibrariesTypeSphere
from .models import PercentLibraryForState
from .views import update_indicators
from .views import set_libraries_amount

class TestUpdateIndicator(unittest.TestCase):
    @staticmethod
    def test_update_indicators():
        count_percent = 0
        count_public = 0
        PercentPublicOrPrivateLibrary.drop_collection()
        QuantityOfRegisteredlibraries.drop_collection()
        update_indicators()
        count_percent += PercentPublicOrPrivateLibrary.objects.count()
        count_public += QuantityOfRegisteredlibraries.objects.count()
        result = count_percent + count_public
        assert result == 2

    @staticmethod
    def test_set_amount_libraries_undefined():
        undefined_library = 0
        public_libraries = 0
        private_libraries = 0
        total_libraries = 0
        undefined_library, public_libraries, private_libraries, total_libraries = set_libraries_amount(undefined_library,
                                                                                                   public_libraries, private_libraries, total_libraries)
        assert undefined_library

class TestPercentLibraryPerAreaOfActivity(object):

    @staticmethod
    def test_libraries_per_activity():
        PercentLibraryPerAreaOfActivity.drop_collection()
        libraries_per_activity = {'activity area': 20}
        library_indicator = PercentLibraryPerAreaOfActivity(
            20, datetime.now(), libraries_per_activity,0)
        library_indicator.save()
        query = PercentLibraryPerAreaOfActivity.objects.first()
        assert query._libraries_per_activity == libraries_per_activity

    @staticmethod
    def test_total_library():
        PercentLibraryPerAreaOfActivity.drop_collection()
        total_libraries = 50
        library_indicator = PercentLibraryPerAreaOfActivity(
            total_libraries, datetime.now(), {'activity area': 20},0)
        library_indicator.save()
        query = PercentLibraryPerAreaOfActivity.objects.first()
        assert query._total_libraries == total_libraries

class TestPercentPublicOrPrivateLibrary(object):

    @staticmethod
    def test_total_public_libraries():
        PercentPublicOrPrivateLibrary.drop_collection()
        total_public_library = 50
        library_indicator = PercentPublicOrPrivateLibrary(
            20, datetime.now(), total_public_library, 100)
        library_indicator.save()
        query = PercentPublicOrPrivateLibrary.objects.first()
        assert query._total_public_libraries == total_public_library

    @staticmethod
    def test_total_private_libraries():
        PercentPublicOrPrivateLibrary.drop_collection()
        total_private_libraries = 50
        library_indicator = PercentPublicOrPrivateLibrary(
            20, datetime.now(), 100, total_private_libraries)
        library_indicator.save()
        query = PercentPublicOrPrivateLibrary.objects.first()
        assert query._total_private_libraries == total_private_libraries

    @staticmethod
    def test_total_library():
        PercentPublicOrPrivateLibrary.drop_collection()
        total_libraries = 50
        library_indicator = PercentPublicOrPrivateLibrary(
            total_libraries, datetime.now(), 100, 100)
        library_indicator.save()
        query = PercentPublicOrPrivateLibrary.objects.first()
        assert query._total_libraries == total_libraries


class TestPercentLibraryPerAreaOfActivityPerState(object):

    @staticmethod
    def test_total_library_per_area_of_activity_per_state():
        PercentLibraryPerAreaOfActivityPerState.drop_collection()
        total_library_per_area_of_activity = {'teste': 20}
        library_indicator = PercentLibraryPerAreaOfActivityPerState(
            {'teste': 20}, datetime.now(), total_library_per_area_of_activity)
        library_indicator.save()
        query = PercentLibraryPerAreaOfActivityPerState.objects.first()
        assert query._libraries_per_area_per_state == total_library_per_area_of_activity


class TestPercentPublicOrPrivateLibraryPerState(object):

    @staticmethod
    def test_total_public_libraries():
        PercentPublicOrPrivateLibraryPerState.drop_collection()
        total_public_library = {'df': 20}
        library_indicator = PercentPublicOrPrivateLibraryPerState(
            {'teste': 20}, datetime.now(), total_public_library, {'df': 20})
        library_indicator.save()
        query = PercentPublicOrPrivateLibraryPerState.objects.first()
        assert query._public_libraries_per_state == total_public_library

    @staticmethod
    def test_total_private_libraries():
        PercentPublicOrPrivateLibraryPerState.drop_collection()
        total_private_libraries = {'df': 20}
        library_indicator = PercentPublicOrPrivateLibraryPerState(
            {'teste': 20}, datetime.now(), {'df': 20}, total_private_libraries)
        library_indicator.save()
        query = PercentPublicOrPrivateLibraryPerState.objects.first()
        assert query._private_libraries_per_state == total_private_libraries

class TestQuantityOfRegisteredLibraries(object):

    @staticmethod
    def test_libraries_registered_monthly():
        QuantityOfRegisteredlibraries.drop_collection()
        libraries_monthly = {'julho': 20}
        library_indicator = QuantityOfRegisteredlibraries(
            20, datetime.now(), libraries_monthly, {'2015': 20})
        library_indicator.save()
        query = QuantityOfRegisteredlibraries.objects.first()
        assert query._libraries_registered_monthly == libraries_monthly

    @staticmethod
    def test_libraries_registered_yearly():
        QuantityOfRegisteredlibraries.drop_collection()
        libraries_yearly = {'2015': 20}
        library_indicator = QuantityOfRegisteredlibraries(
            20, datetime.now(), {'julho': 50}, libraries_yearly)
        library_indicator.save()
        query = QuantityOfRegisteredlibraries.objects.first()
        assert query._libraries_registered_yearly == libraries_yearly


class TestPercentLibraryTypeSphere(object):

    @staticmethod
    def test_libraries_registered_monthly():
        PercentLibrariesTypeSphere.drop_collection()
        total_libraries_type_sphere = {'type sphere': 20}
        library_indicator = PercentLibrariesTypeSphere(
            20, datetime.now(), total_libraries_type_sphere)
        library_indicator.save()
        query = PercentLibrariesTypeSphere.objects.first()
        assert query._total_libraries_type_sphere == total_libraries_type_sphere


class TestPercentLibraryForState(object):

    @staticmethod
    def test_libraries_for_state():
        PercentLibraryForState.drop_collection()
        libraries_for_state = {'df': 20}
        library_indicator = PercentLibraryForState(
            20, datetime.now(), libraries_for_state)
        library_indicator.save()
        query = PercentLibraryForState.objects.first()
        assert query._total_libraries_in_state == libraries_for_state

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
    integer = 1
    assert type_library_raw_data == type(integer)
