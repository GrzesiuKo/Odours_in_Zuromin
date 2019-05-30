#!/bin/sh
GOOGLE_CLOUD_PROJECT=unistartappnosacze
NAME=$1

echo "Unbinding device $NAME"
gcloud iot devices gateways unbind \
  --device=$NAME \
  --device-region=us-central1 \
  --device-registry=gateway-registry\
  --gateway=test-gateway \
  --gateway-region=us-central1 \
  --gateway-registry=gateway-registry \
  --project=${GOOGLE_CLOUD_PROJECT}

echo "UNBINDED device $NAME"
