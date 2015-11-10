FROM java:7

MAINTAINER Ben Heasly <benjamin.heasly@gmail.com>

### dependencies?
RUN apt-get update \
    && apt-get install -y \
    wget \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove

### download archiva binary
WORKDIR /opt/archiva
RUN wget http://apache.spinellicreations.com/archiva/2.2.0/binaries/apache-archiva-2.2.0-bin.tar.gz \
    && tar -xzf apache-archiva-2.2.0-bin.tar.gz

### separate base and config from binary
WORKDIR /var/archiva
RUN mkdir logs
RUN mkdir data
RUN mkdir temp
RUN cp -r /opt/archiva/apache-archiva-2.2.0/conf /var/archiva
ENV ARCHIVA_BASE /var/archiva

### let er rip
CMD ["/opt/archiva/apache-archiva-2.2.0/bin/archiva", "start"]
