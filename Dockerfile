FROM ubuntu:trusty
MAINTAINER Yves Serrano <y@yas.ch>

RUN apt-get update && apt-get install -y software-properties-common && \
    apt-add-repository ppa:ansible/ansible && \
    apt-get update && apt-get install -y \
        ansible \
    && rm -rf /var/lib/apt/lists/* && \
    mkdir /root/.ssh && chmod 0600 /root/.ssh
COPY ./root/_ssh_insecure/id_rsa ./root/_ssh_insecure/id_rsa.pub /root/.ssh/
COPY etc/ansible /etc/ansible
RUN chmod -x /etc/ansible/*
CMD ["play.yml"]
ENTRYPOINT ["ansible-playbook"]
