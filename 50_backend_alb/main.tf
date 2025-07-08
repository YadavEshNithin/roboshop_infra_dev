module "alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "9.16.0"
  internal = true
  name    = "${var.project}-${var.environment}-backend-alb"
  vpc_id  = local.vpc_id
  subnets = local.pri_idf
  create_security_group = false
  security_groups = [local.backend_alb_sg_id]
  enable_deletion_protection = false

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-backend-alb"
    }
  )
}



resource "aws_lb_listener" "backend_alb_fr" {
  load_balancer_arn = module.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1> hello from iam from the backend alb </h1>"
      status_code  = "200"
    }
  }
}


resource "aws_route53_record" "backend_alb" {
  zone_id = var.zone_id
  name    = "*.backend-${var.environment}.${var.zone_name}"
  type    = "A"

  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}