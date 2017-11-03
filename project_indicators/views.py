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
