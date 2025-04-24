rebuild-kind-cluster:
	kind delete cluster --name kind
	kind create cluster --name kind

reset-kind-cluster:
	kind delete cluster --name kind
	kind create cluster --name kind
	k9s
