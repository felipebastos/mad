# Para um container menor, a versão alpine é ótima
FROM python:3-alpine
# Instalando o cliente mysql no sistema
RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add --no-cache mariadb-dev
# Atualizando o pip
RUN pip install -U pip
# Instalando as libs do projeto sem cache pra não gerar um container maior
WORKDIR /usr/src/app
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
RUN apk del build-deps
# Copiando o projeto e atualizando o banco de dados
COPY . .
# Executando o projeto com o gunicorn
ENTRYPOINT [ "sh", "entrypoint.sh" ]
EXPOSE 9000