data "aws_cloudfront_cache_policy" "roboshop" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_cache_policy" "default" {
  name = "Managed-CachingDisabled"
}

data "aws_ssm_parameter" "acm_listener_arn" {
  name = "/${var.project}/${var.environment}/acm_listener_arn"
}