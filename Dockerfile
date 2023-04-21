FROM python:3

RUN apt update && apt upgrade -y

RUN pip install --upgrade pip && \
    pip install pyopenssl ansible

ARG WORKDIR=/work

RUN mkdir ${WORKDIR}

ADD ansible ${WORKDIR}
ADD create-cert.sh ${WORKDIR}/

WORKDIR ${WORKDIR}

RUN ansible-playbook setup.yaml

ENV USE_CA=false

ENTRYPOINT ["./create-cert.sh"]
