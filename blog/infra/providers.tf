terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}

# When using required_providers and AWS, the region must be set
provider "aws" {
  region = var.region
}
