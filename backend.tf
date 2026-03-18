# Terraform Backend Configuration
# Uncomment this after running the bootstrap to store state in S3

 terraform {
   backend "s3" {
     bucket         = "terraform-state-assignment-2-7-storage"  # Update with your actual bucket name
     key            = "assignment-2.7-storage/terraform.tfstate"
     region         = "ap-southeast-1"  # Update with your region
     dynamodb_table = "terraform-locks-assignment-2-7-storage"  # Update with your table name
     encrypt        = true
   }
 }

 