output "bucket_arn" {
  value       = aws_s3_bucket.storage_bucket.arn
  description = "The ARN of the S3 bucket."
}

output "s3_access_policy" {
  value = {
    name = aws_iam_policy.s3_access.name
    arn  = aws_iam_policy.s3_access.arn
  }
  description = "The name and ARN of the IAM policy to access the S3 bucket."
}
