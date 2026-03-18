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

variable "availability_zone" {
  description = "Availability zone for the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the EC2 instance"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "ec2-instance"
}

variable "tags" {
  description = "Additional tags for the EC2 instance"
  type        = map(string)
  default     = {}
}