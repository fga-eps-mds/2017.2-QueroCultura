from django.shortcuts import render
from .api_connections import RequestEventsRawData
from quero_cultura.views import ParserYAML
from datetime import datetime
from celery.decorators import task

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"


def index(request):

    return render(request, 'events_indicators/events_indicators.html')
