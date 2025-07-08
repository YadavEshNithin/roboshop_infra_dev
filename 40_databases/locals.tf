locals {
  ami_id = data.aws_ami.joindevops.id
  mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
  redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
  mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
  rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
  data_sub_ids = split(",", data.aws_ssm_parameter.data_sub_idsf.value)
  common_tags = {
    project = "roboshop"
    environment = "dev"
    terraform = true
  }
}