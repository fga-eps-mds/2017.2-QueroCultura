from django.shortcuts import render
import yaml
import jwt


METABASE_SECRET_KEY = "1798c3ba25f5799bd75538a7fe2896b79e24f3ec1df9d921558899dc690bbcd9"
METABASE_SITE_URL = "http://0.0.0.0:3000"


def index(request):
    return render(request, 'quero_cultura/index.html', {})


class ParserYAML(object):
    def __init__(self):
        self._urls_files = open("./urls.yaml", 'r')
        self._urls = yaml.load(self._urls_files)
        self._multi_instances_urls = self._urls['multi-instancias']

    @property
    def get_multi_instances_urls(self):
        return self._multi_instances_urls


def get_metabase_url(view_type, number):
    payload = {"resource": {view_type: number},
               "params": {}}

    token = jwt.encode(payload, METABASE_SECRET_KEY, algorithm='HS256')
    token = str(token).replace("b'", "")
    token = token.replace("'", "")

    return METABASE_SITE_URL + "/embed/" + view_type + "/" + token + "#bordered=true&titled=true"



def instaces_counter():
    parser_yaml = ParserYAML()
    count = len(parser_yaml.get_multi_instances_urls)

    return count
