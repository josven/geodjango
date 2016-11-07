FROM ubuntu:16.04

MAINTAINER Janusz Skonieczny @wooyek

# Install tooling for test debuging and libraries needed by geodjango.
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y git unzip nano wget sudo curl \
    libxml2-dev libxslt1-dev build-essential libpq-dev \
    libjpeg8 libjpeg62-dev libfreetype6 libfreetype6-dev \
    python python-dev python-pip python-virtualenv supervisor \
    python3 python3-dev python3-pip python3-venv \
    postgresql postgresql-contrib postgis \
    libsqlite3-mod-spatialite && \
    python -m pip install pip -U && \
    python3 -m pip install pip -U && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \

    pip install invoke pathlib tox coverage pylint -U && \
    pip3 install invoke tox coverage pylint -U


ENV PYTHONIOENCODING=utf-8


# Pass this envrioment variables through a file
# https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file
# They will be used to create a default database on start

ENV DATABASE_NAME=application-db
ENV DATABASE_TEST_NAME=test_application-db
ENV DATABASE_PASSWORD=application-db-password
ENV DATABASE_USER=application-user-user
ENV DATABASE_HOST=127.0.0.1

ENTRYPOINT ["docker-entrypoint.sh"]