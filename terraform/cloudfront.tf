resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Access Identity for CloudFront Distribution"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.website-bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.website-bucket.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }
  depends_on = [aws_cloudfront_origin_access_identity.origin_access_identity] # Add this line to establish the dependency

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  custom_error_response {
    error_code         = 403
    response_code      = 403
    response_page_path = "/error.html"
  }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = aws_s3_bucket.website-bucket.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    # lambda_function_association {
    #   event_type = "origin-response"
    #   lambda_arn = aws_lambda_function.web_lambda.qualified_arn
    #   include_body = false
    # }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

}
output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.s3_distribution.id
}
