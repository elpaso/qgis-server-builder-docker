# QGIS Server builder image

A simple Docker to build QGIS Server for performances tests.

The build directory inside the container is `/qgis_build`.


Server is built in "release" mode and it is not installed, it runs from the build directory,
the full path as seen by the container will be `/qgis_build/output/bin/qgis_mapserv.fcgi`.


## Building the Docker image

See `build.sh` in the current folder.

## Running

See `run.sh` in the current folder.

### Building QGIS

Set the following environment variables:

`QGIS_SOURCES` host directory that contains the QGIS sources tree.
`QGIS_BUILD` host directory where the build will be stored.

The `/build.sh` script stored inside the container will start the QGIS build.

You can execute the command with `./run.sh /build.sh`

### Running QGIS Server

The `/env.sh` script stored inside the container will set the environment and run QGIS Server or any other command from the output directory of the container taking care of setting the environment to run the built QGIS Server.

You can execute the command with `./run.sh /env.sh <your command>` (default command is `qgis_mapserver`).

For example, to run `qgis_mapserv.fcgi` you can use`./run.sh /env.sh /qgis_build/output/bin/qgis_mapserv.fcgi`

A slightly more complicated example:
`QGIS_SOURCES=/home/xxxxx/dev/QGIS QUERY_STRING='SERVICE=WMS&REQUEST=GetCapabilities&MAP=/current_directory/empty_project.qgs' ./run.sh /env.sh /qgis_build/output/bin/qgis_mapserv.fcgi`

### Measuring response times

A small utility script `/server_time.sh` that re-runs `qgis_mapserv.fcgi` 5 times is provided, example:

`QGIS_SOURCES=/home/ale/dev/QGIS QUERY_STRING='SERVICE=WMS&REQUEST=GetCapabilities&MAP=/current_directory/empty_project.qgs' ./run.sh /server_time.sh`








