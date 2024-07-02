# BLOG
resource "aws_s3_bucket" "blog_site" {
  bucket = var.blog_subdomain
}

# Set the S3 bucket policy to static website hosting
resource "aws_s3_bucket_website_configuration" "blog_config" {
  bucket = aws_s3_bucket.blog_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "blog_public_access_block" {

  bucket = aws_s3_bucket.blog_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data aws_iam_policy_document "blog_site_policy" {
  statement {
    sid = "PublicReadGetObject"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.blog_site.arn}",
      "${aws_s3_bucket.blog_site.arn}/*"
    ]
  }
}

# Set the S3 bucket policy to allow full public read
resource "aws_s3_bucket_policy" "blog_site_policy" {
  bucket = var.blog_subdomain
  policy = data.aws_iam_policy_document.blog_site_policy.json
}

# RESUME
resource "aws_s3_bucket" "resume_site" {
  bucket = var.resume_subdomain
}

# Set the S3 bucket policy to static website hosting
resource "aws_s3_bucket_website_configuration" "resume_config" {
  bucket = aws_s3_bucket.resume_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "resume_public_access_block" {

  bucket = aws_s3_bucket.resume_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data aws_iam_policy_document "resume_site_policy" {
  statement {
    sid = "PublicReadGetObject"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.resume_site.arn}",
      "${aws_s3_bucket.resume_site.arn}/*"
    ]
  }
}

# Set the S3 bucket policy to allow full public read
resource "aws_s3_bucket_policy" "resume_site_policy" {
  bucket = var.resume_subdomain
  policy = data.aws_iam_policy_document.resume_site_policy.json
}