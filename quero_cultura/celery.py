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
    'update_agents': create_task('update_agent_indicator',
                                 crontab(minute=0, hour=3,
                                         day_of_week='sunday')),
    'load_agents': create_task('update_agent_indicator', 10, 15),
    'update_libraries': create_task('update_library_indicator',
                                    crontab(minute=5, hour=3,
                                            day_of_week='sunday')),
    'load_libraries': create_task('update_library_indicator', 20, 30),
    'update_events': create_task('update_event_indicator',
                                 crontab(minute=10, hour=3,
                                         day_of_week='sunday')),
    'load_events': create_task('update_event_indicator', 15, 20),
    'update_projects': create_task('update_project_indicator',
                                   crontab(minute=15, hour=3,
                                           day_of_week='sunday')),
    'load_projects': create_task('update_project_indicator', 25, 35),
    'update_spaces': create_task('populate_space_data',
                                 crontab(minute=20, hour=3,
                                         day_of_week='sunday')),
    'load_spaces': create_task('populate_space_data', 30.0, 45),
    'load_new_markers': create_task('load_new_markers', crontab(minute='*/3')),
}
