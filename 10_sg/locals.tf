locals {
  vpc_id = data.aws_ssm_parameter.vpc_idf.value
}