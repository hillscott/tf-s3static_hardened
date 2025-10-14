resource "aws_s3_bucket" "web_bucket" {
  bucket = "${var.bucket_name}"

  tags = var.common_tags
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
