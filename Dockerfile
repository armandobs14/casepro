from python:3 as builder

MAINTAINER Armando Barbosa "armandobs14@gmail.com"

### SETTING ENV VARS ###

ENV DB_HOST="db"
ENV DB_PORT="5432"
ENV DB_NAME="casepro"
ENV DB_USER="casepro"
ENV DB_PASSWORD="nyaruka"

### UPDATE SYSTEM AND INSTALLING DEPENDENCIES ###

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gcc \
    python-dev \
    python3-dev \
    npm \
    node-less \
    wget && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g \
    coffee-script \
    less

RUN pip install --upgrade \
    wheel \
    setuptools

RUN pip install --no-cache-dir \
    psycopg2-binary \
    django_compressor \
    psycopg2

WORKDIR /usr/src/app

COPY pip-requires.txt ./requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["sh","/usr/src/app/entrypoint.sh" ]

