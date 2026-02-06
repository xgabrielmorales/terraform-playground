resource "aws_s3_bucket" "xgm-bucket" {
  bucket        = "xgm-bucket-${local.env}"
  force_destroy = true

  tags = {
    Environment = local.env
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "xgm-bucket" {
  bucket = aws_s3_bucket.xgm-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "xgm-bucket" {
  bucket = aws_s3_bucket.xgm-bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_iam_policy" "local_s3_policy" {
  name        = "xgm-local-s3-policy-${local.env}"
  description = "Allow local access to read and write to S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.xgm-bucket.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.xgm-bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_user" "local_user" {
  name = "xgm-s3-local-${local.env}"

  tags = {
    Environment = local.env
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_user_policy_attachment" "local_s3_attach" {
  user       = aws_iam_user.local_user.name
  policy_arn = aws_iam_policy.local_s3_policy.arn
}

resource "aws_iam_access_key" "local_keys" {
  user = aws_iam_user.local_user.name
}
