from datetime import datetime
from .api_connections import RequestLibraryRawData
from .models import PercentLibraryPerAreaOfActivity


class TestPercentLibraryPerAreaOfActivity(object):

    def test_total_library_per_area_of_activity(self):
        PercentLibraryPerAreaOfActivity.drop_collection()
        totalLibraryPerAreaOfActivity = {'activity area': 20}
        libery_indicator = PercentLibraryPerAreaOfActivity(totalLibraryPerAreaOfActivity,20, datetime.now())
        libery_indicator.save()
        querry = PercentLibraryPerAreaOfActivity.objects.first()
        assert querry._totalLibraryPerAreaOfActivity == totalLibraryPerAreaOfActivity

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
