terraform {
  required_providers {
    rke = {
      source  = "rancher/rke"
      version = "1.0.1"
    }
  }
}

provider "rke" {
  debug = true
  log_file = "rke.log"
}

resource "rke_cluster" "cluster" {
  nodes {
    address = ""
    user    = "ubuntu"
    role    = ["controlplane", "worker", "etcd"]
    ssh_key = file("~/.ssh/k8s-dev.key")
  }
  
  addons_include = [
      "go-install.sh",
      "helm-install.sh"
    ]
}

resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = rke_cluster.cluster.kube_config_yaml
}
