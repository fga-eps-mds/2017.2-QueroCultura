from datetime import datetime
from .api_connections import RequestMixedIndicatorsRawData
from .models import LastUpdateMixedDate
from .models import EventAndSpaceData
from .views import populate_mixed_data
from quero_cultura.views import ParserYAML
import requests_mock
import json


class TestLastUpdateMixedDate(object):

    def test_last_update_mixed_date(self):
        LastUpdateMixedDate.drop_collection()
        create_date = datetime.now().__str__()
        LastUpdateMixedDate(create_date).save()
        query = LastUpdateMixedDate.objects.first()
        assert query.create_date == create_date


class TestSpaceData(object):

    def test_event_space_data(self):
        EventAndSpaceData.drop_collection()
        instance = "SP"
        name = "Cia"
        accessible_space = "sim"
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        EventAndSpaceData(instance, name, accessible_space, date).save()
        query = EventAndSpaceData.objects.first()
        assert query.instance == instance
        assert query.name == name
        assert query.accessible_space == accessible_space
        assert query.date == date
