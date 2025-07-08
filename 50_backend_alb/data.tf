data "aws_ssm_parameter" "vpc_idf" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "pri_idf" {
  name = "/${var.project}/${var.environment}/pri_sub_ids"
}


data "aws_ssm_parameter" "backend_alb_sg_idf" {
  name = "/${var.project}/${var.environment}/backend_alb_sg_id"
}