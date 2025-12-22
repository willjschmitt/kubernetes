terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.37.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0.2"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = ">= 0.21.1"
    }
    sops = {
      source = "carlpett/sops"
      version = ">= 1.2.0"
    }
    utils = {
      source  = "cloudposse/utils"
      version = ">= 1.31.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "schmitt-piforge-home"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
    config_context = "schmitt-piforge-home"
  }
}

provider "utils" {}

provider "tailscale" {}
