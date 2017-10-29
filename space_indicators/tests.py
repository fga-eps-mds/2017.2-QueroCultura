from datetime import datetime
from .api_connections import RequestSpacesRawData
from .models import PercentSpacePerType
from .models import PercentSpacePerTypePerState
from .models import PercentSpacePerOccupationAreaPerState
from .models import PercentSpaceForState


class TestPercentSpacePerType(object):
    def test_total_space(self):
        PercentSpacePerType.drop_collection()
        indicator = 5
        space_indicator = PercentSpacePerType(indicator, datetime.now(), 5)
        space_indicator.save()
        query = PercentSpacePerType.objects.first()
        assert query._total_space == indicator

    def test_total_space_per_type(self):
        PercentSpacePerType.drop_collection()
        indicator = 50
        project_indicator = PercentSpacePerType(indicator, datetime.now(), 50)
        project_indicator.save()
        query = PercentSpacePerType.objects.first()
        assert query._total_space_per_type == indicator


class TestPercentSpacePerTypePerState(object):
    def test_total_space(self):
        PercentSpacePerTypePerState.drop_collection()
        indicator = 50
        project_indicator = PercentSpacePerTypePerState(indicator, datetime.now(), 50)
        project_indicator.save()
        query = PercentSpacePerTypePerState.objects.first()
        assert query._total_space == indicator


class TestPercentSpacePerOccupationAreaPerState(object):
    def test_total_space_occupation_area_per_state(self):
        PercentSpacePerOccupationAreaPerState.drop_collection()
        indicator = 50
        project_indicator = PercentSpacePerOccupationAreaPerState(indicator, datetime.now(), 50)
        project_indicator.save()
        query = PercentSpacePerOccupationAreaPerState.objects.first()
        assert query._total_space_occupation_area_per_state == indicator


class TestPercentSpaceForState(object):
    def test_total_space_occupation_area_per_state(self):
        PercentSpaceForState.drop_collection()
        indicator = 50
        project_indicator = PercentSpaceForState(indicator, datetime.now(), 50)
        project_indicator.save()
        query = PercentSpaceForState.objects.first()
        assert query._total_spaces == indicator


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
        intenger = 1
        assert type_space_raw_data == type(intenger)
