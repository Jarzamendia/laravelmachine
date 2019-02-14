FROM nginx:1.14.2-alpine

#REMOVE!
ENV http_proxy=http://proxy.sgi.ms.gov.br:8081
ENV https_proxy=http://proxy.sgi.ms.gov.br:8081
ENV no_proxy="localhost,127.0.0.1"

COPY ntpd.conf /etc/ntpd.conf

RUN apk update \
    && apk upgrade \
    && apk add --no-cache openssl \
    && apk add --no-cache ca-certificates \
    && apk add --no-cache tzdata \
    && apk add --no-cache bash \
    && adduser -D -H -u 1000 -s /bin/bash www-data

RUN echo "export LANG=pt_BR.UTF-8" > /etc/profile.d/locale.sh && \
    cp /usr/share/zoneinfo/America/Campo_Grande /etc/localtime && \
    echo "America/Campo_Grande" >  /etc/timezone && \
    apk del tzdata && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

COPY nginx.conf /etc/nginx/

ADD ./startup.sh /opt/startup.sh

RUN sed -i 's/\r//g' /opt/startup.sh

VOLUME /etc/nginx/ssl

CMD ["/bin/sh", "/opt/startup.sh"]

EXPOSE 80 443