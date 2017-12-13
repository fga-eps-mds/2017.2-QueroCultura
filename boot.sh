#!/bin/bash

python3 manage.py runserver 0.0.0.0:8000 &

sleep 3

rm celerybeat.pid &

sleep 3

celery -A quero_cultura worker -l info &

sleep 3

celery -A quero_cultura beat -l info
