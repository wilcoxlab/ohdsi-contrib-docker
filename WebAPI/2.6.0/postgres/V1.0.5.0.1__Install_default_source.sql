/* Install default source */

INSERT INTO ${DBWEBAPISCHEMA}.source (source_id, source_name, source_key, source_connection, source_dialect) VALUES (1, 'Docker Default', 'docker_default', 'jdbc:postgresql://${DBHOST}:${DBPORT}/${DBNAME}?currentSchema=${DBCDMSCHEMA}&user=${DBUSER}&password=${DBPASS}', 'postgresql');
INSERT INTO ${DBWEBAPISCHEMA}.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (1,1,0, '${DBCDMSCHEMA}', 0);
INSERT INTO ${DBWEBAPISCHEMA}.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (2,1,1, '${DBVOCABSCHEMA}', 0);
INSERT INTO ${DBWEBAPISCHEMA}.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (3,1,2, '${DBWEBAPISCHEMA}', 0);
