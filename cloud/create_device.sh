#!/bin/sh
GOOGLE_CLOUD_PROJECT=unistartappnosacze
NAME=$1
echo "Creating device $NAME"

gcloud iot devices create $NAME \
  --region=us-central1 \
  --registry=gateway-registry \
  --device-type=non-gateway \
  --project=${GOOGLE_CLOUD_PROJECT}

echo "CREATED device $NAME"

echo "Binding device $NAME"

gcloud iot devices gateways bind \
  --device=$NAME \
  --device-region=us-central1 \
  --device-registry=gateway-registry\
  --gateway=test-gateway \
  --gateway-region=us-central1 \
  --gateway-registry=gateway-registry \
  --project=${GOOGLE_CLOUD_PROJECT}

echo "BINDED device $NAME"
