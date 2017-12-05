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
