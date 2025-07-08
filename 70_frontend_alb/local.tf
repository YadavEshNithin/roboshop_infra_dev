locals {
  vpc_id = data.aws_ssm_parameter.vpc_idf.value
  pub_idf = split(",", data.aws_ssm_parameter.pub_idf.value)
  frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
  # frontend_alb_listener_arn = data.aws_ssm_parameter.frontend_alb_listener_arn.value
  # backend_alb_sg_id = data.aws_ssm_parameter.vpn_sg_id.value
  acm_listener_arn = data.aws_ssm_parameter.acm_listener_arn.value
  common_tags = {
    project = "roboshop"
    environment = "dev"
    terraform = true
  }
}