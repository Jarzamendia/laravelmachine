FROM nginx:1.14.2-alpine

#REMOVE!
ENV http_proxy=http://proxy.sgi.ms.gov.br:8081
ENV https_proxy=http://proxy.sgi.ms.gov.br:8081
ENV no_proxy="localhost,127.0.0.1"

RUN apk update \
    && apk upgrade \
    && apk add --no-cache openssl \
    && apk add --no-cache bash \
    && adduser -D -H -u 1000 -s /bin/bash www-data

COPY nginx.conf /etc/nginx/

ADD ./startup.sh /opt/startup.sh

RUN sed -i 's/\r//g' /opt/startup.sh

VOLUME /etc/nginx/ssl

CMD ["/bin/sh", "/opt/startup.sh"]

EXPOSE 80 443