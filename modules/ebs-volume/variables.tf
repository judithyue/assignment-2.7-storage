variable "availability_zone" {
  description = "Availability zone for the EBS volume"
  type        = string
}

variable "size" {
  description = "Size of the EBS volume in GB"
  type        = number
  default     = 1

  validation {
    condition     = var.size >= 1 && var.size <= 1024
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

variable "encrypted" {
  description = "Whether the EBS volume should be encrypted"
  type        = bool
  default     = false
}

variable "device_name" {
  description = "Device name to attach the volume as"
  type        = string
  default     = "/dev/sdh"
}

variable "instance_id" {
  description = "ID of the EC2 instance to attach the volume to"
  type        = string
}

variable "name" {
  description = "Name tag for the EBS volume"
  type        = string
  default     = "ebs-volume"
}

variable "tags" {
  description = "Additional tags for the EBS volume"
  type        = map(string)
  default     = {}
}