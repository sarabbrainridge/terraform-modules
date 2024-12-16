terraform {
    required_providers {
        aws = {
            Source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region var.region
}
