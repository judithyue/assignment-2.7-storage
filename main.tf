terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr                = var.vpc_cidr
  public_subnet_cidr      = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  vpc_name                = var.vpc_name
  allowed_ssh_cidr_blocks = var.allowed_ssh_cidr_blocks
  tags                    = var.tags
}

module "ec2_instance" {
  source = "./modules/ec2-instance"

  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  subnet_id              = module.vpc.public_subnet_id
  vpc_security_group_ids = [module.vpc.security_group_id]
  name                   = var.instance_name
  tags                   = var.tags
}

module "ebs_volume" {
  source = "./modules/ebs-volume"

  availability_zone = module.ec2_instance.availability_zone
  size              = var.volume_size
  volume_type       = var.volume_type
  instance_id       = module.ec2_instance.instance_id
  name              = var.ebs_name
  tags              = {}
}