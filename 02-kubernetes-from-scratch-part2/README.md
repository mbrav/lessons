# 02 - Kubernetes from Scratch - Part 2

In this tutorial we will demystify the process of bootstrapping a Kubernetes cluster by understanding the bare-minimum components that are required to get two Kubernetes nodes running inside KVM.

## Articles

- ... - 🌐 English
- ... - 🌐 Russian

## Terraform Diagram

...

```mermaid
flowchart

    kubectl{{kubectl}}

    kubectl <--> vm_m1

    subgraph KVM Provider
        subgraph k8s[Kubernetes Cluster]

            subgraph masters[masters]
                vm_m1([VM master1])
                vm_m2([VM master2])
                vm_m3([VM master3])
            end

            subgraph workers[workers]
                vm_w1([VM worker1])
                vm_w2([VM worker2])
                vm_w3([VM worker3])
            end


            style masters fill:#659b68,stroke:#333,stroke-width:2px,stroke-dasharray: 5 5
            style workers fill:#CAA67F,stroke:#333,stroke-width:2px,stroke-dasharray: 5 5
            style k8s fill: #69778c,stroke:#aaa,stroke-width:2px,stroke-dasharray: 5 5

        end
    end

```

<!-- 
## Screenshot

![](screenshot.webp) 
-->

## Installation

1. Init Terraform
   ```bash
   terraform init
   ```

2. Apply Terraform
   ```bash
   terraform apply
   ```

3. Follow the kubernetes bootstrapping procedure described in [my articles](#articles)
