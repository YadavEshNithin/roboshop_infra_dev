data "aws_ssm_parameter" "vpc_idf" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "pri_idf" {
  name = "/${var.project}/${var.environment}/pri_sub_ids"
}


data "aws_ssm_parameter" "backend_alb_sg_idf" {
  name = "/${var.project}/${var.environment}/backend_alb_sg_id"
}

data "aws_ssm_parameter" "catalogue_sg_idf" {
  name = "/${var.project}/${var.environment}/catalogue_sg_id"
}

data "aws_ssm_parameter" "backend_alb_sg_idf_arn" {
  name = "/${var.project}/${var.environment}/backend_alb_listener_arn"
}

data "aws_ami" "joindevops" {
  owners      = ["973714476881"]
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }


}