from datetime import datetime
from .api_connections import RequestMuseumRawData
from .models import LastUpdateMuseumDate
from .models import MuseumData
from .models import LastUpdateMuseumDate
from .views import populate_museum_data
import requests_mock
import json


class TestLastUpdateMuseumDate(object):

    def test_last_update_museum_date(self):
        LastUpdateMuseumDate.drop_collection()
        create_date = datetime.now().__str__()
        LastUpdateMuseumDate(create_date).save()
        query = LastUpdateMuseumDate.objects.first()
        assert query.create_date == create_date


class TestMuseumData(object):

    def test_museum_data(self):
        MuseumData.drop_collection()
        instance = "SP"
        museum_type = "Cia"
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        thematic = "Teatro"
        sphere = "None"
        guided_tuor = "None"
        public_archive = "None"

        MuseumData(instance, museum_type, thematic, sphere,
                   guided_tuor, public_archive, date).save()
        query = MuseumData.objects.first()
        assert query.instance == instance
        assert query.museum_type == museum_type
        assert query.thematic == thematic
        assert query.sphere == sphere
        assert query.guided_tuor == guided_tuor
        assert query.public_archive == public_archive
        assert query.date == date


class TestRequestMuseumRawData(object):
    @requests_mock.Mocker(kw='mock')
    def test_request_museum_raw_data(self, **kwargs):
        url = "http://museus.cultura.gov.br/api/"

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "esfera": "Publica", "mus_tipo": 'None',
                   "mus_tipo_tematica": 'None',
                   "mus_servicos_visitaGuiada": 'None',
                   "mus_arquivo_acessoPublico": 'None'}]

        kwargs['mock'].get(url+"space/find/", text=json.dumps(result))

        current_time = datetime.now().__str__()
        raw_data = RequestMuseumRawData(current_time, url)
        assert raw_data.response.status_code == 200
        assert raw_data.data == result
        assert raw_data.data_length == 1


class TestPopulateMuseumData(object):
    @requests_mock.Mocker(kw='mock')
    def test_populate_museum_data(self, **kwargs):
        url = "http://museus.cultura.gov.br/api/"

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "esfera": "Publica", "mus_tipo": 'None',
                   "mus_tipo_tematica": 'None',
                   "mus_servicos_visitaGuiada": 'None',
                   "mus_arquivo_acessoPublico": 'None'}]

        kwargs['mock'].get(url+"space/find/", text=json.dumps(result))

        LastUpdateMuseumDate.drop_collection()
        MuseumData.drop_collection()

        populate_museum_data()

        assert LastUpdateMuseumDate.objects.count() != 0
        assert MuseumData.objects.count() != 0
