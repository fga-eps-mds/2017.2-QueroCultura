import os
from datetime import datetime
from datetime import timedelta
from celery import Celery
from celery.schedules import crontab


def create_task(task_name, schedule, expire=0):
    now = datetime.now()
    task = {'task': task_name,
            'schedule': schedule}
    if expire != 0:
        options = {'expires': now + timedelta(seconds=expire)}
        task['options'] = options
    return task


# set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'quero_cultura.settings')

APP = Celery('quero_cultura')

# Using a string here means the worker don't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#   should have a `CELERY_` prefix.
APP.config_from_object('django.conf:settings', namespace='CELERY')

# Load task modules from all registered Django app configs.
APP.autodiscover_tasks()


@APP.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))


APP.conf.beat_schedule = {
    'load_agents': create_task('load_agents', 30, 50),
    'update_agents': create_task('load_agents',
                                 crontab(minute=0, hour=3,
                                         day_of_week='sunday')),

    'load_libraries': create_task('load_libraries', 30, 50),
    'update_libraries': create_task('load_libraries',
                                    crontab(minute=5, hour=3,
                                            day_of_week='sunday')),

    'load_museums': create_task('load_museums', 30, 50),
    'update_museums': create_task('load_museums',
                                  crontab(minute=5, hour=3,
                                          day_of_week='sunday')),

    'load_events': create_task('load_events', 30, 50),
    'update_events': create_task('load_events',
                                 crontab(minute=10, hour=3,
                                         day_of_week='sunday')),

    'load_projects': create_task('load_projects', 30, 50),
    'update_projects': create_task('load_projects',
                                   crontab(minute=15, hour=3,
                                           day_of_week='sunday')),

    'load_spaces': create_task('load_spaces', 30, 50),
    'update_spaces': create_task('load_spaces',
                                 crontab(minute=20, hour=3,
                                         day_of_week='sunday')),
    }
