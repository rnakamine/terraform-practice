resource "aws_instance" "sandbox" {
  ami           = "ami-785c491f"
  instance_type = "t2.micro"
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnet_id
}

provider "aws" {
  profile = "rnakamine"
  region  = "ap-northeast-1"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "terraform-sample-rnakamine"
    key     = "terraform-practice/vpc/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "rnakamine"
  }
}

terraform {
  backend "s3" {
    bucket  = "terraform-sample-rnakamine"
    key     = "terraform-practice/ec2/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "rnakamine"
  }
}
