import os
from celery import Celery
from celery.schedules import crontab
from celery.signals import beat_init


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
        'schedule': crontab(minute=25,
                            hour=16,
                            day_of_week='tuesday'),
        'args': ["http://mapas.cultura.gov.br/api/agent/find/"],
    },
}
