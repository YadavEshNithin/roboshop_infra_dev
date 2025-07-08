data "aws_ami" "joindevops" {
  owners      = ["973714476881"]
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }


}

data "aws_ssm_parameter" "mongodb_sg_id" {
  name =  "/${var.project}/${var.environment}/mongodb_sg_id"
}
data "aws_ssm_parameter" "redis_sg_id" {
  name =  "/${var.project}/${var.environment}/redis_sg_id"
}
data "aws_ssm_parameter" "mysql_sg_id" {
  name =  "/${var.project}/${var.environment}/mysql_sg_id"
}
data "aws_ssm_parameter" "rabbitmq_sg_id" {
  name =  "/${var.project}/${var.environment}/rabbitmq_sg_id"
}

data "aws_ssm_parameter" "data_sub_idsf" {
  name =  "/${var.project}/${var.environment}/data_sub_ids"
}
data "aws_ssm_parameter" "mysql_root_password" {
  name =  "/${var.project}/mysql/mysql_root_password"
}

# output "aws_ami_id" {
#   value = data.aws_ami.joindevops.id
# }