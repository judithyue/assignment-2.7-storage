output "volume_id" {
  description = "ID of the created EBS volume"
  value       = aws_ebs_volume.this.id
}

output "volume_arn" {
  description = "ARN of the created EBS volume"
  value       = aws_ebs_volume.this.arn
}

output "attachment_id" {
  description = "ID of the volume attachment"
  value       = aws_volume_attachment.this.id
}