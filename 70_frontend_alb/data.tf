data "aws_ssm_parameter" "vpc_idf" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "pub_idf" {
  name = "/${var.project}/${var.environment}/pub_sub_ids"
}


data "aws_ssm_parameter" "frontend_alb_sg_id" {
  name = "/${var.project}/${var.environment}/frontend_alb_sg_id"
}


# data "aws_ssm_parameter" "frontend_alb_listener_arn" {
#   name = "/${var.project}/${var.environment}/frontend_alb_listener_arn"
# }

data "aws_ssm_parameter" "acm_listener_arn" {
  name = "/${var.project}/${var.environment}/acm_listener_arn"
}