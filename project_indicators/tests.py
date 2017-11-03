from datetime import datetime
from .api_connections import RequestProjectsRawData
from .models import PercentProjectPerType
from .models import PercentProjectThatAcceptOnlineTransitions
from .models import QuantityOfRegisteredProject


class TestPercentProjectPerType(object):

    def test_total_project(self):
        PercentProjectPerType.drop_collection()
        indicator = 5
        project_indicator = PercentProjectPerType(indicator, str(datetime.now()), {'5': 5})
        project_indicator.save()
        query = PercentProjectPerType.objects.first()
        assert query._total_project == indicator

    def test_total_project_per_type(self):
        PercentProjectPerType.drop_collection()
        indicator = {'5':5}
        project_indicator = PercentProjectPerType(50, str(datetime.now()), indicator)
        project_indicator.save()
        query = PercentProjectPerType.objects.first()
        assert query._total_project_per_type == indicator


class TestPercentPercentProjectThatAcceptOnlineTransitions(object):

    def test_total_project_that_accept_online_transitions(self):
        PercentProjectThatAcceptOnlineTransitions.drop_collection()
        indicator = {'5':5}
        project_indicator = PercentProjectThatAcceptOnlineTransitions(5, str(datetime.now()), indicator)
        project_indicator.save()
        query = PercentProjectThatAcceptOnlineTransitions.objects.first()
        assert query._total_project_that_accept_online_transitions == indicator

    def total_project(self):
        PercentProjectThatAcceptOnlineTransitions.drop_collection()
        indicator = 50
        project_indicator = PercentProjectThatAcceptOnlineTransitions(51, indicator, str(datetime.now()))
        project_indicator.save()
        query = PercentProjectThatAcceptOnlineTransitions.objects.first()
        assert query._total_project == indicator


class TestQuantityOfRegisteredProject(object):
    def test_total_project_registered_per_mounth_per_year(self):
        QuantityOfRegisteredProject.drop_collection()
        indicator = {'5':5}
        project_indicator = QuantityOfRegisteredProject(50, str(datetime.now()), indicator)
        project_indicator.save()
        query = QuantityOfRegisteredProject.objects.first()
        assert query._total_project_registered_per_mounth_per_year == indicator


class TestClassRequestProjectsRawData(object):

    def test_success_request(self):
        current_time = datetime.now().__str__()
        request_project_raw_data = RequestProjectsRawData(current_time, "http://mapas.cultura.gov.br/api/")
        response_project_raw_data = request_project_raw_data.response
        response_status_code = response_project_raw_data.status_code
        assert response_status_code == 200

    def test_data_content(self):
        current_time = datetime.now().__str__()
        request_project_raw_data = RequestProjectsRawData(current_time, "http://mapas.cultura.gov.br/api/")
        project_raw_data = request_project_raw_data.data
        type_project_raw_data = type(project_raw_data)
        empty_list = []
        assert type_project_raw_data == type(empty_list)

    def test_data_lenght(self):
        current_time = datetime.now().__str__()
        request_project_raw_data = RequestProjectsRawData(current_time, "http://mapas.cultura.gov.br/api/")
        project_raw_data = request_project_raw_data.data_length
        type_project_raw_data = type(project_raw_data)
        intenger = 1
        assert type_project_raw_data == type(intenger)
