FROM debian:jessie

MAINTAINER Anthony K GROSS

RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y curl ca-certificates

# Install Gosu
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

RUN rm -rf /var/lib/apt/lists/* && apt-get autoremove -y --purge

ADD bash_profile /root/.bash_profile

RUN echo "\nsource ~/.bash_profile" >> /root/.bashrc && \
    useradd -u 1000 docker --create-home