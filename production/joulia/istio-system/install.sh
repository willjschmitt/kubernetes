#!/bin/bash
pushd "$(dirname "$0")"
export ISTIO_VERSION="1.4.2"
curl -L https://istio.io/downloadIstio | sh -
./istio-1.4.2/bin/istioctl manifest apply -f istio.yaml
popd
