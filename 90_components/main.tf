module "component" {
  for_each = var.components
  # source = "../../terraform_aws_roboshop"
  source = "git::https://github.com/YadavEshNithin/terraform_aws_roboshop.git?ref=main"
  component = each.key
  rule_priority = each.value.rule_priority
}