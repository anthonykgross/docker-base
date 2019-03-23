FROM ubuntu:18.04

MAINTAINER Anthony K GROSS

ENV TZ=Europe/Paris

RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y curl ca-certificates gnupg2 apt-utils software-properties-common && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Install Gosu
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

RUN rm -rf /var/lib/apt/lists/* && apt-get autoremove -y --purge && \
    useradd -u 1000 docker --create-home

ADD bash_profile /home/docker/.bash_profile

RUN ln -s /home/docker/.bash_profile /root/.bash_profile && \
    echo "\nsource ~/.bash_profile" >> /root/.bashrc && \
    echo "\nsource ~/.bash_profile" >> /home/docker/.bashrc

WORKDIR /src
