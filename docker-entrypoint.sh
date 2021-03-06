#!/bin/bash -ex

echo "Running in $PWD"
ls -alh

if ! id -u vagrant; then
  echo "Setting up user and groups..."
  groupadd -g $GROUPID vagrant
  groupadd -g $DOCKERGROUPID docker
  useradd -u $USERID -g vagrant -G kvm,docker,sudo,disk --create-home vagrant
else
  echo "User already exists, skipping."
fi

echo "Changing permissions..."
if [ -c /dev/kvm ]; then
  chown vagrant:kvm /dev/kvm || true
  chmod ug+rwx /dev/kvm || true
fi
chown -R $USERID:$GROUPID ./etc
chown -R $USERID:$GROUPID ./var

python3 cluster.py configure-network

exec sudo -nHu vagrant DOCKER_BIN=$DOCKER_BIN python3 ./cluster.py supervisord
