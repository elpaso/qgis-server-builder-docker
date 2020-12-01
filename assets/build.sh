#!/bin/bash
# Script that can be run inside the docker to build QGIS Server
# Builds QGIS Server in the "/qgis_build" directory
# Source tree is assumed to be in "/qgis_sources" folder


cd /qgis_build && \
  cmake \
  -GNinja \
  -DUSE_CCACHE=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DWITH_DESKTOP=OFF \
  -DWITH_ANALYSIS=ON \
  -DWITH_SERVER=ON \
  -DWITH_3D=OFF \
  -DWITH_BINDINGS=ON \
  -DWITH_CUSTOM_WIDGETS=OFF \
  -DBINDINGS_GLOBAL_INSTALL=ON \
  -DWITH_STAGED_PLUGINS=ON \
  -DWITH_GRASS=OFF \
  -DSUPPRESS_QT_WARNINGS=ON \
  -DDISABLE_DEPRECATED=ON \
  -DENABLE_TESTS=OFF \
  -DWITH_QSPATIALITE=ON \
  -DWITH_APIDOC=OFF \
  -DWITH_ASTYLE=OFF \
  -DCMAKE_PREFIX_PATH=/qgis_sources \
  /qgis_sources

ninja
