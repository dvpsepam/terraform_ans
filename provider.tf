#terraform {
#    required_providers {
#        aws = {
#            source = "hashicorp/aws"
#    
#        }
#    }
#}

terraform {
  cloud {
    organization = "dag_org"

    workspaces {
      name = "terraform-ansible"
    }
  }
}

provider "aws" {
    region = "eu-central-1"
}
