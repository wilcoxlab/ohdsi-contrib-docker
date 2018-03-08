FROM nginx:1.13.9-alpine

RUN apk --update add gettext curl

WORKDIR /tmp/ohdsi/atlas

RUN curl -fsSL -o /tmp/ohdsi/atlas/atlas.tar.gz https://github.com/OHDSI/Atlas/archive/v2.3.0.tar.gz
RUN tar -xzf /tmp/ohdsi/atlas/atlas.tar.gz -C /usr/share/nginx/html --strip-components=1

COPY entrypoint.sh /entrypoint.sh
COPY config-local.js /config-local.js

ENV WEBAPIURL localhost
ENV ORGNAME Atlas

CMD ["/entrypoint.sh"]
