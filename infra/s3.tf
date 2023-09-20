
# Create the S3 bucket
resource "aws_s3_bucket" "site" {
  bucket = var.site_domain
}

# Set the S3 bucket policy to static website hosting
resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Allow the bucket to have a bucket read policy
resource "aws_s3_bucket_public_access_block" "site" {

  bucket = aws_s3_bucket.site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data aws_iam_policy_document "policy" {
  statement {
    sid = "PublicReadGetObject"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.site.arn}",
      "${aws_s3_bucket.site.arn}/*"
    ]
  }
}

# Set the S3 bucket policy to allow full public read
resource "aws_s3_bucket_policy" "site" {

  bucket = var.site_domain
  policy = data.aws_iam_policy_document.policy.json
}
