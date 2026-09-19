#!/bin/bash
set -e

cd /opt/minecraft/dev/server

exec /usr/bin/java -Xms2G -Xmx4G \
  -jar /opt/minecraft/dev/server/fabric-server-mc.1.21.1-loader.0.18.4-launcher.1.1.2.jar \
  nogui
