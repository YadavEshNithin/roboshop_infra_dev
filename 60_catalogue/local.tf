locals {
  aws_ami_id = data.aws_ami.joindevops.id
  vpc_id = data.aws_ssm_parameter.vpc_idf.value
  pri_idf = split(",", data.aws_ssm_parameter.pri_idf.value)
  catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_idf.value
  listener_arn = data.aws_ssm_parameter.backend_alb_sg_idf_arn.value
  common_tags = {
    project = "roboshop"
    environment = "dev"
    terraform = true
  }
}