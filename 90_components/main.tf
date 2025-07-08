module "component" {
  for_each = var.components
  # source = "../../terraform_aws_roboshop"
  source = "https://github.com/YadavEshNithin/terraform_aws_roboshop.git"
  component = each.key
  rule_priority = each.value.rule_priority
}