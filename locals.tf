locals {
  naming = "${var.environment}-${var.appName}-${var.region}"

  tags = {
    owner          = "Alloy"
    Environment    = var.environment
    ProvisionedBy  = "terraform"
  }
}
