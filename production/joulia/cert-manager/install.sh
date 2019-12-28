#!/bin/bash
pushd "$(dirname "$0")/../../../"
helm install --name cert-manager --namespace cert-manager jetstack/cert-manager \
    -f production/joulia/cert-manager/cert-manager.values.yaml
popd
