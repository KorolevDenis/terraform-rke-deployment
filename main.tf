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
    address = "192.168.116.203"
    user    = "ubuntu"
    role    = ["controlplane", "worker", "etcd"]
    ssh_key = file("~/.ssh/k8s-dev.key")
  }
  
  nodes {
    address = "192.168.116.226"
    user    = "ubuntu"
    role    = ["controlplane", "worker", "etcd"]
    ssh_key = file("~/.ssh/k8s-dev.key")
  }
  
  nodes {
    address = "192.168.116.242"
    user    = "ubuntu"
    role    = ["controlplane", "worker", "etcd"]
    ssh_key = file("~/.ssh/k8s-dev.key")
  }
  
  nodes {
    address = "192.168.116.212"
    user    = "ubuntu"
    role    = ["controlplane", "worker", "etcd"]
    ssh_key = file("~/.ssh/k8s-dev.key")
  }
  
  addons_include = [
      "https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/rook-operator.yaml",
      "https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/rook-cluster.yaml",
      "/path/to/manifest",
    ]
}

resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = rke_cluster.cluster.kube_config_yaml
}
