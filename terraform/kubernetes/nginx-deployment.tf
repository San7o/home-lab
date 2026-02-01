provider "kubernetes" {
  host                   = kind_cluster.default.endpoint
  client_certificate     = kind_cluster.default.client_certificate
  client_key             = kind_cluster.default.client_key
  cluster_ca_certificate = kind_cluster.default.cluster_ca_certificate
}

resource "kubernetes_deployment_v1" "nginx" {
  metadata {
    name      = "nginx-demo"
    namespace = kubernetes_namespace_v1.lab_namespace.metadata[0].name
    labels = {
      app = "web-server"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "web-server"
      }
    }
    template {
      metadata {
        labels = {
          app = "web-server"
        }
      }

      spec {
        container {
          image = "nginx:1.25"
          name  = "nginx-contianer"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
