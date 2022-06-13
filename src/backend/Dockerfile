FROM python:3-alpine

RUN pip install -U pip

WORKDIR /usr/src/app
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
RUN python manage.py migrate

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8080", "backend.wsgi:application"]
EXPOSE 8080