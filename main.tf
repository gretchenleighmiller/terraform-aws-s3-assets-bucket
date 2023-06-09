# --- S3 bucket ---------------------------------------------------------------
resource "aws_s3_bucket" "storage_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "storage_bucket" {
  bucket = aws_s3_bucket.storage_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "storage_bucket" {
  bucket = aws_s3_bucket.storage_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

# --- IAM ---------------------------------------------------------------------
data "aws_iam_policy_document" "s3_access_policy" {
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}

resource "aws_iam_policy" "s3_access" {
  name        = "${local.snake_case_name}_s3_access"
  path        = "/"
  description = "${var.name} S3 access"

  policy = data.aws_iam_policy_document.s3_access_policy.json
}
