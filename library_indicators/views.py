from .api_connections import RequestLibraryRawData
from django.shortcuts import render
from celery.decorators import task

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"
urls = ["http://bibliotecas.cultura.gov.br/api/"]


def index(request):

    return render(request, 'library_indicators/library.html')
