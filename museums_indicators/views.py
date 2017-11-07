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
from datetime import datetime

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
