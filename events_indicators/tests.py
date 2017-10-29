from datetime import datetime
from .api_connections import RequestEventsRawData
from .models import QuantityOfRegisteredEvents
from .models import PercentEventsPerLanguage
from .models import PercentEventsPerAgeRange
from .models import PercentTypeEventsForState
from .models import PercentEventsPerAgeRangePerState

class TestQuantityOfRegisteredEvents(object):

    @staticmethod
    def test_total_events_registered_per_mouth_per_year():
        QuantityOfRegisteredEvents.drop_collection()
        total_events_mouth = 20
        event_indicator = QuantityOfRegisteredEvents(50,
                                                     datetime.now(), 20,
                                                     total_events_mouth)
        event_indicator.save()
        query = QuantityOfRegisteredEvents.objects.first()
        assert query._total_events_registered_per_mounth_per_year == 20

    @staticmethod
    def test_total_events_registered_per_year():
        QuantityOfRegisteredEvents.drop_collection()
        total_events_year = 10
        event_indicator = QuantityOfRegisteredEvents(50, datetime.now(),
                                                     total_events_year, 20)
        event_indicator.save()
        query = QuantityOfRegisteredEvents.objects.first()
        assert query._total_events_registered_per_year == 20

    @staticmethod
    def test_total_events():
        QuantityOfRegisteredEvents.drop_collection()
        total_events = 20
        event_indicator = QuantityOfRegisteredEvents(total_events,
                                                     datetime.now(),
                                                     20,
                                                     20)
        event_indicator.save()
        query = QuantityOfRegisteredEvents.objects.first()
        assert query._total_events == 20

class TestPercentEventsPerLanguage(object):

    @staticmethod
    def test_percent_events_per_language():
        PercentEventsPerLanguage.drop_collection()
        total_events_per_language = 20
        indicator = PercentEventsPerLanguage(10,
                                             datetime.now(), total_events_per_language)
        indicator.save()
        query = PercentEventsPerLanguage.objects.first()
        assert query._total_events_per_language == 20

    @staticmethod
    def test_total_events():
        PercentEventsPerLanguage.drop_collection()
        total_events = 20
        indicator = PercentEventsPerLanguage(total_events, datetime.now(), 20)
        indicator.save()
        query = PercentEventsPerLanguage.objects.first()
        assert query._total_events == total_events

class TestPercentEventsPerAgeRange(object):

    @staticmethod
    def test_percent_events_per_language():
        PercentEventsPerAgeRange.drop_collection()
        total_events_range = 35
        indicator = PercentEventsPerAgeRange(20, datetime.now(), total_events_range)
        indicator.save()
        query = PercentEventsPerAgeRange.objects.first()
        assert query._total_events_per_age_range == total_events_range

class TestPercentTypeEventsForState(object):

    @staticmethod
    def test_type_state_events():
        PercentTypeEventsForState.drop_collection()
        total_events_range = 35
        indicator = PercentTypeEventsForState(20, datetime.now(), total_events_range)
        indicator.save()
        query = PercentTypeEventsForState.objects.first()
        assert query._type_state_events == total_events_range

class TestEventsPerAgeRangePerState(object):

    @staticmethod
    def test_total_events_age_range_state():
        PercentEventsPerAgeRangePerState.drop_collection()
        total_events_range = 35
        indicator = PercentEventsPerAgeRangePerState(20, datetime.now(), total_events_range)
        indicator.save()
        query = PercentEventsPerAgeRangePerState.objects.first()
        assert query._total_events_age_range_state == total_events_range


class TestClassRequestEventsRawData(object):

    def test_success_request(self):
        current_time = datetime.now().__str__()
        request_events_raw_data = RequestEventsRawData(current_time, "http://mapas.cultura.gov.br/api/")
        response_events_raw_data = request_events_raw_data.response
        response_status_code = response_events_raw_data.status_code
        assert response_status_code == 200

    def test_data_content(self):
        current_time = datetime.now().__str__()
        request_events_raw_data = RequestEventsRawData(current_time, "http://mapas.cultura.gov.br/api/")
        events_raw_data = request_events_raw_data.data
        type_events_raw_data = type(events_raw_data)
        empty_list = []
        assert type_events_raw_data == type(empty_list)

    def test_data_lenght(self):
        current_time = datetime.now().__str__()
        request_events_raw_data = RequestEventsRawData(current_time, "http://mapas.cultura.gov.br/api/")
        events_raw_data = request_events_raw_data.data_length
        type_events_raw_data = type(events_raw_data)
        intenger = 1
        assert type_events_raw_data == type(intenger)
