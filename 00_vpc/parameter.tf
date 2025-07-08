resource "aws_ssm_parameter" "vpc_idp" {
  name  = "/${var.project}/${var.environment}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_ide
}
resource "aws_ssm_parameter" "pub_sub_idss" {
  name  = "/${var.project}/${var.environment}/pub_sub_ids"
  type  = "StringList"
  value = join(",", module.vpc.pub_sub_ids ) 
}
resource "aws_ssm_parameter" "pri_sub_idss" {
  name  = "/${var.project}/${var.environment}/pri_sub_ids"
  type  = "StringList"
  value = join(",", module.vpc.pri_sub_ids ) 

}
resource "aws_ssm_parameter" "data_sub_idss" {
  name  = "/${var.project}/${var.environment}/data_sub_ids"
  type  = "StringList"
  value = join(",", module.vpc.data_sub_ids ) 

}

