module "vpc" {
  source = "../../terraform_aws_vpc"
  # source = "git::https://github.com/YadavEshNithin/terraform_aws_vpc.git?ref=main"
  project = var.project
  environment = var.environment
  public_cidrs = var.public_cidrs
  private_cidrs = var.private_cidrs
  database_cidrs = var.database_cidrs
  is_peering_required = true
}

# output "pub_sub_ids" {
#   value = module.vpc.pub_sub_ids
# }