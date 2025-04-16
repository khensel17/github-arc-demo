# github-arc-demo
Demo of Github ARC

## Setup environment

Create KIND cluster:

```bash
kind create cluster
```

Open ``awx-operator`` repository and deploy it by running:

```bash
kubectl apply -k .
```

Install ``cert-manager`` helm chart:

```bash
helm install cert-manager --namespace cert-manager --version v1.17.1 jetstack/cert-manager --create-namespace --set installCRDs=true
```

Install Github ARC:

```bash
helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller
helm repo update

helm upgrade --install --namespace actions-runner-system --create-namespace \
  --set=authSecret.create=true \
  --set=authSecret.github_token="GITHUB PAT" \
  --wait actions-runner-controller actions-runner-controller/actions-runner-controller
```

Deploy AWX instance:

```bash
kubectl apply -f awx-demo.yml -n awx
```

Get AWX admin password:

```bash
kubectl get secret/awx-demo-admin-password -n awx -o json | jq '.data | map_values(@base64d)'
```

Deploy ARC runner:

```bash
kubectl apply -f runner-deployment.yaml -n actions-runner-system
```
