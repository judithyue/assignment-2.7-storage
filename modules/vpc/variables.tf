variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0)) && split("/", var.vpc_cidr)[1] <= 16
    error_message = "VPC CIDR must be a valid CIDR block with prefix length <= 16."
  }
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"

  validation {
    condition     = can(cidrhost(var.public_subnet_cidr, 0))
    error_message = "Public subnet CIDR must be a valid CIDR block."
  }
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "terraform-vpc"
}

variable "allowed_ssh_cidr_blocks" {
  description = "CIDR blocks allowed to SSH into EC2 instances"
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition = alltrue([
      for cidr in var.allowed_ssh_cidr_blocks : can(cidrhost(cidr, 0))
    ])
    error_message = "All SSH CIDR blocks must be valid CIDR notation."
  }
}

variable "tags" {
  description = "Additional tags for VPC resources"
  type        = map(string)
  default     = {}
}