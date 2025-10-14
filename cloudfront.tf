resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "web_bucket"
  description                       = "Limit Access to S3 Bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "website-cf" {
  comment			= var.domain_name
  origin {
    domain_name              	= aws_s3_bucket.web_bucket.bucket_regional_domain_name
    origin_access_control_id 	= aws_cloudfront_origin_access_control.oac.id
    origin_id                	= aws_s3_bucket.web_bucket.id
  }
  enabled			= true
  is_ipv6_enabled		= true
  default_root_object		= "index.html"
  aliases 			= ["${var.domain_name}", "www.${var.domain_name}"]
  price_class			= "PriceClass_100"
  tags 				= var.common_tags
  default_cache_behavior {
    allowed_methods 			= ["GET", "HEAD"]
    cached_methods 			= ["GET", "HEAD"]
    # Using the Managed-CachingOptimizedForUncompressedObjects Policy
    cache_policy_id			= "b2884449-e4de-46a7-ac36-70bc7f1ddd6d"
    target_origin_id			= aws_s3_bucket.web_bucket.id
    min_ttl				= 0
    default_ttl				= 14400
    max_ttl				= 86400
    compress				= false
    viewer_protocol_policy		= "redirect-to-https"
  }
  restrictions {
    geo_restriction {
      restriction_type 			= "whitelist"
      locations				= ["US", "CA", "GB"]
    }
  }
  viewer_certificate {
    acm_certificate_arn 		= aws_acm_certificate.web_cert.arn
    ssl_support_method  		= "sni-only"
  }
}
