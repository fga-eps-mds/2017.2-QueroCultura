from django.shortcuts import render


# Create your views here.

def index(request):

    # Cria dicionario para apresentação dos graficos de indicadores
    context = {}

    # Renderiza pagina e envia dicionario para apresentação dos graficos
    return render(request, 'project_indicators/project-indicators.html', context)
