from datetime import datetime
from .api_connections import RequestProjectsRawData


class TestClassRequestProjectsRawData(object):

    def test_success_request(self):
        current_time = datetime.now().__str__()
        request_project_raw_data = RequestProjectsRawData(current_time)
        response_project_raw_data = request_project_raw_data.response
        response_status_code = response_project_raw_data.status_code
        assert response_status_code == 200

    def test_data_content(self):
        current_time = datetime.now().__str__()
        request_project_raw_data = RequestProjectsRawData(current_time)
        project_raw_data = request_project_raw_data.data
        type_project_raw_data = type(project_raw_data)
        empty_list = []
        assert type_project_raw_data == type(empty_list)

    def test_data_lenght(self):
        current_time = datetime.now().__str__()
        request_project_raw_data = RequestProjectsRawData(current_time)
        project_raw_data = request_project_raw_data.data_length
        type_project_raw_data = type(project_raw_data)
        intenger = 1
        assert type_project_raw_data == type(intenger)

def test_data_lenght():
    current_time = datetime.now().__str__()
    request_projects_raw_data = RequestProjectsRawData(current_time)
    projects_raw_data = request_projects_raw_data.data_length
    type_projects_raw_data = type(projects_raw_data)
    integer = 1
    assert type_projects_raw_data == type(integer)
