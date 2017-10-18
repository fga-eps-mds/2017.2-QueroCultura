from datetime import datetime
from .api_connections import RequestMuseumRawData
from .models import PercentMuseumsState
from .models import PercentThematicsMuseumsForState
from .models import PercentTypeMuseumsForState
from .models import PercentPublicOrPrivateMuseumsForState
from .models import PercentMuseumsHistoricalArchivePublicAccessForState
from .models import PercentMuseumsPromoteGuidedTourForState
from .models import PercentThematicsMuseums
from .models import PercentTypeMuseums
from .models import PercentPublicOrPrivateMuseums
from .models import PercentMuseumsHistoricalArchivePublicAccess

class TestPercentThematicsMuseumsForState(object):

    @staticmethod
    def test_thematics_museums_for_state():
        PercentThematicsMuseumsForState.drop_collection()
        museums = {'tematic': 20}
        museums_indicator = PercentThematicsMuseumsForState(
            {'DF':30}, datetime.now(), museums)
        museums_indicator.save()
        query = PercentThematicsMuseumsForState.objects.first()
        assert query._thematics_museums_for_state == museums


class TestPercentTypeMuseumsForState(object):

    @staticmethod
    def test_type_museums_for_state():
        PercentTypeMuseumsForState.drop_collection()
        museums = {'type': 20}
        museums_indicator = PercentTypeMuseumsForState(
            {'DF':30}, datetime.now(), museums)
        museums_indicator.save()
        query = PercentTypeMuseumsForState.objects.first()
        assert query._type_museums_for_state == museums


class TestPercentPublicOrPrivateMuseumsForState(object):

    @staticmethod
    def test_total_public_museums_for_state():
        PercentPublicOrPrivateMuseumsForState.drop_collection()
        museums = {'publicos': 20}
        museums_indicator = PercentPublicOrPrivateMuseumsForState(
            {'DF':30}, datetime.now(), museums,{'privados':5})
        museums_indicator.save()
        query = PercentPublicOrPrivateMuseumsForState.objects.first()
        assert query._total_public_museums_for_state == museums

    @staticmethod
    def test_total_private_museums_for_state():
        PercentPublicOrPrivateMuseumsForState.drop_collection()
        museums = {'privados':5}
        museums_indicator = PercentPublicOrPrivateMuseumsForState(
            {'DF':30}, datetime.now(), {'publicos': 20}, museums)
        museums_indicator.save()
        query = PercentPublicOrPrivateMuseumsForState.objects.first()
        assert query._total_private_museums_for_state == museums


class TestPercentMuseumsHistoricalArchivePublicAccessForState(object):

    @staticmethod
    def test_total_historical_archive():
        PercentMuseumsHistoricalArchivePublicAccessForState.drop_collection()
        museums = {'historical archive': 20}
        museums_indicator = PercentMuseumsHistoricalArchivePublicAccessForState(
            {'DF':30}, datetime.now(), museums)
        museums_indicator.save()
        query = PercentMuseumsHistoricalArchivePublicAccessForState.objects.first()
        assert query._total_historical_archive == museums


class TestPercentMuseumsPromoteGuidedTourForState(object):

    @staticmethod
    def test_total_museums_guide_tour():
        PercentMuseumsPromoteGuidedTourForState.drop_collection()
        museums = {'guide tour': 20}
        museums_indicator = PercentMuseumsPromoteGuidedTourForState(
            {'DF':30}, datetime.now(), museums)
        museums_indicator.save()
        query = PercentMuseumsPromoteGuidedTourForState.objects.first()
        assert query._total_museums_guide_tour == museums

class TestPercentThematicsMuseums(object):

    def test_thematics_museums(self):
        PercentThematicsMuseums.drop_collection()
        museums = 10
        museums_indicator = PercentThematicsMuseums(
            10, datetime.now(), museums)
        museums_indicator.save()
        query = PercentThematicsMuseums.objects.first()
        assert query._thematics_museums == museums

class TestPercentTypeMuseums(object):

    def test_type_museums(self):
        PercentTypeMuseums.drop_collection()
        museums = 10
        museums_indicator = PercentTypeMuseums(
            10, datetime.now(), museums)
        museums_indicator.save()
        query = PercentTypeMuseums.objects.first()
        assert query._type_museums == museums


class TestPercentPublicOrPrivateMuseums(object):
    def test_total_public_museums(self):
        PercentPublicOrPrivateMuseums.drop_collection()
        museums = 10
        museums_indicator = PercentPublicOrPrivateMuseums(10,
                                                         datetime.now(), museums,10)
        museums_indicator.save()
        query = PercentPublicOrPrivateMuseums.objects.first()
        assert query._total_public_museums == museums

    def test_total_private_museums(self):
        PercentPublicOrPrivateMuseums.drop_collection()
        museums = 10
        museums_indicator = PercentPublicOrPrivateMuseums(
            10, datetime.now(), museums,10)
        museums_indicator.save()
        query = PercentPublicOrPrivateMuseums.objects.first()
        assert query._total_private_museums == museums

class TestPercentMuseumsHistoricalArchivePublicAccess(object):
    def test_total_museums_historical(self):
        PercentMuseumsHistoricalArchivePublicAccess.drop_collection()
        museums = 10
        museums_indicator = PercentMuseumsHistoricalArchivePublicAccess(
            10, datetime.now(), museums)
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
