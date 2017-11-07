from datetime import datetime
from .api_connections import RequestMuseumRawData
from .models import PercentThematicsMuseums
from .models import PercentTypeMuseums
from .models import PercentPublicOrPrivateMuseums
from .models import PercentMuseumsHistoricalArchivePublicAccess

class TestPercentThematicsMuseums(object):

    def test_thematics_museums(self):
        PercentThematicsMuseums.drop_collection()
        museums = {"10": 10}
        museums_indicator = PercentThematicsMuseums(
            10, str(datetime.now()), museums)
        museums_indicator.save()
        query = PercentThematicsMuseums.objects.first()
        assert query._thematics_museums == museums

class TestPercentTypeMuseums(object):

    def test_type_museums(self):
        PercentTypeMuseums.drop_collection()
        museums = {"10": 10}
        museums_indicator = PercentTypeMuseums(
            10, str(datetime.now()), museums)
        museums_indicator.save()
        query = PercentTypeMuseums.objects.first()
        assert query._type_museums == museums


class TestPercentPublicOrPrivateMuseums(object):
    def test_total_public_private_museums(self):
        PercentPublicOrPrivateMuseums.drop_collection()
        museums = {"10": 10}
        museums_indicator = PercentPublicOrPrivateMuseums(10,
                                                         str(datetime.now()), museums)
        museums_indicator.save()
        query = PercentPublicOrPrivateMuseums.objects.first()
        assert query._total_public_private_museums == museums

class TestPercentMuseumsHistoricalArchivePublicAccess(object):
    def test_total_museums_historical(self):
        PercentMuseumsHistoricalArchivePublicAccess.drop_collection()
        museums = {"10": 10}
        museums_indicator = PercentMuseumsHistoricalArchivePublicAccess(
            10, str(datetime.now()), museums)
        museums_indicator.save()
        query = PercentMuseumsHistoricalArchivePublicAccess.objects.first()
        assert query._total_museums_historical == museums


class TestClassRequestMuseumsRawData(object):

    def test_success_request(self):
        current_time = datetime.now().__str__()
        request_museum_raw_data = RequestMuseumRawData(current_time)
        response_museum_raw_data = request_museum_raw_data.response
        response_status_code = response_museum_raw_data.status_code
        assert response_status_code == 200

    def test_data_content(self):
        current_time = datetime.now().__str__()
        request_museum_raw_data = RequestMuseumRawData(current_time)
        museum_raw_data = request_museum_raw_data.data
        type_museum_raw_data = type(museum_raw_data)
        empty_list = []
        assert type_museum_raw_data == type(empty_list)

    def test_data_lenght(self):
        current_time = datetime.now().__str__()
        request_museum_raw_data = RequestMuseumRawData(current_time)
        museum_raw_data = request_museum_raw_data.data_length
        type_museum_raw_data = type(museum_raw_data)
        intenger = 1
        assert type_museum_raw_data == type(intenger)
