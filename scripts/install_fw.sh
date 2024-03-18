#!/bin/bash

## Install firewall system

IP=$(hostname -I | awk '{print $2}')

echo "START - Firewall configuration - "$IP
echo "=> [1]: Installing required packages..."
  DEBIAN_FRONTEND=noninteractive
  apt-get update  -o Dpkg::Progress-Fancy="0" -q -y >> /tmp/install_web.log 2>&1
  apt-get -y -q -o Dpkg::Progress-Fancy="0" install \
    curl \
    iptables \
      >> /tmp/install_web.log 2>&1
