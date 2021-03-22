#!/bin/bash

## Install firewall system

IP=$(hostname -I | awk '{print $2}')

echo "START - Firewall configuration - "$IP

