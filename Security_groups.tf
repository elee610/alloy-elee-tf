module "ec2_sg" {
  source = "./Modules/security-group/terraform-aws-security-group"
  name        = "${local.naming}-ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = module.vpc.vpc_id

  egress_with_source_security_group_id = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "Allow PostgreSQL access from EC2 instances"
      source_security_group_id = module.db_sg.security_group_id
    }
  ]

  tags = local.tags
}

module "db_sg" {
  source = "./Modules/security-group/terraform-aws-security-group"
  name        = "${local.naming}-db-sg"
  description = "Security group for PostgreSQL database"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port               = 5432
      to_port                 = 5432
      protocol                = "tcp"
      description              = "Allow PostgreSQL access from EC2 instances"    
      source_security_group_id = module.ec2_sg.security_group_id
    }
  ]

  tags = local.tags
}