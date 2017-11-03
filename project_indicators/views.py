from django.shortcuts import render
from quero_cultura.views import build_temporal_indicator
from .models import PercentProjectPerType
from .models import PercentProjectThatAcceptOnlineTransitions
from .models import QuantityOfRegisteredProject


def index(request):

    # Cria dicionario para apresentação dos graficos de indicadores
    context = {}

    # Renderiza pagina e envia dicionario para apresentação dos graficos
    return render(request, 'project_indicators/project-indicators.html', context)


def build_type_indicator(new_data, old_data):
    per_type = {}

    for project in new_data:
        if not (project["type"]["name"] in per_type):
            per_type[project["type"]["name"]] = 1
        else:
            per_type[project["type"]["name"]] += 1

    for project in old_data:
        if not (project in per_type):
            per_type[project] = old_data[project]
        else:
            per_type[project] += old_data[project]

    return per_type
