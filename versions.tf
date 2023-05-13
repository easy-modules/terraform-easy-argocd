terraform {
  required_version = ">=1.0.0"

  required_providers {
    aws = {
      version = "4.0.0"
      source  = "hashicorp/aws"
    }
    helm = {
      version = "2.9.0"
      source  = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
