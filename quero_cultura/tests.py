from datetime import datetime
from .api_connections import RequestMarkersRawData
from .api_connections import choose_select
from .api_connections import request_subsite_url
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


class TestRequestSubSite(object):
	@requests_mock.Mocker(kw='mock')
	def test_request_subsite(self, **kwargs):
    	
		url = "http://mapas.cultura.gov.br/"
		inst_id = 1

		result = [{'url': 'mapas.cultura.gov.br/'}]

		kwargs['mock'].get(url + "/api/subsite/find", text=json.dumps(result))
		resp = request_subsite_url(inst_id, url)
		assert resp == url
