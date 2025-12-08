variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


variable "environment" {
  description = "environment? prod or dev?"
  type        = string
  default     = "prod"
}

variable "vpc_name" {
  description = "Name prefix for the VPC"
  type        = string
  default     = "Alloy-case"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of availability zones to use"
  type        = list(string)
  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_subnets" {
  description = "List of private subnet CIDR block"
  type        = list(string)
  default = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

variable "database_subnets" {
  description = "List of database subnet CIDR blocks"
  type        = list(string)
  default = [
    "10.0.21.0/24",
    "10.0.22.0/24"
  ]
}


variable "appName" {
  description = "Application name used for naming and tagging resources"
  type        = string
}
