FROM ubuntu:16.04

MAINTAINER Janusz Skonieczny @wooyek
LABEL version="0.9.7"


RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install software-properties-common \
    && add-apt-repository ppa:git-core/ppa \
    && add-apt-repository ppa:jonathonf/python-3.6 \
    && add-apt-repository ppa:git-core/ppa \
    && apt-get redis-server software-properties-common curl git unzip nano wget sudo build-essential python python-dev python-pip python-virtualenv spatialite-bin libsqlite3-mod-spatialite postgresql-client-common libpq-dev postgresql postgresql-contrib postgis libproj-dev libfreexl-dev libgdal-dev gdal-bin python3.6 python3.6-dev \
    && apt-get -y install redis-server \
    && apt-get -y upgrade \
    && curl -o /tmp/get-pip.py "https://bootstrap.pypa.io/get-pip.py" \
    && pip install invoke pathlib tox coverage pylint -U \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get remove -y curl \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*



ENV PYTHONIOENCODING=utf-8

# Pass this envrioment variables through a file
# https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file
# They will be used to create a default database on start

ENV DATABASE_NAME=application-db \
    DATABASE_PASSWORD=application-db-password \
    DATABASE_USER=application-user-user \
    DATABASE_HOST=127.0.0.1 \
    DATABASE_TEST_NAME=application-test-db

COPY geodjango-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/geodjango-entrypoint.sh
ENTRYPOINT ["geodjango-entrypoint.sh"]
