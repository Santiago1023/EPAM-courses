data "aws_cloudfront_distribution" "dev" {
  id       = var.cloudfront_id
}

resource "aws_route53_record" "dev" {
  zone_id  = data.aws_route53_zone.this[0].zone_id
  name     = "www-dev-concept-example"
  type     = "CNAME"
  ttl      = "300"
  records  = [data.aws_cloudfront_distribution.dev.domain_name]
}