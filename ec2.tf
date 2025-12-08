module "ec2" {
  for_each               = local.alloy-test-ec2
  source                 = "./Modules/ec2/terraform-aws-ec2-instance"
  name                   = each.value.name
  ami                    = try(each.value.ami, null)
  ami_ssm_parameter      = try(each.value.ami_ssm_parameter, null)
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = each.value.vpc_security_group_ids
  metadata_options = {
    http_tokens = "required"
  }
  user_data               = data.template_file.cis_user_data[each.key].rendered
  key_name                = var.key_pair
  disable_api_termination = true
  monitoring              = true
  root_block_device = [{
    encrypted   = true
    kms_key_id  = aws_kms_key.main.key_id
    volume_size = try(each.value.root_volume_size, null)
  }]
  associate_public_ip_address = false
  tags                        = local.tags
  volume_tags                 = local.tags
}


locals {
  alloy-test-ec2 = {
    for i in range(1) : "alloy-test-ec2-${i + 1}" => {
      name = "${var.environment}-alloy-test-ec2-${i + 1}"
      # ami_ssm_parameter = "/aws/service/ami-windows-latest/Windows_Server-2022-English-Full-Base"
      ami           = var.alloy_standard_linux_ami
      instance_type = "t3a.medium"
      subnet_id     = [var.private_subnets][i % 2]
      vpc_security_group_ids = [
        module.ec2_sg.security_group_id
      ]
      root_volume_size = 100
      computer_name    = "alloy-test-ec2-${i + 1}"
    }
  }
}