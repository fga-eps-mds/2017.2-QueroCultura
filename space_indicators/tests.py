from datetime import datetime
from .api_connections import RequestSpacesRawData
from .models import LastUpdateDate
from .models import SpaceData
from .models import OccupationArea
from .views import populate_space_data
from quero_cultura.views import ParserYAML
import requests_mock
import json


class TestLastUpdateDate(object):
    def test_last_update_date(self):
        LastUpdateDate.drop_collection()
        update_date = LastUpdateDate()
        create_date = datetime.now().__str__()
        update_date.create_date = create_date
        update_date.save()
        query = LastUpdateDate.objects.first()
        assert query.create_date == create_date


class TestOccupationArea(object):
    def test_occupation_area(self):
        OccupationArea.drop_collection()
        occupation_area = OccupationArea()
        instance = "SP"
        occupation_area.instance = instance
        area = "Cinema"
        occupation_area.occupation_area = area
        occupation_area.save()
        query = OccupationArea.objects.first()
        assert query.instance == instance
        assert query.occupation_area == area


class TestSpaceData(object):
    def test_space_data(self):
        SpaceData.drop_collection()
        space_data = SpaceData()
        instance = "SP"
        space_data.instance = instance
        name = "Cia"
        space_data.name = name
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        space_data.date = date
        space_type = "Teatro"
        space_data.space_type = space_type
        space_data.save()
        query = SpaceData.objects.first()
        assert query.instance == instance
        assert query.name == name
        assert query.date == date
        assert query.space_type == space_type


class TestPopulateSpaceData(object):
    @requests_mock.Mocker(kw='mock')
    def test_populate_space_data(self, **kwargs):
        parser_yaml = ParserYAML()
        urls = parser_yaml.get_multi_instances_urls

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "type": {"name": "Livre"}, "name": "FGA",
                   "terms": {"area": ["Cinema", "Teatro"]}}]

        for url in urls:
            kwargs['mock'].get(url + "space/find/", text=json.dumps(result))

        LastUpdateDate.drop_collection()
        OccupationArea.drop_collection()
        SpaceData.drop_collection()

        populate_space_data()

        assert LastUpdateDate.objects.count() != 0
        assert OccupationArea.objects.count() != 0
        assert SpaceData.objects.count() != 0


class TestRequestSpacesRawData(object):
    @requests_mock.Mocker(kw='mock')
    def test_request_spaces_raw_data(self, **kwargs):
        url = "http://mapas.cultura.gov.br/api/"

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "type": {"name": "Livre"}, "name": "FGA",
                   "terms": {"area": ["Cinema", "Teatro"]}}]

        kwargs['mock'].get(url + "space/find/", text=json.dumps(result))

        current_time = datetime.now().__str__()
        raw_data = RequestSpacesRawData(current_time,
                                        "http://mapas.cultura.gov.br/api/")
        assert raw_data.response.status_code == 200
        assert raw_data.data == result
        assert raw_data.data_length == 1
