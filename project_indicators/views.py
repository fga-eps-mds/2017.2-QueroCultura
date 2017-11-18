from django.shortcuts import render
from quero_cultura.views import ParserYAML
from .api_connections import RequestProjectsRawData
from datetime import datetime
from celery.decorators import task
import json

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"


def index(request):

    # Renderiza pagina e envia dicionario para apresentação dos graficos
    return render(request, 'project_indicators/project-indicators.html')



def clean_url(url):
    clean_url = url.replace(".", "")
    clean_url = clean_url.replace("http://", "")
    clean_url = clean_url.replace("/api/", "")

    return clean_url
