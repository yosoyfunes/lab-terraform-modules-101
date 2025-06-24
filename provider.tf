# Configuración de Terraform y providers
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configuración del provider AWS
provider "aws" {
  region = var.region

  # Tags por defecto para todos los recursos
  default_tags {
    tags = var.common_tags
  }
}
