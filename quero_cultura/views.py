import datetime
from django.shortcuts import render
from .api_connections import RequestMarkersRawData, save_markers_data
from .models import Marker, LastRequest
from celery.decorators import task
from django.http import JsonResponse
import yaml
import jwt


METABASE_SECRET_KEY = "1798c3ba25f5799bd75538a7fe2896b79e24f3ec1df9d921558899dc690bbcd9"
METABASE_SITE_URL = "http://querocultura.lab.cultura.gov.br/metabase"

MARKER_TYPES = ['event', 'agent', 'project', 'space']


@task(name='update_markers')
def scheduled_update_markers():
    load_markers(get_time_now())


def load_markers(requested_time):

    parser_yaml = ParserYAML()
    urls = parser_yaml.get_multi_instances_urls
    for url in urls:
        for marker_type in MARKER_TYPES:
            request = RequestMarkersRawData(requested_time,
                                            url, marker_type)
            save_markers_data(request.data, marker_type)


def remove_expired_markers():
    all_markers = Marker.objects.all()

    for marker in all_markers:
        if marker.action_time < (get_time_now() - datetime.timedelta(days=1)):
            marker.delete()


def update_last_request_date(new_date):
    print('UPDATING LAST REQUEST TABLE')
    LastRequest.objects.all().delete()
    last_request_date = LastRequest(new_date)
    last_request_date.save()


def get_last_request_date():
    default_oldest_date = get_time_now() - datetime.timedelta(days=1)
    try:
        last_date = LastRequest.objects.all().order_by('-date')[:1][0].date
        if(last_date < default_oldest_date):
            return default_oldest_date
        else:
            return last_date
    except IndexError as e:
        return default_oldest_date


def get_time_now():
    # 2 hours Timezone GMT-3
    cur_date = datetime.datetime.now() - datetime.timedelta(hours=2)
    return cur_date


def verify_database_state(query_time, valid_request_date):

    cur_date = get_time_now()

    last_request_date = get_last_request_date()

    if (Marker.objects.count() == 0 or cur_date > last_request_date + valid_request_date):
        update_last_request_date(cur_date)
        load_markers(last_request_date)


def get_last_day_markers():

    cur_date = get_time_now()
    one_hour_behind_date = cur_date - datetime.timedelta(hours=1)
    one_day_behind_date = cur_date - datetime.timedelta(days=1)

    day_in_minutes = 1440
    validate_time = datetime.timedelta(hours=2)
    verify_database_state(day_in_minutes, validate_time)

    # this line is needed to not get markers that are in last hour
    behind_one_hour_markers = Marker.objects.filter(
        action_time__lte=one_hour_behind_date)
    last_day_markers = behind_one_hour_markers.filter(
        action_time__gte=one_day_behind_date)

    return convert_mongo_to_dict(last_day_markers)


def convert_mongo_to_dict(mongo_objects):
    result = []
    for marker in mongo_objects:
        # convert mongo object to dict
        new_marker = marker.to_mongo()

        # Destroy objectid object, so that javascript understands
        new_marker['_id'] = ''
        # Convert datetime fields to str, so that JavaScript understands
        try:
            new_marker['update_time_stamp'] = str(
                new_marker['update_time_stamp'])
        except Exception as e:
            new_marker['update_time_stamp'] = ''
        try:
            new_marker['subsite']
        except Exception as e:
            new_marker['subsite'] = "null"
        new_marker['create_time_stamp'] = str(new_marker['create_time_stamp'])
        new_marker['action_time'] = str(new_marker['action_time'])

        result.append(dict(new_marker))

    return result


def get_last_hour_markers():

    hour_in_minutes = 60

    cur_date = get_time_now()
    one_hour_behind_date = cur_date - datetime.timedelta(hours=1)

    verify_database_state(hour_in_minutes, datetime.timedelta(hours=1))

    last_hour_markers = Marker.objects.filter(
        action_time__gte=one_hour_behind_date)

    return convert_mongo_to_dict(last_hour_markers)


def get_last_minutes_markers():

    minutes = 1

    cur_date = get_time_now()
    minutes_behind_date = cur_date - datetime.timedelta(minutes=1)

    verify_database_state(minutes, datetime.timedelta(minutes=1))

    last_minutes_markers = Marker.objects.filter(
        action_time__gte=minutes_behind_date)

    return convert_mongo_to_dict(last_minutes_markers)


def get_last_minutes_markers_json(request):

    last_minutes_markers = get_last_minutes_markers()
    return JsonResponse({'markers': last_minutes_markers})


def get_most_recent_markers():
    ordered_markers = Marker.objects.order_by('-action_time')
    last_minute_markers = []

    n_of_markers = 10

    if len(ordered_markers) >= n_of_markers:
        for i in range(0, n_of_markers):
            last_minute_markers.append(ordered_markers[i])
    else:
        last_minute_markers += ordered_markers

    return convert_mongo_to_dict(last_minute_markers[::-1])


def index(request):
    markers_context = {"get_most_recent_markers": get_most_recent_markers,
                       "get_last_day_markers": get_last_day_markers,
                       "get_last_minutes_markers": get_last_minutes_markers,
                       "get_last_hour_markers": get_last_hour_markers,
                       }
    return render(request, 'quero_cultura/index.html', markers_context)


class ParserYAML(object):

    def __init__(self):
        self._urls_files = open("./urls.yaml", 'r')
        self._urls = yaml.load(self._urls_files)
        self._multi_instances_urls = self._urls['multi-instancias']

    @property
    def get_multi_instances_urls(self):
        return self._multi_instances_urls


def get_metabase_url(view_type, number, has_title):
    payload = {"resource": {view_type: number},
               "params": {}}

    token = jwt.encode(payload, METABASE_SECRET_KEY, algorithm='HS256')
    token = str(token).replace("b'", "")
    token = token.replace("'", "")

    return METABASE_SITE_URL + "/embed/" + view_type + "/" + token + "#bordered=true&titled=" + has_title
