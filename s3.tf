resource "aws_s3_bucket" "web_bucket" {
  bucket = var.bucket_name

  tags = var.common_tags
}
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_sse" {
  bucket = aws_s3_bucket.web_bucket.id
  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_versioning" "s3_ver" {
  bucket = aws_s3_bucket.web_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
data "aws_iam_policy_document" "allow_access_to_s3" {
  statement {
    sid = "AllowCloudFrontServicePrincipalRead"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.web_bucket.arn}/*",
    ]

    condition {
      test     = "StringLike"
      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.website-cf.arn
      ]
    }
  }

  depends_on = [
    aws_s3_bucket.web_bucket
  ]
}
resource "aws_s3_bucket_policy" "cf-policy" {
  bucket = aws_s3_bucket.web_bucket.bucket
  policy = data.aws_iam_policy_document.allow_access_to_s3.json
}
# Put a template index.html in the bucket
resource "aws_s3_object" "file_upload" {
  bucket 	= var.bucket_name
  key 		= "index.html"
  source 	= "index.html"
  content_type 	= "text/html"
}
