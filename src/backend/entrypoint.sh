python manage.py makemigrations
python manage.py migrate
python manage.py createcachetable

if [ "$DJANGO_SUPERUSER_USERNAME" ]
then
    python manage.py createsuperuser \
        --noinput \
        --username $DJANGO_SUPERUSER_USERNAME \
        --email $DJANGO_SUPERUSER_EMAIL
fi

gunicorn -w 4 -b 0.0.0.0:9000 backend.wsgi:application

$@