locals {
  vpc_id = data.aws_ssm_parameter.vpc_idf.value
  pri_idf = split(",", data.aws_ssm_parameter.pri_idf.value)
  backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_idf.value
  # backend_alb_sg_id = data.aws_ssm_parameter.vpn_sg_id.value
  common_tags = {
    project = "roboshop"
    environment = "dev"
    terraform = true
  }
}