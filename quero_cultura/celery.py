import os
from celery import Celery
from celery.schedules import crontab
from datetime import timedelta
from datetime import datetime

# set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'quero_cultura.settings')

app = Celery('quero_cultura')

# Using a string here means the worker don't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#   should have a `CELERY_` prefix.
app.config_from_object('django.conf:settings', namespace='CELERY')

# Load task modules from all registered Django app configs.
app.autodiscover_tasks()


@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))


app.conf.beat_schedule = {
    'update_agent_indicator': {
        'task': 'update_agent_indicator',
        'schedule': crontab(minute=0,
                            hour=3,
                            day_of_week='sunday'),
    },
    'update_agent_indicator_now': {
        'task': 'update_agent_indicator',
        'schedule': 10.0,
        'options': {
            'expires': datetime.now() + timedelta(seconds=15.0),
        },
    },
    'update_libray_indicator': {
        'task': 'update_library_indicator',
        'schedule': crontab(minute=5,
                            hour=3,
                            day_of_week='sunday'),
    },
    'update_libray_indicator_now': {
        'task': 'update_library_indicator',
        'schedule': 20.0,
        'options': {
            'expires': datetime.now() + timedelta(seconds=30.0),
        },
    },
    'update_event_indicator': {
        'task': 'update_event_indicator',
        'schedule': crontab(minute=10,
                            hour=3,
                            day_of_week='sunday'),
    },
    'update_event_indicator_now': {
        'task': 'update_event_indicator',
        'schedule': 15.0,
        'options': {
            'expires': datetime.now() + timedelta(seconds=20.0),
        },
    },
    'populate_project_data': {
        'task': 'populate_project_data',
        'schedule': crontab(minute=15,
                            hour=3,
                            day_of_week='sunday'),
    },
    'populate_project_data_now': {
        'task': 'populate_project_data',
        'schedule': 25.0,
        'options': {
            'expires': datetime.now() + timedelta(seconds=35.0),
        },
    },
    'populate_space_data': {
        'task': 'populate_space_data',
        'schedule': crontab(minute=20,
                            hour=3,
                            day_of_week='sunday'),
    },
    'populate_space_data_now': {
        'task': 'populate_space_data',
        'schedule': 30.0,
        'options': {
            'expires': datetime.now() + timedelta(seconds=45.0),
        },
    },
    # 'periodic_update': {
    #     'task': 'periodic_update',
    #     'schedule': crontab(minute=25,
    #                         hour=3,
    #                         day_of_week='sunday'),
    # },
    # 'periodic_update_now': {
    #     'task': 'periodic_update',
    #     'schedule': 35.0,
    #     'options': {
    #         'expires': datetime.now() + timedelta(seconds=50.0),
    #     },
    # },
}
