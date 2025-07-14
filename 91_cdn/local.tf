locals {
  
  acm_listener_arn = data.aws_ssm_parameter.acm_listener_arn.value
  common_tags = {
    project = "roboshop"
    environment = "dev"
    terraform = true
  }
}