#!/usr/bin/env bash

{
if [ ! -e /etc/mongo-standalone.conf ] ; then
  sudo cp -av /etc/mongo-cluster.conf /etc/mongo-standalone.conf
  sudo sed -i -e 's/^ *\(replication\|oplogSizeMB\|replSetName\)/#&/' /etc/mongo-standalone.conf
  diff /etc/mongo-{cluster,standalone}.conf
fi
cd /lib/systemd/system
if [ "$PWD" = /lib/systemd/system ] && [ ! -e mongo-standalone.service ] ; then
sudo cp -av mongo-cluster.service mongo-standalone.service
sudo sed -i -e 's/cluster/standalone/g' mongo-standalone.service
diff /lib/systemd/system/mongo-{cluster,standalone}.service
fi
}
