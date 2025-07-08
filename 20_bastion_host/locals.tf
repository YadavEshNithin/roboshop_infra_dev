locals {
  ami_id = data.aws_ami.joindevops.id
  security_group_id = data.aws_ssm_parameter.bastion_sgi.value
  pub_sub_ids = split(",", data.aws_ssm_parameter.pub_sub_idsf.value)
  common_tags = {
    project = "roboshop"
    environment = "dev"
    terraform = true
  }
}