module "user" {
  source = "../../terraform_aws_roboshop"
  component = "user"
  rule_priority = 20
}