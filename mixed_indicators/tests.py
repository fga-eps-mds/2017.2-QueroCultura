from datetime import datetime
from .api_connections import RequestMixedIndicatorsRawData
from .models import LastUpdateMixedDate
from .models import EventAndSpaceData
from .views import populate_mixed_data
from quero_cultura.views import ParserYAML
import requests_mock
import json


class TestLastUpdateMixedDate(object):

    def test_last_update_mixed_date(self):
        LastUpdateMixedDate.drop_collection()
        create_date = datetime.now().__str__()
        LastUpdateMixedDate(create_date).save()
        query = LastUpdateMixedDate.objects.first()
        assert query.create_date == create_date


class TestEventAndSpaceData(object):

    def test_event_space_data(self):
        EventAndSpaceData.drop_collection()
        instance = "SP"
        name = "Cia"
        accessible_space = "sim"
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        EventAndSpaceData(instance, name, accessible_space, date).save()
        query = EventAndSpaceData.objects.first()
        assert query.instance == instance
        assert query.name == name
        assert query.accessible_space == accessible_space
        assert query.date == date


class TestPopulateMixedData(object):

    @requests_mock.Mocker(kw='mock')
    def test_populate_mixed_data(self, **kwargs):
        parser_yaml = ParserYAML()
        urls = parser_yaml.get_multi_instances_urls

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   'name': 'FGA',
                   'occurrences': [{'space':
                                    {'acessibilidade': 'Sim', 'id': 13242}}]}]

        for url in urls:
            kwargs['mock'].get(url + "event/find/", text=json.dumps(result))

        LastUpdateMixedDate.drop_collection()
        EventAndSpaceData.drop_collection()

        populate_mixed_data()

        assert LastUpdateMixedDate.objects.count() != 0
        assert EventAndSpaceData.objects.count() != 0


class TestRequestMixedRawData(object):

    @requests_mock.Mocker(kw='mock')
    def test_request_mixed_raw_data(self, **kwargs):
        url = "http://mapas.cultura.gov.br/api/"

        result = [{'occurrences': [
            {'space': {'acessibilidade': 'Sim', 'id': 13242}, 'id': 401}], 'id': 882}]

        kwargs['mock'].get(url + "event/find/", text=json.dumps(result))

        current_time = datetime.now().__str__()
        raw_data = RequestMixedIndicatorsRawData(current_time,
                                                 "http://mapas.cultura.gov.br/api/")
        assert raw_data.response.status_code == 200
        assert raw_data.data == result
        assert raw_data.data_length == 1
