# Auto generated ansible inventory file from Terraform template
# Generated: ${ timestamp }

# Kubespray formatted inventory

all:
  vars:
    ansible_user: "${ vm_user }"
    ansible_password: "${ vm_user_password }"
  hosts:
%{ for h, host in vm_masters ~}
    ${ host }:
      ansible_host: "${ ip_masters[h] }"
      ip: "${ ip_masters[h] }"
      access_ip: "${ ip_masters[h] }"
%{ endfor ~}
%{ for h, host in vm_workers ~}
    ${ host }:
      ansible_host: "${ ip_workers[h] }"
      ip: "${ ip_workers[h] }"
      access_ip: "${ ip_workers[h] }"
%{ endfor ~}
  children:
    kube_control_plane:
      hosts:
%{ for h, host in vm_masters ~}
        ${ host }:
%{ endfor ~}
    kube_node:
      hosts:
%{ for h, host in vm_masters ~}
        ${ host }:
%{ endfor ~}
%{ for h, host in vm_workers ~}
        ${ host }:
%{ endfor ~}
    etcd:
      hosts:
%{ for h, host in vm_masters ~}
        ${ host }:
%{ endfor ~}
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
