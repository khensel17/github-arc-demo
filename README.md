# github-arc-demo
Demo of Github ARC

## Setup environment

Create KIND cluster:

```bash
kind create cluster
```

Reset KIND cluster and open K9S:

```bash
make reset-kind-cluster
```

Get AWX admin password:

```bash
kubectl get secret/awx-demo-admin-password -n awx -o json | jq '.data | map_values(@base64d)'
```

## Deploy

```bash
export GITHUB_TOKEN="<GITHUB PAT>"
source ./bootstrap/bootstrap.sh
```
