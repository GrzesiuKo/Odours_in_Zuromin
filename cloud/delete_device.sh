#!/bin/sh
GOOGLE_CLOUD_PROJECT=unistartappnosacze
NAME=$1

./unbind_device.sh $NAME

echo "Deleting device $NAME"

gcloud iot devices delete $NAME \
  --region=us-central1 \
  --registry=gateway-registry \
  --project=${GOOGLE_CLOUD_PROJECT}\
  --quiet

echo "DELETED device $NAME"
