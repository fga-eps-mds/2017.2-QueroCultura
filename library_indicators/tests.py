from datetime import datetime
from .api_connections import RequestLibraryRawData
from .models import LastUpdateLibraryDate
from .models import LibraryData
from .models import LibraryArea
from .models import LibraryTags
from .views import populate_library_data
from quero_cultura.views import ParserYAML
import requests_mock
import json


class TestLastUpdateLibraryDate(object):
    def test_last_library_date(self):
        LastUpdateLibraryDate.drop_collection()
        update_date = LastUpdateLibraryDate()
        create_date = datetime.now().__str__()
        update_date.create_date = create_date
        update_date.save()
        query = LastUpdateLibraryDate.objects.first()
        assert query.create_date == create_date


class TestLibraryArea(object):
    def test_library_area(self):
        LibraryArea.drop_collection()
        library_area = LibraryArea()
        instance = "SP"
        library_area.instance = instance
        area = "Cinema"
        library_area.area = area
        library_area.save()
        query = LibraryArea.objects.first()
        assert query.instance == instance
        assert query.area == area


class TestLibraryTags(object):
    def test_library_area(self):
        LibraryTags.drop_collection()
        library_tag = LibraryTags()
        instance = "SP"
        library_tag.instance = instance
        tag = "OlavoBilac"
        library_tag.tag = tag
        library_tag.save()
        query = LibraryTags.objects.first()
        assert query.instance == instance
        assert query.tag == tag


class TestLibraryData(object):
    def test_library_data(self):
        LibraryData.drop_collection()
        library_data = LibraryData()
        instance = "SP"
        library_data.instance = instance
        library_type = "Biblioteca Publica"
        library_data.library_type = library_type
        accessibility = "Sim"
        library_data.accessibility = accessibility
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        library_data.date = date
        library_data.save()
        query = LibraryData.objects.first()
        assert query.instance == instance
        assert query.library_type == library_type
        assert query.accessibility == accessibility
        assert query.date == date


class TestRequestLibraryRawData(object):
    @requests_mock.Mocker(kw='mock')
    def test_request_library_raw_data(self, **kwargs):
        url = "http://mapas.cultura.gov.br/api/"

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "acessibilidade": "Sim",
                   "type": {"id": "20", "name": "Biblioteca Publica"},
                   "terms": {"area": ["Cinema", "Teatro"],
                             "tag": ["Olavo Bilac"]}}]

        kwargs['mock'].get(url+"space/find/", text=json.dumps(result))

        current_time = datetime.now().__str__()
        raw_data = RequestLibraryRawData(current_time, url)
        assert raw_data.response.status_code == 200
        assert raw_data.data == result
        assert raw_data.data_length == 1


class TestPopulateLibraryData(object):
    @requests_mock.Mocker(kw='mock')
    def test_populate_library_data(self, **kwargs):
        parser_yaml = ParserYAML()
        urls = parser_yaml.get_multi_instances_urls

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "acessibilidade": "Sim",
                   "type": {"id": "20", "name": "Biblioteca Publica"},
                   "terms": {"area": ["Cinema", "Teatro"],
                             "tag": ["Olavo Bilac"]}}]

        for url in urls:
            kwargs['mock'].get(url + "space/find/", text=json.dumps(result))

        LastUpdateLibraryDate.drop_collection()
        LibraryData.drop_collection()
        LibraryArea.drop_collection()
        LibraryTags.drop_collection()

        populate_library_data()

        assert LastUpdateLibraryDate.objects.count() != 0
        assert LibraryData.objects.count() != 0
        assert LibraryArea.objects.count() != 0
