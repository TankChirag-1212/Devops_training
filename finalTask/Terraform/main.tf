provider "aws" {
  region = var.region
}

module "ec2_controller" {
  source                    = "./modules/ec2_controller"
  ami                       = var.ami
  instance_type             = var.controller_instance_type
  instance_name             = var.controller_instance_name
  ec2_instance_profile_name = module.IAM.ec2_instance_profile_name
  key_pair_name             = var.key_pair_name
  public_subnet_id          = module.vpc.pub_subnet_id
  security_group_id         = module.security_group.controller_sg_id
}

module "ec2_worker" {
  source                    = "./modules/ec2_worker"
  ami                       = var.ami
  count                     = 2
  instance_type             = var.worker_instance_type
  instance_name             = var.worker_instance_name
  ec2_instance_profile_name = module.IAM.ec2_instance_profile_name
  key_pair_name             = var.key_pair_name
  public_subnet_id          = module.vpc.pub_subnet_id
  security_group_id         = module.security_group.worker_sg_id
}

module "IAM" {
  source = "./modules/IAM"
  s3_arn = module.s3.s3_arn
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_ip        = var.vpc_cidr_ip
  region             = var.region
  pub_subnet_cidr_ip = var.pub_subnet_cidr_ip
}

module "security_group" {
  source    = "./modules/security_groups"
  my_vpc_id = module.vpc.my_vpc_id
}

module "s3" {
  source           = "./modules/s3"
  bucket_name      = var.bucket_name
  ec2_iam_role_arn = module.IAM.iam_role_arn
}
