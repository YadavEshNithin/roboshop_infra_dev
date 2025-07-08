data "aws_ssm_parameter" "vpc_idf" {
  name = "/${var.project}/${var.environment}/vpc_id"
}



