terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "2.2.1"
    }
    helm = {
      version = "~> 2.11.0"
    }
  }
  required_version = ">= 0.13"
}
