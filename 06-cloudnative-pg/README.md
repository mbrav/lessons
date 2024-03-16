# CloudNativePoG

This is a simple example that installs Cloud Native Postgres operator in a minikube cluster

## Installation

Install `cnpg` plugin for kubectl:

```shell
curl -sSfL \
  https://github.com/cloudnative-pg/cloudnative-pg/raw/main/hack/install-cnpg-plugin.sh | \
  sudo sh -s -- -b /usr/local/bin
```

Install latest operator manifest:

```shell
kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.22/releases/cnpg-1.22.1.yaml
```

Deploy cluster:

```shell
kubectl apply -k .
```

### Optional

A few optional requirements

### Deploy cert-manager

Allows to create automatically managed self-signed certificates for Postgres over TLS

```shell
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.yaml
```

### Deploy kube-prom-stack

For configuring metrics and dashboards


```shell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

Create a separate namespace for monitoring
```shell
kubectl create ns monitoring
```

Install

```shell
helm install prom prometheus-community/kube-prometheus-stack -n monitoring
```

