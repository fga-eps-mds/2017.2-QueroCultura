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
    'populate_library_data': {
        'task': 'populate_library_data',
        'schedule': crontab(minute=5,
                            hour=3,
                            day_of_week='sunday'),
    },
    'populate_library_data_now': {
        'task': 'populate_library_data',
        'schedule': 20.0,
        'options': {
            'expires': datetime.now() + timedelta(seconds=30.0),
        },
    },
    'populate_event_data': {
        'task': 'populate_event_data',
        'schedule': crontab(minute=10,
                            hour=3,
                            day_of_week='sunday'),
    },
    'populate_event_data_now': {
        'task': 'populate_event_data',
        'schedule': 15.0,
        'options': {
            'expires': datetime.now() + timedelta(seconds=25.0),
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
    'populate_museum_data': {
        'task': 'populate_museum_data',
        'schedule': crontab(minute=25,
                            hour=3,
                            day_of_week='sunday'),
    },
    'populate_museum_data_now': {
        'task': 'populate_museum_data',
        'schedule': 40.0,
        'options': {
            'expires': datetime.now() + timedelta(seconds=60.0),
        },
    },
}
