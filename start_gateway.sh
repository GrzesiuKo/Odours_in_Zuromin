#!/bin/bash


sudo apt install python3-venv -y
sudo python3 \-m venv env

#source env/bin/activate
sudo pip install \-r requirements.txt

sudo rm roots.*
wget https://pki.goog/roots.pem

python ./gateway.py \--registry_id=gateway-registry \--gateway_id=test-gateway \--cloud_region=us-central1 \--private_key_file=$HOME/rsa_private.pem \--algorithm=RS256 \--ca_certs=roots.pem \--mqtt_bridge_hostname=mqtt.googleapis.com \--mqtt_bridge_port=8883 \--jwt_expires_minutes=1200


