#!/bin/bash
# Run the builder container

# Environment arguments:
# QGIS_SOURCES - location of QGIS source tree, default to current directory
# QGIS_BUILD - location of the QGIS build directory, default to ./build


QGIS_SOURCES=${QGIS_SOURCES:-$(pwd)}
QGIS_BUILD=${QGIS_BUILD:-$(pwd)/build}
COMMAND="$@"

if [ "${COMMAND}" == "" ]; then
  COMMAND="/run.sh"
fi

DOCKER_ENV=""
for VAR in  QUERY_STRING QGIS_SERVER_LOG_LEVEL QGIS_SERVER_LOG_FILE QGIS_SERVER_LOG_STDERR QGIS_PROJECT_FILE \
            MAX_CACHE_LAYERS QGIS_SERVER_IGNORE_BAD_LAYERS QGIS_SERVER_CACHE_DIRECTORY \
            QGIS_SERVER_CACHE_SIZE QGIS_SERVER_SHOW_GROUP_SEPARATOR QGIS_SERVER_OVERRIDE_SYSTEM_LOCALE \
            QGIS_SERVER_WMS_MAX_HEIGHT QGIS_SERVER_WMS_MAX_WIDTH QGIS_SERVER_API_RESOURCES_DIRECTORY \
            QGIS_SERVER_API_WFS3_MAX_LIMIT QGIS_SERVER_TRUST_LAYER_METADATA QGIS_SERVER_DISABLE_GETPRINT \
            QGIS_SERVER_LANDING_PAGE_PROJECTS_DIRECTORIES QGIS_SERVER_LANDING_PAGE_PROJECTS_PG_CONNECTIONS
do
    VAL=${!VAR}
    if [ "${VAL}" != "" ]; then
        DOCKER_ENV+="-e ${VAR}=${VAL}"
    fi
done


docker run -it --rm --name qgis-server-builder \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    -p 8000:8000 \
    -v `pwd`:/current_directory \
    ${DOCKER_ENV} \
    -v ${QGIS_SOURCES}:/qgis_sources \
    -v ${QGIS_BUILD}:/qgis_build \
    qgis-server-builder:latest \
    ${COMMAND}

