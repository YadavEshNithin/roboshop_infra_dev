# resource "aws_ssm_parameter" "acm_listener_arn" {
#   name  = "/${var.project}/${var.environment}/acm_listener_arn"
#   type  = "String"
#   value = aws_acm_certificate.rshopdaws84s.arn
# }

resource "aws_ssm_parameter" "acm_listener_arn" {
  name  = "/${var.project}/${var.environment}/acm_listener_arn"
  type  = "String"
  value = aws_acm_certificate.daws84s.arn
}

