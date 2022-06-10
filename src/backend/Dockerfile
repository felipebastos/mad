FROM python:3-alpine

RUN pip install -U pip

WORKDIR /usr/src/app
COPY requirements.txt ./requirements.txt
RUN pip install -r --no-cache-dir requirements.txt

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8080", "wsgi:app"]
EXPOSE 8080