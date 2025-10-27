terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_manifest" "all" {
  for_each = fileset("${path.module}/yamls", "*.yaml")
  manifest = yamldecode(file("${path.module}/yamls/${each.value}"))
}