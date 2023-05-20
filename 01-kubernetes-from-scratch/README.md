# 01 - Kubernetes from Scratch

In this tutorial we will demystify the process of bootstrapping a Kubernetes cluster by understanding the bare-minimum components that are required to get two Kubernetes nodes running inside KVM.

## Articles

- **dev.to** [*Kubernetes from Scratch: Bootstrapping a Cluster*](https://dev.to/mbrav/kubernetes-from-scratch-bootstrapping-a-cluster-1bd5) - 🌐 English
- **dev.to** [*Поднимаем Kubernetes с нуля*](https://habr.com/ru/articles/734928/) - 🌐 Russian

## Terraform Diagram

This is a rough diagram describing the components

```mermaid
flowchart

    kubectl{{kubectl}}

    kubectl <-.-> cri_o_m1_3

    subgraph KVM Provider
        direction LR
        subgraph k8s[kubernetes Cluster]

            subgraph vm_m1[VM master1]
                direction LR
                vm_m1_1{{kubelet}}
                subgraph cri_o_m1[cri-o container runtime]
                    cri_o_m1_1{{kube-controller}}
                    cri_o_m1_2{{kube-scheduler}}
                    cri_o_m1_3{{kube-apiserver}}
                    cri_o_m1_4{{coredns}}
                    cri_o_m1_5{{kube-proxy}}
                    cri_o_m1_6[(etcd)]
                end

                vm_m1_1 <-.-> cri_o_m1_1

                cri_o_m1_1 <-.-> cri_o_m1_2
                cri_o_m1_1 <-.-> cri_o_m1_3
                cri_o_m1_1 <-.-> cri_o_m1_5
                cri_o_m1_1 <-.-> cri_o_m1_6
                cri_o_m1_5 <-.-> cri_o_m1_4
            end

            subgraph vm_w1[VM worker1]
                direction LR
                vm_w1_1{{kubelet}}
                subgraph cri_o_w1[cri-o container runtime]
                    cri_o_w1_1{{kube-proxy}}
                end

                vm_w1_1 <-.-> cri_o_w1_1
            end
            cri_o_w1_1 <-.-> cri_o_m1_5

        end
    end

```

## Screenshot

![](screenshot.webp)

## Installation

1. Init Terraform
   ```bash
   terraform init
   ```

2. Apply Terraform
   ```bash
   terraform apply
   ```
