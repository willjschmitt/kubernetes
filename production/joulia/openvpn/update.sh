#!/bin/bash
pushd "$(dirname "$0")"
helm repo add stable http://storage.googleapis.com/kubernetes-charts
helm repo update
helm upgrade openvpn-gateway stable/openvpn \
    -f openvpn-gateway.values.yaml
popd
