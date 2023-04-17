# FROM debian
FROM python:3

RUN apt update && apt upgrade -y

RUN pip install --upgrade pip && \
    pip install pyopenssl ansible
