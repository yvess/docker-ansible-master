FROM ubuntu
MAINTAINER Yves Serrano <y@yas.ch>

RUN apt-get update && apt-get install -y software-properties-common
RUN apt-add-repository ppa:ansible/ansible
RUN apt-get update && apt-get install -y \
        ansible \
    && rm -rf /var/lib/apt/lists/*

ADD ./root/insecure_key /root/.ssh/id_rsa
ADD ./root/insecure_key.pub /root/.ssh/id_rsa.pub
RUN chmod 0600 /root/.ssh/id_rsa*
COPY etc/ansible /etc/ansible
RUN chmod -x /etc/ansible/*
ENTRYPOINT tail -f /var/log/dmesg
