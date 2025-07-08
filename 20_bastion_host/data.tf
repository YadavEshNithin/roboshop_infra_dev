data "aws_ami" "joindevops" {
  owners      = ["973714476881"]
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }


}

data "aws_ssm_parameter" "bastion_sgi" {
  name =  "/${var.project}/${var.environment}/bastion_sg_id"
}

data "aws_ssm_parameter" "pub_sub_idsf" {
  name =  "/${var.project}/${var.environment}/pub_sub_ids"
}

# output "aws_ami_id" {
#   value = data.aws_ami.joindevops.id
# }