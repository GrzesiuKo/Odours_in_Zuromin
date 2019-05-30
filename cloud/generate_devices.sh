#!/bin/sh


max=3
for i in `seq 1 $max`
do
    echo "$i"
gcloud iot devices create go-vniac$i \
  --region=us-central1 \
  --registry=gateway-registry \
  --device-type=non-gateway \
  --project=${GOOGLE_CLOUD_PROJECT}


gcloud iot devices gateways bind \
  --device=go-vniac$i \
  --device-region=us-central1 \
  --device-registry=gateway-registry\
  --gateway=test-gateway \
  --gateway-region=us-central1 \
  --gateway-registry=gateway-registry \
  --project=${GOOGLE_CLOUD_PROJECT}
done

