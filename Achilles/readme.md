<br/><br/><br/>
![UW](https://user-images.githubusercontent.com/668093/37624743-79bae716-2b86-11e8-879d-70a61cc623c6.png)
<br/><br/><br/>

# Achilles Dockerfiles

Automated Characterization of Health Information at Large-scale Longitudinal
Evidence Systems ([ACHILLES](https://github.com/OHDSI/Achilles)) - descriptive
statistics about a OMOP CDM database.

## Quickstart

Use the following command to spin up Atlas. Make sure to change the values
of the environment variables as needed. In the example below the database
username and password are represented by `postgres:s3cret`.

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

### Test

The first test is to make sure you see no errors in the output and that the `output`
volume specified in the `docker run` command contains the JSON output files.

To see the Achilles results in Atlas, you will have to configure an appropriate
data source. This can be a tricky, since data sources are not very well
documented. Start by reading
[this](http://www.ohdsi.org/web/wiki/doku.php?id=documentation:software:webapi:source_configuration).
There are two components to a data source, the <kbd>source</kbd> and the
<kbd>source_daimon</kbd>. These are both tables in the schema used for the
WebAPI. Each <kbd>source</kbd> has a name, key, and connection string, as well
as three<sup>†</sup> corresponding entries in the <kbd>source_daimon</kbd> table. Each entry
in the <kbd>source_daimon</kbd> table references a single source, and has a
[type](https://github.com/OHDSI/WebAPI/blob/master/src/main/java/org/ohdsi/webapi/source/SourceDaimon.java#L37)
(numeric value `0`, `1` or `2`) and a table qualifier (corresponding to the
schema name in postgres).

The important types are

* `0` (CDM) - The table qualifier (schema) should be the one containing the CDM data.
* `1` (Vocabulary) - The table qualifier (schema) should be the one containing the CDM vocabulary metadata.
* `2` (Results) - The table qualifier (schema) should be the one containing the results (e.g. Achilles results).

I believe the idea behind this schema mechanism is to allow multiple CDM
databases to be accessible through Atlas. Further, it allows for some schemas to
be read only (e.g. CDM data), while some are writable (e.g. Results).

The following SQL could be used to create a <kbd>source</kbd> with some <kbd>source_daimon</kbd>
entries that refer to data and vocabulary metadata in the `cdm` schema, while
referring to results in the `webapi` schema. This corresponds to the Docker
run command above.

```sql
INSERT INTO webapi.source (source_id, source_name, source_key, source_connection, source_dialect) VALUES (2, 'WebAPI source', 'webapi_source', 'jdbc:postgresql://${DBHOST}:${DBPORT}/${DBNAME}?&user=${DBUSER}&password=${DBPASS}', 'postgresql');
INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (1,2,0, 'public', 0); -- public is the postgres schema containing the cdm data
INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (2,2,1, 'public', 0); -- public is the postgres schema containing the vocab metadata
INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (3,2,2, 'webapi', 0); -- webapi is the postgres schema containing the Achilles results
```

To use the above you'll need to replace `DBHOST`, `DBPORT`, `DBNAME`, `DBUSER`
and `DBPASS`.

<sup>†</sup>Actually two <kbd>source_daimon</kbd>'s of the same type can refer
to the same <kbd>source</kbd>.

## Details

The Docker image is built on [Docker
Hub](https://hub.docker.com/r/uwcarg/ohdsi-achilles/) and contains a build of
[OHDSI Achilles](https://github.com/OHDSI/Achilles).

## Atlas Configuration

### Environment Variables

For details see the [Achilles
README](https://github.com/OHDSI/Achilles/blob/master/README.md). A summary of
the environment variables is included below for convenience.

> **ACHILLES_SOURCE**

The name of the data source containing the CDM data. See
[here](http://www.ohdsi.org/web/wiki/doku.php?id=documentation:software:webapi:source_configuration)
for some information on data sources.

> **ACHILLES_DB_URI**

The database connection string, including the `username:password` phrase. In the
example above, replace `postgres` with your database username and `s3cr3t` with
the password.

> **ACHILLES_CDM_SCHEMA**

The name of the database schema containing the CDM data.

> **ACHILLES_VOCAB_SCHEMA**

The name of the database schema containing the CDM vocabulary metadata.

> **ACHILLES_RES_SCHEMA**

the name of the schema in which you want the results to be written.

> **ACHILLES_CDM_VERSION**

The CDM version. This can either be `4` or `5`.

## Troubleshooting

Generating the analysis results can use a lot of disk space (e.g.
[#22](https://github.com/OHDSI/Achilles/issues/255)), so you need to make sure
enough disk space is available to Docker. On macOS, this is done by opening
_Preferences..._ from the Docker icon in the title bar and selecting the _Disk_
option. Set the virtual disk image size to 64GB or 128GB depending on how much
space you're using for other images and volumes.

## License

[![CC BY-SA](https://licensebuttons.net/l/by-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0/)
