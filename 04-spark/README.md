# Spark Operator

This is a simple example that installs spark operator in a minikube cluster and runs some apps

## Start cluster

Before installing this example, you can start a minikube cluster with 3 nodes:

```shell
nodes=3 ../minikube-cilium.sh

```

## Installation

Add repo:

```shell
helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
```

Show values (optional):

```shell
helm show values spark-operator/spark-operator > values.yaml
```

Install:

```shell
helm install spark spark-operator/spark-operator --namespace spark-operator --create-namespace -f values.yaml
```

Modify your values and upgrade:

```shell
helm upgrade -n spark-operator spark spark-operator/spark-operator -f values.yaml
```

When done, you can uninstall the release:

```shell
helm uninstall -n spark-operator spark
```

## Run apps
