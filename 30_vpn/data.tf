data "aws_ami" "OpenVPN" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-8fbe3379-63b6-43e8-87bd-0e93fd7be8f3"]
  }


}

data "aws_ssm_parameter" "vpn_sgf" {
  name =  "/${var.project}/${var.environment}/vpn_sg_id"
}
# data "aws_ssm_parameter" "vpn_sg_id" {
#   name =  "/${var.project}/${var.environment}/vpn_sg_id"
# }
data "aws_ssm_parameter" "pub_sub_idsf" {
  name =  "/${var.project}/${var.environment}/pub_sub_ids"
}

# output "aws_ami_id" {
#   value = data.aws_ami.joindevops.id
# }