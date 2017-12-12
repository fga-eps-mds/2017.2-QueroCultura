from datetime import datetime
from .api_connections import RequestMarkersRawData
from .api_connections import choose_select
from .api_connections import get_marker_action
from .api_connections import get_attribute
from .api_connections import get_date
from .api_connections import request_subsite_url
from .api_connections import filter_data
from .views import get_time_now
from .api_connections import get_marker_address
import requests_mock
import json


SPACE_SELECT = 'id, name, location, singleUrl, subsite, createTimestamp, updateTimestamp'
EVENT_SELECT = 'id, name, occurrences.{space.{location}}, singleUrl, subsite, createTimestamp, updateTimestamp'
AGENT_SELECT = 'id, name, location, singleUrl, subsite, createTimestamp, updateTimestamp'
PROJECT_SELECT = 'id, name, owner.location, singleUrl, subsite, createTimestamp, updateTimestamp'


class TestRequestMarkerRawData(object):

    @requests_mock.Mocker(kw='mock')
    def test_request_marker_raw_data(self, **kwargs):
        url = "http://mapas.cultura.gov.br/api/"
        marker = 'agent'
        result = [{"id": 1, "date": "2012-01-01 00:00:00.000000",
                   "name": "larissa", "useRegistrations": "FGA"}]

        kwargs['mock'].get(url + marker + "/find/", text=json.dumps(result))

        current_time = datetime.now().__str__()
        raw_data = RequestMarkersRawData(current_time, url, marker)
        assert raw_data.response.status_code == 200
        assert raw_data.data == result
        assert raw_data.data_length == 1


class TestChooseSelect(object):

    def test_choose_select(self):
        select = choose_select('event')
        assert select == EVENT_SELECT
        select = choose_select('agent')
        assert select == AGENT_SELECT
        select = choose_select('project')
        assert select == PROJECT_SELECT
        select = choose_select('space')
        assert select == SPACE_SELECT


class TestMarkerAction(object):

    def test_get_marker_action(self):
        action = get_marker_action('2010', None)
        assert action['type'] == 'Criação'
        assert action['time'] == '2010'
        action = get_marker_action(None, '2010')
        assert action['type'] == 'Atualização'
        assert action['time'] == '2010'


class TestGetAtributte(object):

    def test_get_atributte(self):
        atributte = get_attribute({'Name': 'Caio'}, 'Name')
        assert atributte == 'Caio'
        atributte = get_attribute({'Name': 'Caio'}, 'Idade')
        assert atributte == ''


class TestGetDate(object):

    def test_get_date(self):
        date = get_date({'createTimestamp': {'date': '2010'}},
                        'createTimestamp')
        assert date == '2010'
        date = get_date({'createTimestamp': None}, 'createTimestamp')
        assert date == None


class TestRequestSubSite(object):

    @requests_mock.Mocker(kw='mock')
    def test_request_subsite(self, **kwargs):

        url = "http://mapas.cultura.gov.br/"
        inst_id = 1

        result = [{'url': 'mapas.cultura.gov.br/'}]

        kwargs['mock'].get(url + "/api/subsite/find", text=json.dumps(result))
        resp = request_subsite_url(inst_id, url)
        assert resp == url


class TestMarkerAddress(object):

    @requests_mock.Mocker(kw='mock')
    def test_get_marker_address(self, **kwargs):
        marker = {}
        url = "http://nominatim.openstreetmap.org/reverse?"
        location = {'latitude': '10', 'longitude': '10'}

        result = {'address': {'city': 'brasilia', 'state': 'Distrito'}}

        kwargs['mock'].get(url + "lat=10&lon=10&format=json",
                            text=json.dumps(result))
        marker['city'], marker['state'] = get_marker_address(location)
        assert marker['city'] == 'brasilia'
        assert marker['state'] == 'Distrito'

class TestGetTimeNow(object):
    def test_get_time_now(self):
        time_now = get_time_now()
        assert time_now.date() == datetime.now().date()


class TestFilterData(object):
    def test_filter_data(self):
        marker = {'id':123, 'name':'Caio', 'location': {'latitude': '0', 'longitude': '0'}, 'singleUrl':'', 'subsite': None, 'createTimestamp': None , 'updateTimestamp':None}
        test_marker = filter_data(marker,'agent')
        assert test_marker['name'] == 'Caio'
