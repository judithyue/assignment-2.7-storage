output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "ARN of the created VPC"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = module.vpc.security_group_id
}

output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = module.ec2_instance.instance_id
}

output "instance_arn" {
  description = "ARN of the created EC2 instance"
  value       = module.ec2_instance.instance_arn
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2_instance.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.ec2_instance.private_ip
}

output "volume_id" {
  description = "ID of the created EBS volume"
  value       = module.ebs_volume.volume_id
}

output "volume_arn" {
  description = "ARN of the created EBS volume"
  value       = module.ebs_volume.volume_arn
}

output "volume_attachment_id" {
  description = "ID of the volume attachment"
  value       = module.ebs_volume.attachment_id
}

output "availability_zone" {
  description = "Availability zone of the instance and volume"
  value       = module.ec2_instance.availability_zone
}