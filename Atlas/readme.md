![OHDSI](https://www.ohdsi.org/wp-content/uploads/2015/02/h243-ohdsi-logo-with-text.png)

# Atlas Dockerfiles

[ATLAS](https://github.com/OHDSI/Atlas) is an open source software tool for
researchers to conduct scientific analyses on standardized observational data.

## Quickstart

Use the following command to spin up Atlas. Make sure to change the values
of the environment variables as needed.

```
docker run \
  --name ohdsi-atlas \
  -p 8081:80 \
  -e "WEBAPIURL=http://localhost:8080/WebAPI/" \
  -e "ORGNAME=Momcorp" \
  uwcarg/ohdsi-atlas:2.3.0
```

:bulb: Atlas depends on the OHDSI WebAPI, so you will need to have that up and
running.

### Test

Navigate to the following URL:
* http://localhost:8081/

## Details

The Docker image is built on [Docker
Hub](https://hub.docker.com/r/uwcarg/ohdsi-atlas/) and contains a build of
[OHDSI Atlas](https://github.com/OHDSI/Atlas).

### Environment Variables

When creating the container, a new `config-local.js` is created as described in
the [install guide](http://www.ohdsi.org/web/wiki/doku.php?id=documentation:software:atlas:setup),
using the values specified in the environment variables.

> **WEBAPIURL** [default: https://localhost:8080/WebAPI/]

The URL of the WebAPI instance to connect to.

> **ORGNAME** [default: Atlas]

Your organization's display name.

## License

[![CC BY-SA](https://licensebuttons.net/l/by-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0/)
