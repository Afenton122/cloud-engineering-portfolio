terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

############################
# VARIABLES
############################

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "iam-security-baseline"
}

variable "environment" {
  description = "Environment type"
  type        = string
  default     = "dev"
}

############################
# IAM USER
############################

resource "aws_iam_user" "cloud_user" {
  name = "cloud-security-user"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

############################
# IAM POLICY (least privilege)
############################

resource "aws_iam_policy" "s3_read_only" {
  name        = "S3ReadOnlyPolicy"
  description = "Read-only access to specific S3 resources for baseline IAM project"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = "arn:aws:s3:::example-bucket"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = "arn:aws:s3:::example-bucket/*"
      }
    ]
  })

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

############################
# ATTACHMENT
############################

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.cloud_user.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}

############################
# OUTPUTS
############################

output "iam_user_name" {
  value = aws_iam_user.cloud_user.name
}

output "iam_policy_arn" {
  value = aws_iam_policy.s3_read_only.arn
}