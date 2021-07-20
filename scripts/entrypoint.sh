#!/bin/sh

set -e

python manage.py migrate --no-input
python manage.py collectstatic --no-input
# gunicorn config.wsgi:application --bind 0.0.0.0:8000

uwsgi --socket :8000 --master --enable-threads --module config.wsgi --vacuum