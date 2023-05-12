resource "aws_route53_zone" "web_zone" {
  name = "aliza-dileep-hasaan.com"
}

resource "aws_route53_record" "web_record" {
  zone_id = aws_route53_zone.web_zone.zone_id
  name    = "www.aliza-dileep-hasaan.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}