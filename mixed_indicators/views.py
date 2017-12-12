from datetime import datetime
from django.shortcuts import render
from .db_connections import RequestMixedIndicatorsRawData
from .models import EventAndSpaceData
from events_indicators.models import EventData


def index(request):
    return render(request, 'quero_cultura/indicators_page.html',
                  {})


def populate_mixed_data(last_update):

    for event in RequestMixedIndicatorsRawData(last_update).data:
        for occurrences in event.occurrences:
            if occurrences['space'] != None:
                if str(occurrences['space']['acessibilidade']).capitalize() != 'None':
                    if occurrences['space']['acessibilidade'] != '':
                        accessible_space = str(occurrences['space'][
                            'acessibilidade']).capitalize()

                        EventAndSpaceData(event.instance, str(
                            accessible_space), event.date).save()
