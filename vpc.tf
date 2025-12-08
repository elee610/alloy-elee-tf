module "vpc" {
  source  = "./Modules/rds/terraform-aws-vpc"
  name = "${local.naming}-vpc"
  cidr = var.vpc_cidr
  azs = var.azs
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets
  create_database_subnet_group = true
  create_igw = true
  enable_nat_gateway  = true
  single_nat_gateway  = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_flow_log = true 
  tags                 = local.tags
}