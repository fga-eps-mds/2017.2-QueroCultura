from datetime import datetime
from .api_connections import RequestSpacesRawData
from .models import LastUpdateDate
from .models import SpaceData


class TestLastUpdateDate(object):
    def test_last_update_date(self):
        LastUpdateDate.drop_collection()
        create_date = datetime.now().__str__()
        LastUpdateDate(create_date).save()
        query = LastUpdateDate.objects.first()
        assert query.create_date == create_date


class TestSpaceData(object):
    def test_space_data(self):
        SpaceData.drop_collection()
        instance = "SP"
        area = "Cinema"
        name = "Cia"
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        space_type = "Teatro"
        SpaceData(instance, area, name, date, space_type).save()
        query = SpaceData.objects.first()
        assert query.instance == instance
        assert query.occupation_area == area
        assert query.name == name
        assert query.date == date
        assert query.space_type == space_type


class TestClassRequestSpacesRawData(object):
    def test_success_request(self):
        current_time = datetime.now().__str__()
        request_space_raw_data = RequestSpacesRawData(current_time, "http://mapas.cultura.gov.br/api/")
        response_space_raw_data = request_space_raw_data.response
        response_status_code = response_space_raw_data.status_code
        assert response_status_code == 200

    def test_data_content(self):
        current_time = datetime.now().__str__()
        request_space_raw_data = RequestSpacesRawData(current_time, "http://mapas.cultura.gov.br/api/")
        space_raw_data = request_space_raw_data.data
        type_space_raw_data = type(space_raw_data)
        empty_list = []
        assert type_space_raw_data == type(empty_list)

    def test_data_lenght(self):
        current_time = datetime.now().__str__()
        request_space_raw_data = RequestSpacesRawData(current_time, "http://mapas.cultura.gov.br/api/")
        space_raw_data = request_space_raw_data.data_length
        type_space_raw_data = type(space_raw_data)
        integer = 1
        assert type_space_raw_data == type(integer)
