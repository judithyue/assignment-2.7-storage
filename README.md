# Terraform AWS EC2 with EBS Volume

This Terraform configuration creates an EC2 instance with an attached EBS volume using a modular architecture following industry best practices.

## Architecture

The configuration is organized into the following modules:

- `modules/ec2-instance`: Creates and configures the EC2 instance
- `modules/ebs-volume`: Creates the EBS volume and attaches it to the instance

## Features

- **Modular Design**: Reusable modules for EC2 instances and EBS volumes
- **Data Sources**: Automatically selects the latest Amazon Linux 2 AMI when not specified
- **Input Validation**: Validates instance types, volume sizes, and volume types
- **Comprehensive Tagging**: Consistent tagging across all resources
- **Detailed Outputs**: Provides all relevant resource identifiers and attributes
- **Remote State**: S3 backend with DynamoDB locking for state management

## Setup and Usage

### 1. Bootstrap Infrastructure (One-time setup)

First, create the S3 bucket and DynamoDB table for Terraform state storage:

```bash
# Initialize Terraform
terraform init

# Create the bootstrap resources (S3 bucket and DynamoDB table)
terraform apply -target=aws_s3_bucket.terraform_state \
                -target=aws_s3_bucket_versioning.terraform_state \
                -target=aws_s3_bucket_server_side_encryption_configuration.terraform_state \
                -target=aws_s3_bucket_public_access_block.terraform_state \
                -target=aws_dynamodb_table.terraform_locks
```

### 2. Configure Backend

After the bootstrap resources are created, uncomment the backend configuration in `backend.tf` and update the bucket name, region, and table name if necessary.

### 3. Deploy Main Infrastructure

```bash
# Re-initialize to use the S3 backend
terraform init

# Review the plan
terraform plan

# Apply the configuration
terraform apply
```

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `region` | AWS region | `ap-southeast-1` |
| `vpc_cidr` | VPC CIDR block | `10.0.0.0/16` |
| `public_subnet_cidr` | Public subnet CIDR | `10.0.1.0/24` |
| `vpc_name` | VPC name tag | `terraform-vpc` |
| `allowed_ssh_cidr_blocks` | SSH allowed CIDRs | `["0.0.0.0/0"]` |
| `availability_zone` | Availability zone | `ap-southeast-1a` |
| `ami_id` | AMI ID (optional) | Latest Amazon Linux 2 |
| `instance_type` | EC2 instance type | `t2.micro` |
| `instance_name` | Name tag for instance | `ju-ec2-storage` |
| `volume_size` | EBS volume size in GB | `1` |
| `volume_type` | EBS volume type | `gp2` |
| `volume_encrypted` | Encrypt the volume | `false` |
| `device_name` | Device name for attachment | `/dev/sdh` |
| `volume_name` | Name tag for volume | `ju-ebs-vol` |
| `tags` | Common tags | See variables.tf |
| `state_bucket_name` | S3 bucket for state | `terraform-state-assignment-2-7-storage` |
| `dynamodb_table_name` | DynamoDB table for locks | `terraform-locks-assignment-2-7-storage` |

## Outputs

- `vpc_id`: VPC ID
- `vpc_arn`: VPC ARN
- `vpc_cidr_block`: VPC CIDR block
- `public_subnet_id`: Public subnet ID
- `security_group_id`: EC2 security group ID
- `instance_id`: EC2 instance ID
- `instance_arn`: EC2 instance ARN
- `instance_public_ip`: Public IP address
- `instance_private_ip`: Private IP address
- `volume_id`: EBS volume ID
- `volume_arn`: EBS volume ARN
- `volume_attachment_id`: Volume attachment ID
- `availability_zone`: Availability zone

## Requirements

- Terraform >= 1.0
- AWS provider ~> 5.0
- AWS CLI configured with appropriate credentials
