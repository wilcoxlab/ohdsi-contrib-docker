#!/bin/sh

echo "Replacing config..."
envsubst < /usr/local/tomcat/webapps/WebAPI/WEB-INF/classes/application.properties-old > /usr/local/tomcat/webapps/WebAPI/WEB-INF/classes/application.properties
echo "Config replacement completed with status $?"

echo "Preparing default source config..."
envsubst < /V1.0.5.0.1__Install_default_source.sql > /usr/local/tomcat/webapps/WebAPI/WEB-INF/classes/db/migration/postgresql/V1.0.5.0.1__Install_default_source.sql 
echo "Default source config preparation completed with status $?"

echo "Starting tomcat..."
exec catalina.sh run
