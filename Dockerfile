FROM  qgis/qgis3-build-deps:latest

# Docker container with QGIS Server for performance test builds in release mode
# Assumes sources are in current working directory
# Build will be generated in ./build

MAINTAINER Alessandro Pasotti <elpaso@itopen.it>

LABEL Description="Docker container with QGIS Server for performance test builds" Vendor="ItOpen" Version="1.0"

COPY assets/*.sh /

RUN apt install bc