from datetime import datetime
from .api_connections import RequestProjectsRawData
from .models import PercentProjectPerType
from .models import PercentProjectThatAcceptOnlineTransitions


class TestPercentProjectPerType(object):

    def test_total_project(self):
        PercentProjectPerType.drop_collection()
        indicator = 50
        project_indicator = PercentProjectPerType(indicator, {"Tipo": 50}, datetime.now())
        project_indicator.save()
        querry = PercentProjectPerType.objects.first()
        assert querry._totalProject == indicator

    def test_total_project_per_type(self):
        PercentProjectPerType.drop_collection()
        indicator = {"tipo": 50}
        project_indicator = PercentProjectPerType(50, indicator, datetime.now())
        project_indicator.save()
        querry = PercentProjectPerType.objects.first()
        assert querry._totalProjectPerType == indicator


class PercentPercentProjectThatAcceptOnlineTransitions(object):

    def test_total_project_that_accept_online_transitions(self):
        PercentProjectThatAcceptOnlineTransitions.drop_collection()
        indicator = 50
        project_indicator = PercentProjectThatAcceptOnlineTransitions(indicator, 50, datetime.now())
        project_indicator.save()
        querry = PercentProjectThatAcceptOnlineTransitions.objects.first()
        assert querry._totalProjectThatAcceptOnlineTransitions == indicator

    def total_project(self):
        PercentProjectThatAcceptOnlineTransitions.drop_collection()
        indicator = 50
        project_indicator = PercentProjectThatAcceptOnlineTransitions(51, indicator, datetime.now())
        project_indicator.save()
        querry = PercentProjectThatAcceptOnlineTransitions.objects.first()
        assert querry._totalProject == indicator


def test_success_request():
    current_time = datetime.now().__str__()
    request_projects_raw_data = RequestProjectsRawData(current_time)
    response_projects_raw_data = request_projects_raw_data.response
    response_status_code = response_projects_raw_data.status_code
    assert response_status_code == 200


def test_data_content():
    current_time = datetime.now().__str__()
    request_projects_raw_data = RequestProjectsRawData(current_time)
    projects_raw_data = request_projects_raw_data.data
    type_projects_raw_data = type(projects_raw_data)
    empty_list = []
    assert type_projects_raw_data == type(empty_list)


def test_data_lenght():
    current_time = datetime.now().__str__()
    request_projects_raw_data = RequestProjectsRawData(current_time)
    projects_raw_data = request_projects_raw_data.data_length
    type_projects_raw_data = type(projects_raw_data)
    intenger = 1
    assert type_projects_raw_data == type(intenger)
