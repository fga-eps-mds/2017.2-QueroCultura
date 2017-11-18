from django.shortcuts import render
from .models import PercentEventsPerAgeRange
from .models import PercentEventsPerLanguage
from .models import QuantityOfRegisteredEvents
from .api_connections import RequestEventsRawData
from quero_cultura.views import build_temporal_indicator
from quero_cultura.views import ParserYAML
from datetime import datetime
from celery.decorators import task
from quero_cultura.views import sort_dict
import yaml
import json

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"


def index(request):
    index = PercentEventsPerLanguage.objects.count()

    return render(request, 'events_indicators/events_indicators.html', context)
