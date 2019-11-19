<br/><br/><br/>
![UW](https://user-images.githubusercontent.com/668093/37624743-79bae716-2b86-11e8-879d-70a61cc623c6.png)
<br/><br/><br/>

<div align="center">
  <h3>[
    <a href="https://github.com/uwcarg/ohdsi-contrib-docker#webapi">
      WebAPI
    </a>
    <span> | </span>
    <a href="https://github.com/uwcarg/ohdsi-contrib-docker#atlas">
      Atlas
    </a>
    <span> | </span>
    <a href="https://github.com/uwcarg/ohdsi-contrib-docker#achilles">
      Achilles
    </a>
  ]</h3>
</div>


# OHDSI Dockerfiles

The respository contains Dockerfiles to set up various OHDSI tools.

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
  -e "DBVOCABSCHEMA=vocab" \
  -e "DBWEBAPISCHEMA=webapi" \
  uwcarg/ohdsi-webapi:2.6.0-postgres
```

:bulb: `docker.for.mac.host.internal` is a magic constant in Docker for macOS
that points to the IP address of the host machine.

### Test

Navigate to the following URLS to test:
* http://localhost:8080/WebAPI/source/sources
* http://localhost:8080/WebAPI/vocabulary/search/cardiomyopathy

[README ≫](WebAPI)


## Atlas

[ATLAS](https://github.com/OHDSI/Atlas) is an open source software tool for
researchers to conduct scientific analyses on standardized observational data.

### Quickstart

Use the following command to spin up Atlas. Make sure to change the values
of the environment variables as needed. Atlas depends on the OHDSI WebAPI,
so you will need to have that up and running.

```
docker run \
  --name ohdsi-atlas \
  -p 8081:80 \
  -e "WEBAPIURL=http://localhost:8080/WebAPI/" \
  -e "ORGNAME=Momcorp" \
  uwcarg/ohdsi-atlas:2.3.0
```

### Test

Navigate to the following URL:
* http://localhost:8081/

[README ≫](Atlas)

## Achilles

Automated Characterization of Health Information at Large-scale Longitudinal
Evidence Systems ([ACHILLES](https://github.com/OHDSI/Achilles)) - descriptive
statistics about a OMOP CDM database.

## Quickstart

Use the following command to spin up Achilles. Make sure to change the values
of the environment variables as needed. In the example below the database
username and password are represented by `postgres:s3cret`. Data will be read
from `ACHILLES_CDM_SCHEMA` and `ACHILLES_VOCAB_SCHEMA`, and the results will
be written to `ACHILLES_RES_SCHEMA`.

```
docker run \
  --rm \
  --net=host \
  -v "$(pwd)"/output:/opt/app/output \
  -e "ACHILLES_SOURCE=Docker Default" \
  -e "ACHILLES_DB_URI=postgresql://postgres:s3cret@localhost:5432/cdm" \
  -e "ACHILLES_CDM_SCHEMA=public" \
  -e "ACHILLES_VOCAB_SCHEMA=public" \
  -e "ACHILLES_RES_SCHEMA=webapi" \
  -e "ACHILLES_CDM_VERSION=5" \
  uwcarg/ohdsi-achilles:1.5.0
```

[README ≫](Achilles)

## License

[![CC BY-SA](https://licensebuttons.net/l/by-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0/)
