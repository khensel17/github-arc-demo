FROM ghcr.io/actions/actions-runner:2.326.0

USER root

RUN apt update && \
    apt install python3 python3-pip python3-yaml python3-dateutil -y

RUN pip3 install --upgrade pip
RUN pip3 install ansible ansible-core ansible-lint pytz jmespath molecule molecule-plugins[docker] yamllint

USER runner
