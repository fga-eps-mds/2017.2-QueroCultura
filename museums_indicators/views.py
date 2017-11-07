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

#faz a request
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

#consilidação do indicador
