import json
import datetime
import requests
from events_indicators.models import EventData

class RequestMixedIndicatorsRawData(object):
    def __init__(self, last_update_time):
        self._data = EventData.objects(_date__gt = last_update_time)

    @property
    def data(self):
        return self._data

    @property
    def data_length(self):
        return len(self._data)