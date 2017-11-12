from django.shortcuts import render
import jwt

METABASE_SITE_URL = "http://0.0.0.0:3000"
METABASE_SECRET_KEY = "1798c3ba25f5799bd75538a7fe2896b79e24f3ec1df9d921558899dc690bbcd9"


def index(request):

    payload = {"resource": {"question": 1},
               "params": {}}

    token = jwt.encode(payload, METABASE_SECRET_KEY, algorithm='HS256')
    token = str(token).replace("b'", "")
    token = token.replace("'", "")

    i_frame_url = METABASE_SITE_URL + "/embed/question/" + token + "#bordered=true&titled=true"
    url = {"url": i_frame_url}

    return render(request, 'space_indicators/space-indicators.html', url)
