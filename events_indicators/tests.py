from datetime import datetime
from .api_connections import RequestEventsRawData
from .models import QuantityOfRegisteredEvents
from .models import PercentEventsPerLanguage
from .models import PercentEventsPerAgeRange


class TestQuantityOfRegisteredEvents(object):

    @staticmethod
    def test_total_events_registered_per_mouth_per_year():
        QuantityOfRegisteredEvents.drop_collection()
        totalEvents = {"mes e ano": "7 2017"}
        event_indicator = QuantityOfRegisteredEvents(totalEvents,{"2017":"março"}, 12 , datetime.now())
        event_indicator.save()
        querry = QuantityOfRegisteredEvents.objects.first()
        assert querry._totalEventsRegisteredPerMounthPerYear == totalEvents

    @staticmethod
    def test_total_events_registered_per_year():
        QuantityOfRegisteredEvents.drop_collection()
        totalEvents = {"mes e ano": "7 2017"}
        event_indicator = QuantityOfRegisteredEvents({"2017":"março"}, totalEvents, 12 , datetime.now())
        event_indicator.save()
        querry = QuantityOfRegisteredEvents.objects.first()
        assert querry._totalEventsRegisteredPerYear == totalEvents

    @staticmethod
    def test_total_events():
        QuantityOfRegisteredEvents.drop_collection()
        totalEvents = 20
        event_indicator = QuantityOfRegisteredEvents({"2017":"março"}, {"mes e ano": "7 2017"}, totalEvents , datetime.now())
        event_indicator.save()
        querry = QuantityOfRegisteredEvents.objects.first()
        assert querry._totalEvents == totalEvents

class TestPercentEventsPerLanguage(object):

    @staticmethod
    def test_percent_events_per_language():
        PercentEventsPerLanguage.drop_collection()
        total = {'activity area': 20}
        indicator = PercentEventsPerLanguage(total, 20, datetime.now())
        indicator.save()
        query = PercentEventsPerLanguage.objects.first()
        assert query._totalEventsPerLanguage == total

    @staticmethod
    def test_total_events():
        PercentEventsPerLanguage.drop_collection()
        total = 50
        indicator = PercentEventsPerLanguage({'activity area': 20}, total, datetime.now())
        indicator.save()
        query = PercentEventsPerLanguage.objects.first()
        assert query._totalEvents == total


class TestPercentEventsPerAgeRange(object):

    @staticmethod
    def test_percent_events_per_language():
        PercentEventsPerAgeRange.drop_collection()
        total = {'activity area': 20}
        indicator = PercentEventsPerAgeRange(total, 20, datetime.now())
        indicator.save()
        query = PercentEventsPerAgeRange.objects.first()
        assert query._totalEventsPerAgeRange == total

    @staticmethod
    def test_total_library():
        PercentEventsPerAgeRange.drop_collection()
        total = 50
        indicator = PercentEventsPerAgeRange({'activity area': 20}, total, datetime.now())
        indicator.save()
        query = PercentEventsPerAgeRange.objects.first()
        assert query._totalEvents == total


class TestClassRequestEventsRawData(object):

    def test_success_request():
        current_time = datetime.now().__str__()
        request_events_raw_data = RequestEventsRawData(current_time)
        response_events_raw_data = request_events_raw_data.response
        response_status_code = response_events_raw_data.status_code
        assert response_status_code == 200

    def test_data_content():
        current_time = datetime.now().__str__()
        request_events_raw_data = RequestEventsRawData(current_time)
        events_raw_data = request_events_raw_data.data
        type_events_raw_data = type(events_raw_data)
        empty_list = []
        assert type_events_raw_data == type(empty_list)

    def test_data_lenght():
        current_time = datetime.now().__str__()
        request_events_raw_data = RequestEventsRawData(current_time)
        events_raw_data = request_events_raw_data.data_length
        type_events_raw_data = type(events_raw_data)
        intenger = 1
        assert type_events_raw_data == type(intenger)
