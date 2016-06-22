FROM java:8

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
RUN wget "$(curl 'http://www.apache.org/dyn/closer.cgi' | grep -o '<strong>[^<]*</strong>' | sed 's/<[^>]*>//g' | head -1)archiva/2.2.0/binaries/apache-archiva-2.2.0-bin.tar.gz" && \
    md5sum apache-archiva-2.2.0-bin.tar.gz > apache-archiva-2.2.0-bin.tar.gz.my.md5 && \
    wget https://www.apache.org/dist/archiva/2.2.0/binaries/apache-archiva-2.2.0-bin.tar.gz.md5 && \
    cmp -s apache-archiva-2.2.0-bin.tar.gz.my.md5 apache-archiva-2.2.0-bin.tar.gz.md5 && \
    tar -xzf apache-archiva-2.2.0-bin.tar.gz && \
    rm apache-archiva-2.2.0-bin.tar.gz*

### separate config and data dirs from binary
ENV ARCHIVA_BASE /var/archiva

### expose contextPath as environment variable
ENV ARCHIVA_CONTEXT_PATH /

### expose archiva port
EXPOSE 8080

### expose archiva volume
VOLUME ["/var/archiva"]

### get our custom run script
ADD run-archiva /opt/archiva/run-archiva

### start archiva, creating config and data dirs if needed
### allows starting fresh or mounting in ARCHIVA_BASE from host
CMD ["/opt/archiva/run-archiva"]
