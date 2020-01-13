#!/bin/bash
pushd "$(dirname "$0")"
helm repo add stable http://storage.googleapis.com/kubernetes-charts
helm repo update
helm install --namespace openvpn --name openvpn-gateway stable/openvpn \
    -f openvpn-gateway.values.yaml
popd
