resource "kubernetes_namespace_v1" "lab_namespace" {
  metadata {
    name = "lab"
  }
}
