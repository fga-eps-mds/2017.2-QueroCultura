FROM python:3
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/

FROM node:boron
WORKDIR /code
RUN npm install
RUN npm install --save read-yaml
ADD . /code/
