from django.shortcuts import render
from .api_connections import RequestMuseumRawData
from .models import PercentThematicsMuseums
from .models import PercentTypeMuseums
from .models import PercentPublicOrPrivateMuseums
from .models import AmountMuseumsRegisteredYear
from .models import PercentMuseumsPromoteGuidedTour
from .models import PercentMuseumsHistoricalArchivePublicAccess
from quero_cultura.views import build_temporal_indicator
from quero_cultura.views import build_simple_indicator
from quero_cultura.views import merge_indicators
from project_indicators.views import prepare_single_indicator_list
from project_indicators.views import prepare_single_temporal_vision
from datetime import datetime
import json

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"


#Busca os indicadores já cadastrados
def load_current_musuem_indicators():
    indicators = []
    index = PercentTypeMuseums.objects.count()

    #Busca no banco os ultimos cadastros
    last_per_type = PercentTypeMuseums.objects[index - 1]
    last_per_thematic = PercentThematicsMuseums.objects[index - 1]
    last_per_sphere = PercentPublicOrPrivateMuseums.objects[index - 1]
    last_temporal = AmountMuseumsRegisteredYear.objects[index - 1]
    last_guided_tour = PercentMuseumsPromoteGuidedTour.objects[index - 1]
    last_public_archive = PercentMuseumsHistoricalArchivePublicAccess.objects[index - 1]

    new_total = last_per_type.total_museums
    last_update_date = last_per_type.create_date

    #Adiciona as informações na lista de indicadores
    indicators.append(last_temporal.total_museums_registered_year)

    indicators.append(last_per_type.type_museums)
    indicators.append(last_per_thematic.thmeatics_museums)
    indicators.append(last_per_sphere.total_public_private_museums)
    indicators.append(last_guided_tour.total_museums_promote_guide)
    indicators.append(last_public_archive.total_museums_historical)

    return new_total, last_update_date, indicators

#Faz a request e traz os novos dados
def request_museum_new_data(new_total, last_update_date, temporal_indicator):
    indicators = []

    request = RequestMuseumRawData(last_update_date)
    new_total += request.data_length

    #O indicador temporal necessita de new e old data, sendo assim, há o indicador é calculado aqui.
    indicators.append(build_temporal_indicator(request.data, temporal_indicator))

    indicators.append(build_simple_indicator(request.data, "mus_tipo"))
    indicators.append(build_simple_indicator(request.data, "mus_tipo_tematica"))
    indicators.append(build_simple_indicator(request.data, "esfera"))
    indicators.append(build_simple_indicator(request.data, "mus_servicos_visitaGuiada"))
    indicators.append(build_simple_indicator(request.data, "mus_arquivo_acessoPublico"))


    return new_total, indicators

# Atualiza os dados no banco
def update_museum_indicator(new_total, new_data, old_data):

    merged_data = []
    new_create_date = str(datetime.now())
    temporal_indicator = new_data[0]

    for i in range(1,6):
        merged_data.append(merge_indicators(new_data[i], old_data[i]))

    PercentTypeMuseums(new_total, new_create_date, merged_data[0]).save()
    PercentThematicsMuseums(new_total, new_create_date, merged_data[1]).save()
    PercentPublicOrPrivateMuseums(new_total, new_create_date, merged_data[2]).save()
    PercentMuseumsPromoteGuidedTour(new_total, new_create_date, merged_data[3]).save()
    PercentMuseumsHistoricalArchivePublicAccess(new_total, new_create_date, merged_data[4]).save()
    AmountMuseumsRegisteredYear(temporal_indicator, new_create_date).save()


def index(request):

    #Busca no banco indicadores consolidados
    indicators = load_current_musuem_indicators()[2]

    #Prepara visualização dos indicadores
    total_temporal = prepare_single_temporal_vision(indicators[0])
    total_per_type = prepare_single_indicator_list(indicators[1], "total_per_type")
    total_per_thematic = prepare_single_indicator_list(indicators[2], "total_per_thematic")
    total_per_sphere = prepare_single_indicator_list(indicators[3], "total_per_sphere")
    total_guided_tour = prepare_single_indicator_list(indicators[4], "total_guided_tour")
    total_archive = prepare_single_indicator_list(indicators[5], "total_archive")

    #Criação do Context
    context = {
        'keys_total_temporal': json.dumps(total_temporal['keys_total_temporal']),
        'growth_total_temporal': json.dumps(total_temporal['growth_total_temporal']),
        'keys_per_type': json.dumps(total_per_type['keys_total_per_type']),
        'values_per_type': json.dumps(total_per_type['values_total_per_type']),
        'keys_total_per_thematic': json.dumps(total_per_thematic['keys_total_per_thematic']),
        'values_total_per_thematic': json.dumps(total_per_thematic['values_total_per_thematic']),
        'keys_total_per_sphere': json.dumps(total_per_sphere['keys_total_per_sphere']),
        'values_total_per_sphere': json.dumps(total_per_sphere['values_total_per_sphere']),
        'values_total_guided_tour': json.dumps(total_guided_tour['values_total_guided_tour']),
        'keys_total_guided_tour': json.dumps(total_guided_tour['keys_total_guided_tour']),
        'values_total_archive': json.dumps(total_archive['values_total_archive']),
        'keys_total_archive': json.dumps(total_archive['keys_total_archive']),
    }

    return render(request, 'museums_indicators/museums-indicators.html', context)



#Tarefa responsável por buscar dados da base e da api e altera-los no banco
def periodic_update():
    if len(PercentTypeMuseums.objects) == 0:
        PercentTypeMuseums(0, DEFAULT_INITIAL_DATE, {'None': 0}).save()
        PercentThematicsMuseums(0, DEFAULT_INITIAL_DATE, {'None': 0}).save()
        PercentPublicOrPrivateMuseums(0, DEFAULT_INITIAL_DATE, {'None': 0}).save()
        AmountMuseumsRegisteredYear({'2015': {'01': 0}}, DEFAULT_INITIAL_DATE).save()
        PercentMuseumsPromoteGuidedTour(0, DEFAULT_INITIAL_DATE, {'None': 0}).save()
        PercentMuseumsHistoricalArchivePublicAccess(0, DEFAULT_INITIAL_DATE, {'None': 0}).save()

    new_total, last_update_date, old_data = load_current_musuem_indicators()

    old_temporal_data = old_data[0]

    new_total, new_data = request_museum_new_data(new_total, last_update_date, old_temporal_data)

    update_museum_indicator(new_total, new_data, old_data)
