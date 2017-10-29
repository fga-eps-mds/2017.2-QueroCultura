from django.shortcuts import render
from .models import PercentEventsPerAgeRange
from .models import PercentEventsPerLanguage
from .models import QuantityOfRegisteredEvents
from .api_connections import RequestEventsRawData
from quero_cultura.views import build_temporal_indicator
from datetime import datetime
from celery.decorators import task
import yaml
import json

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"


def index(request):
    index = PercentEventsPerLanguage.objects.count()

    per_language = PercentEventsPerLanguage.objects[index - 1]
    per_age_range = PercentEventsPerAgeRange.objects[index - 1]
    temporal = QuantityOfRegisteredEvents.objects[index - 1]

    per_language = per_language.total_events_per_language
    per_age_range = per_age_range.total_events_per_age_range
    temporal = temporal.total_events_registered_per_mounth_per_year

    per_language_keys = per_language.keys()
    per_language_values = per_language.values()

    per_age_range_keys = per_age_range.keys()
    per_age_range_values = per_age_range.values()

    months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    last_year = 2013 + len(temporal)
    growthing = 0

    temporal_keys = []
    temporal_values = []
    temporal_growth = []

    for year in range(2013, last_year):
        for month in months:
            if (month in temporal[str(year)]):
                temporal_keys.append(str(year) + "-" + month)
                temporal_values.append(temporal[str(year)][month])

                growthing += temporal[str(year)][month]
                temporal_growth.append(growthing)

    context = {
        'per_language_keys': json.dumps(per_language_keys),
        'per_language_values': json.dumps(per_language_values),
        'per_age_range_keys': json.dumps(per_age_range_keys),
        'per_age_range_values': json.dumps(per_age_range_values),
        'temporal_keys': json.dumps(temporal_keys),
        'temporal_values': json.dumps(temporal_values),
        'temporal_growth': json.dumps(temporal_growth),
    }

    return render(request, 'events_indicators/events_indicators.html', context)


def build_age_range_indicator(new_data, old_data):
    per_age_range = {}

    for event in new_data:
        if not (event["classificacaoEtaria"] in per_age_range):
            per_age_range[event["classificacaoEtaria"]] = 1
        else:
            per_age_range[event["classificacaoEtaria"]] += 1

    for age_range in old_data:
        if not (age_range in per_age_range):
            per_age_range[age_range] = old_data[age_range]
        else:
            per_age_range[age_range] += old_data[age_range]

    return per_age_range


def build_language_indicator(new_data, old_data):
    per_language = {}

    for agent in new_data:
        for linguagem in agent["terms"]["linguagem"]:
            if not (linguagem in per_language):
                per_language[linguagem] = 1
            else:
                per_language[linguagem] += 1

    for linguagem in old_data:
            if not (linguagem in per_language):
                per_language[linguagem] = old_data[linguagem]
            else:
                per_language[linguagem] += old_data[linguagem]

    return per_language


@task(name="update_event_indicator")
def update_event_indicator():
    if len(PercentEventsPerLanguage.objects) == 0:
        PercentEventsPerLanguage(0, DEFAULT_INITIAL_DATE, {"Teatro": 0}).save()
        PercentEventsPerAgeRange(0, DEFAULT_INITIAL_DATE, {"Livre": 0}).save()
        QuantityOfRegisteredEvents(0, DEFAULT_INITIAL_DATE, {"2015": {"01": 0}}).save()

    index = PercentEventsPerLanguage.objects.count()

    last_per_language = PercentEventsPerLanguage.objects[index - 1]
    last_per_age_range = PercentEventsPerAgeRange.objects[index - 1]
    last_temporal = QuantityOfRegisteredEvents.objects[index - 1]

    urls_files = open("./urls.yaml", 'r')
    urls = yaml.load(urls_files)

    new_per_language = last_per_language.total_events_per_language
    new_per_age_range = last_per_age_range.total_events_per_age_range
    new_temporal = last_temporal.total_events_registered_per_mounth_per_year

    for url in urls:
        request = RequestEventsRawData(str(last_per_language.create_date), url)

        new_per_language = build_language_indicator(request.data, new_per_language)
        new_per_age_range = build_age_range_indicator(request.data, new_per_age_range)
        new_temporal = build_temporal_indicator(request.data, new_temporal)

    new_create_date = datetime.now()
    new_total = last_per_language.total_events + request.data_length

    PercentEventsPerLanguage(new_total, new_create_date, new_per_language).save()
    PercentEventsPerAgeRange(new_total, new_create_date, new_per_age_range).save()
    QuantityOfRegisteredEvents(new_total, new_create_date, new_temporal).save()
