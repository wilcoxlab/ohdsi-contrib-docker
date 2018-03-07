FROM maven:3.5.2-jdk-8-alpine AS builder

ARG WEB_API_VERSION=2.3.0

COPY settings.xml /tmp/ohdsi/webapi/settings.xml
 
WORKDIR /tmp/ohdsi/webapi

RUN curl -fsSL -o /tmp/ohdsi/webapi/webapi.tar.gz https://github.com/OHDSI/WebAPI/archive/v${WEB_API_VERSION}.tar.gz
RUN tar -xzf /tmp/ohdsi/webapi/webapi.tar.gz -C /tmp/ohdsi/webapi --strip-components=1

RUN cd /tmp/ohdsi/webapi \
  && mvn clean package -s settings.xml -P webapi-postgresql

FROM tomcat:8.5.28-alpine

RUN apk --update add gettext
RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /tmp/ohdsi/webapi/target/WebAPI  /usr/local/tomcat/webapps/WebAPI

COPY entrypoint.sh /entrypoint.sh
COPY V1.0.5.0.1__Install_default_source.sql /V1.0.5.0.1__Install_default_source.sql

ENV DBHOST localhost
ENV DBPORT 5432
ENV DBNAME OHDSI
ENV DBUSER ohdsi_app_user
ENV DBPASS app1
ENV DBCDMSCHEMA ohdsi
ENV DBWEBAPISCHEMA webapi
ENV DBADMINUSER ohdsi_admin_user
ENV DBADMINPASS !PASSWORD!
ENV WEBAPIHOST localhost
ENV WEBAPIPORT 8080

RUN mv /usr/local/tomcat/webapps/WebAPI/WEB-INF/classes/application.properties /usr/local/tomcat/webapps/WebAPI/WEB-INF/classes/application.properties-old

CMD ["/entrypoint.sh"]
