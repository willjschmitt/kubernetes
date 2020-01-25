#!/bin/bash
pushd "$(dirname "$0")"
kubectl apply -f home-assistant.namespace.yaml
kubectl apply -f home-assistant.yaml
popd
