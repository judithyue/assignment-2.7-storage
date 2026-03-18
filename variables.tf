variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-southeast-1"
}

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

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "ju-vpc"
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

variable "availability_zone" {
  description = "Availability zone for the EC2 instance and EBS volume"
  type        = string
  default     = "ap-southeast-1a"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance. If not provided, will use the latest Amazon Linux 2 AMI"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"

  validation {
    condition     = contains(["t2.micro", "t2.small", "t2.medium", "t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "Instance type must be one of the allowed free tier or small instance types."
  }
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "ju-ec2"
}


variable "ebs_name" {
  description = "Name tag for the EBS volume"
  type        = string
  default     = "ju-ebs-vol"
}

variable "volume_size" {
  description = "Size of the EBS volume in GB"
  type        = number
  default     = 1

  validation {
    condition     = var.volume_size >= 1 && var.volume_size <= 1024
    error_message = "Volume size must be between 1 and 1024 GB."
  }
}

variable "volume_type" {
  description = "Type of EBS volume"
  type        = string
  default     = "gp2"

  validation {
    condition     = contains(["gp2", "gp3", "io1", "io2", "st1", "sc1"], var.volume_type)
    error_message = "Volume type must be one of: gp2, gp3, io1, io2, st1, sc1."
  }
}

variable "volume_encrypted" {
  description = "Whether the EBS volume should be encrypted"
  type        = bool
  default     = false
}

variable "device_name" {
  description = "Device name to attach the volume as"
  type        = string
  default     = "/dev/sdh"
}

variable "volume_name" {
  description = "Name tag for the EBS volume"
  type        = string
  default     = "ju-ebs-vol"
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "assignment-2.7-storage"
    ManagedBy   = "terraform"
  }
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
  type        = string
  default     = "terraform-state-assignment-2-7-storage"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", var.state_bucket_name)) && length(var.state_bucket_name) >= 3 && length(var.state_bucket_name) <= 63
    error_message = "Bucket name must be between 3 and 63 characters, start and end with a letter or number, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
  default     = "terraform-locks-assignment-2-7-storage"

  validation {
    condition     = can(regex("^[a-zA-Z0-9._-]+$", var.dynamodb_table_name)) && length(var.dynamodb_table_name) >= 3 && length(var.dynamodb_table_name) <= 255
    error_message = "DynamoDB table name must be between 3 and 255 characters and contain only letters, numbers, underscores, hyphens, and periods."
  }
}