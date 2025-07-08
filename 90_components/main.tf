module "component" {
  for_each = var.components
  source = "../../terraform_aws_roboshop"
  component = each.key
  rule_priority = each.value.rule_priority
}