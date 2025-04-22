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

TEST THIS SETUP: https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/quickstart-for-actions-runner-controller

```bash
helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller
helm repo update

NAMESPACE="arc-systems"
helm install arc \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller


INSTALLATION_NAME="arc-runner-set"
NAMESPACE="arc-runners"
GITHUB_CONFIG_URL="https://github.com/<your_enterprise/org/repo>"
GITHUB_PAT="<PAT>"
helm install "${INSTALLATION_NAME}" \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    --set githubConfigUrl="${GITHUB_CONFIG_URL}" \
    --set githubConfigSecret.github_token="${GITHUB_PAT}" \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set

# helm upgrade --install --namespace actions-runner-system --create-namespace \
#   --set=authSecret.create=true \
#   --set=authSecret.github_token="GITHUB PAT" \
#   --wait actions-runner-controller actions-runner-controller/actions-runner-controller
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
# kubectl apply -f runner-deployment.yaml -n actions-runner-system
```
