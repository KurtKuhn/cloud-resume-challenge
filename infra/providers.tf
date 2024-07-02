terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.56.0"
      # version = "~> 4.40.0"
    }
  }
}

# When using required_providers and AWS, the region must be set
provider "aws" {
  region = var.region
  alias="virginia"
}
