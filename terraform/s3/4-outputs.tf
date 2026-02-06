output "bucket_name" {
  value = aws_s3_bucket.xgm-bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.xgm-bucket.arn
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.xgm-bucket.bucket_regional_domain_name
}

output "local_access_key_id" {
  value     = aws_iam_access_key.local_keys.id
  sensitive = true
}

output "local_secret_access_key" {
  value     = aws_iam_access_key.local_keys.secret
  sensitive = true
}
