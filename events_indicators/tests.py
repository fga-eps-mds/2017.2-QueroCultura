from datetime import datetime
from .api_connections import RequestEventsRawData
from .models import QuantityOfRegisteredEvents
from .models import PercentEventsPerLanguage
from .models import PercentEventsPerAgeRange
from .views import update_event_indicator


class TestQuantityOfRegisteredEvents(object):

    @staticmethod
    def test_total_events_registered_per_mouth_per_year():
        QuantityOfRegisteredEvents.drop_collection()
        total_events_mouth = {"01": 10}
        event_indicator = QuantityOfRegisteredEvents(50,
                                                     datetime.now(),
                                                     total_events_mouth)
        event_indicator.save()
        query = QuantityOfRegisteredEvents.objects.first()
        assert query._total_events_registered_per_mounth_per_year == total_events_mouth

    @staticmethod
    def test_total_events():
        QuantityOfRegisteredEvents.drop_collection()
        total_events = 20
        event_indicator = QuantityOfRegisteredEvents(total_events,
                                                     datetime.now(),
                                                     {"01": 10})
        event_indicator.save()
        query = QuantityOfRegisteredEvents.objects.first()
        assert query._total_events == 20


class TestPercentEventsPerLanguage(object):

    @staticmethod
    def test_percent_events_per_language():
        PercentEventsPerLanguage.drop_collection()
        total_events_per_language = {"01": 10}
        indicator = PercentEventsPerLanguage(10,
                                             datetime.now(), total_events_per_language)
        indicator.save()
        query = PercentEventsPerLanguage.objects.first()
        assert query._total_events_per_language == total_events_per_language

    @staticmethod
    def test_total_events():
        PercentEventsPerLanguage.drop_collection()
        total_events = 20
        indicator = PercentEventsPerLanguage(total_events, datetime.now(), {"01": 10})
        indicator.save()
        query = PercentEventsPerLanguage.objects.first()
        assert query._total_events == total_events


class TestPercentEventsPerAgeRange(object):

    @staticmethod
    def test_percent_events_per_language():
        PercentEventsPerAgeRange.drop_collection()
        total_events_range = {"01": 10}
        indicator = PercentEventsPerAgeRange(20, datetime.now(), total_events_range)
        indicator.save()
        query = PercentEventsPerAgeRange.objects.first()
        assert query._total_events_per_age_range == total_events_range


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


class TestUpdateEventIndicator(object):

    @staticmethod
    def test_update_event_indicator():
        PercentEventsPerLanguage.drop_collection()
        PercentEventsPerAgeRange.drop_collection()
        QuantityOfRegisteredEvents.drop_collection()

        update_event_indicator()

        total = len(PercentEventsPerLanguage.objects)
        total += len(PercentEventsPerAgeRange.objects)
        total += len(QuantityOfRegisteredEvents.objects)

        assert total == 6
