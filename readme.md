![OHDSI](https://www.ohdsi.org/wp-content/uploads/2015/02/h243-ohdsi-logo-with-text.png)

# OHDSI Dockerfiles

The respository contains Dockerfiles to set up the various OHDSI tools.

## WebAPI

The [OHDSI WebAPI](https://github.com/OHDSI/WebAPI) contains all OHDSI services
that can be called from OHDSI applications.

### Quickstart

Use the following command to spin up the WebAPI. Make sure to change the values
of the environment variables as needed.

```
docker run \
  --name ohdsi-webapi \
  -p 8080:8080 \
  -e "DBHOST=docker.for.mac.host.internal" \
  -e "DBNAME=cdm" \
  -e "DBUSER=postgres" \
  -e "DBPASS=s3cret" \
  -e "DBADMINUSER=postgres" \
  -e "DBADMINPASS=s3cret" \
  -e "DBCDMSCHEMA=public" \
  -e "DBWEBAPISCHEMA=webapi" \
  uwcarg/ohdsi-webapi:2.3.0-postgres
```

:bulb: `docker.for.mac.host.internal` is a magic constant in Docker for macOS
that points to the IP address of the host machine.

### Test

Navigate to the following URLS to test:
* http://localhost:8080/WebAPI/source/sources
* http://localhost:8080/WebAPI/vocabulary/search/cardiomyopathy

[README ≫](WebAPI)

## License

[![CC BY-SA](https://licensebuttons.net/l/by-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0/)
