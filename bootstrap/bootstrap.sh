#! /usr/bin/env sh

# Deploy cert-manager
kubectl create namespace cert-manager
helm template \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.17.0 \
  --set crds.enabled=true \
    | kubectl apply -f -

# Deploy Github Actions Runner Controller
cd gha-runner-scale-set-controller
# helm dependency update
helm template arc -f values.yaml --include-crds . \
    | kubectl create -f -
cd ../

# Deploy AWX Operator
cd awx-operator
helm template awx-operator --namespace awx -f values.yaml --include-crds . \
    | kubectl apply -n awx -f -
cd ../

# This script is used to bootstrap the environment for the project.
cd bootstrap
helm template -f values.yaml --set github_token=$GITHUB_TOKEN . \
    | kubectl apply -f -

cd ../

# Deploy Github Actions Runner scale set
cd gha-runner-scale-set
# helm dependency update
helm template arc-runner-set -f values.yaml . \
    | kubectl apply -f -
cd ../
