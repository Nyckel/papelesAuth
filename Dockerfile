FROM maven:3.6.1-jdk-11-slim AS provider-build

MAINTAINER Mathis Ouarnier "mathis.ouarnier@gmail.com"

WORKDIR /usr/src/app

FROM jboss/keycloak:7.0.0
EXPOSE 8080

USER root
RUN mkdir /opt/config && \
    chown jboss /opt/config

COPY entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

ADD conf/standalone-ha.xml /opt/jboss/keycloak/standalone/configuration

ADD conf/realm-export.json /opt/config

USER 1000

ENTRYPOINT ["/entrypoint.sh"]

ENV KEYCLOAK_IMPORT /opt/config/realm-export.json
