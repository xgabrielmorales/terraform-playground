resource "aws_s3_bucket" "xgm-bucket" {
  bucket        = "xgm-bucket"
  force_destroy = true

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
