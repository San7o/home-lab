terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.10.0"
    }
  }
}

provider "kind" {}

resource "kind_cluster" "default" {
  name       = "home-lab-cluster"
  node_image = "kindest/node:v1.33.4" # K8s version

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    # Control Plane Node
    node {
      role = "control-plane"
    }

    # Worker Node 1
    node {
      role = "worker"
    }

    # Worker Node 2
    node {
      role = "worker"
    }
  }
}

# Output the kubeconfig so other files can use it
output "kubeconfig" {
  value     = kind_cluster.default.kubeconfig
  sensitive = true
}
