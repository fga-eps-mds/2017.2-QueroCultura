from django.shortcuts import render

DEFAULT_INITIAL_DATE = "2012-01-01 00:00:00.000000"


def index(request):

    return render(request, 'agents_indicators/agents-indicators.html')
