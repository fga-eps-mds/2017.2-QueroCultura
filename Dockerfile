FROM python:3
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/

RUN apt-get update && apt-get install -y varnish && apt-get install nano

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      256m
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600


RUN set -e

EXPOSE 80

RUN pip install -r requirements.txt
ADD . /code/
