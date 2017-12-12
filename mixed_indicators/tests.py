from datetime import datetime
from .db_connections import RequestMixedIndicatorsRawData
from .models import EventAndSpaceData
from .views import populate_mixed_data
from events_indicators.models import EventData


class TestEventAndSpaceData(object):

    def test_event_space_data(self):
        EventAndSpaceData.drop_collection()
        event_space_data = EventAndSpaceData()
        instance = "SP"
        event_space_data.instance = instance
        accessible_space = "sim"
        event_space_data.accessible_space = accessible_space
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        event_space_data.date = date
        event_space_data.save()
        query = EventAndSpaceData.objects.first()
        assert query.instance == instance
        assert query.accessible_space == accessible_space
        assert query.date == date


class TestPopulateMixedData(object):

    def test_populate_mixed_data(self):
        EventAndSpaceData.drop_collection()
        EventData.drop_collection()
        instance = "SP"
        age_range = 'Livre'
        occurrences = [
            {
                "id": 1147,
                "space": {
                    "id": 14191,
                    "acessibilidade": "Sim"
                }
            }
        ]
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        EventData(instance, age_range, occurrences, date).save()
        date = datetime(2017, 11, 13, 3, 5, 55, 88000)
        populate_mixed_data(date)

        assert EventAndSpaceData.objects.count() != 0


class TestRequestMixedRawData(object):

    def test_request_mixed_raw_data(self):
        EventAndSpaceData.drop_collection()
        EventData.drop_collection()
        instance = "SP"
        age_range = 'Livre'
        occurrences = [
            {
                "id": 1147,
                "space": {
                    "id": 14191,
                    "acessibilidade": "Sim"
                }
            }
        ]
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        query = EventData(instance, age_range, occurrences, date)
        query.save()
        date = datetime(2017, 11, 13, 3, 5, 55, 88000)

        raw_data = RequestMixedIndicatorsRawData(date)

        assert raw_data.data[0].age_range == 'Livre'
        assert raw_data.data_length == 1
