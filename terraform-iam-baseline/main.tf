provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "cloud_user" {
  name = "cloud-security-user"
}

resource "aws_iam_policy" "s3_read_only" {
  name        = "S3ReadOnlyPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:ListBucket"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.cloud_user.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}
