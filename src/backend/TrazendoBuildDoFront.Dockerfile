# Para executar vá para o diretório acima deste e execute:
# docker build -t backmigrate -f .\backend\TrazendoBuildDoFront.Dockerfile .

# Vamos gerar o build do frontend para usar no back
FROM node:16-alpine AS frontend
RUN npm install -g npm@8.12.1
WORKDIR /usr/src/app
COPY ./frontend/package.json .
COPY ./frontend/package-lock.json .
RUN npm install
COPY ./frontend/ .
RUN npm run build

# Para um container menor, a versão alpine é ótima
FROM python:3-alpine
# Atualizando o pip
RUN pip install -U pip
# Instalando as libs do projeto sem cache pra não gerar um container maior
WORKDIR /usr/src/app
COPY ./backend/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
# Copiando o projeto e atualizando o banco de dados
COPY ./backend/ .
RUN python manage.py migrate
# Trazendo os estáticos do frontend
RUN mkdir ./static
COPY --from=frontend /usr/src/app/dist/frontend/ ./static/
# Executando o projeto com o gunicorn
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8080", "backend.wsgi:application"]
EXPOSE 8080