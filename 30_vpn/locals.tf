locals {
  ami_id = data.aws_ami.OpenVPN.id
  security_group_id = data.aws_ssm_parameter.vpn_sgf.value
  # security_group_id = data.aws_ssm_parameter.vpn_sg_id.value
  pub_sub_ids = split(",", data.aws_ssm_parameter.pub_sub_idsf.value)
  common_tags = {
    project = "roboshop"
    environment = "dev"
    terraform = true
  }
}