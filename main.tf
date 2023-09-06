terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.15.0"
    }
  }
}

provider "vault" {
   address = "http://127.0.0.1:8200" 
}

data "vault_generic_secret" "myapp_aws" {
    path = "kv/aws"
}

provider "aws" {
  region = "eu-central-1"
  access_key = data.vault_generic_secret.myapp_aws.data["access_key_id"]
  secret_key = data.vault_generic_secret.myapp_aws.data["secret_access_key"]
}

locals {
  bucket_name = "mayday-website"
  s3_origin_id = "s3-origin"
}
