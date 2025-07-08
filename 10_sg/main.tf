module "frontend" {
  # source = "git::https://github.com/YadavEshNithin/terraform_aws_sg.git?ref=main"
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = var.sg_desc
  vpc_id      = local.vpc_id
  sg_name     = var.frontend_allow_sg_name
}
resource "aws_security_group_rule" "frontend_alb_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.backend_alb.sg_ido
}
resource "aws_security_group_rule" "frontend_alb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend_alb.sg_ido
  security_group_id = module.frontend.sg_ido
}
resource "aws_security_group_rule" "frontend_backend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend.sg_ido
  security_group_id = module.backend_alb.sg_ido
}
resource "aws_security_group_rule" "vpn_frontend" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id = module.frontend.sg_ido
}
module "bastion" {
  source = "../../terraform_aws_sg"
  project = var.project
  environment = var.environment
  sg_desc = var.sg_desc
  vpc_id = local.vpc_id
  sg_name = var.bastion_sgn
}


resource "aws_security_group_rule" "bastion_host" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       =  ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_ido
}
resource "aws_security_group_rule" "bastion_catalogue" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_ido
  security_group_id = module.catalogue.sg_ido
}
module "backend_alb" {
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = "for backend alb"
  vpc_id      = local.vpc_id
  sg_name     = "backend_alb"
}

resource "aws_security_group_rule" "backend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_ido
  security_group_id = module.backend_alb.sg_ido
}

module "vpn" {
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = "for vpn "
  vpc_id      = local.vpc_id
  sg_name     = "vpn"
}

#VPN ports 22, 443, 1194, 943
resource "aws_security_group_rule" "vpn_ssh" {
  count             = length(var.ports)
  type              = "ingress"
  from_port         = var.ports[count.index]
  to_port           = var.ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_ido
}

# # resource "aws_security_group_rule" "vpn_ssh" {
# #   type              = "ingress"
# #   from_port         = 22
# #   to_port           = 22
# #   protocol          = "tcp"
# #   cidr_blocks = ["0.0.0.0/0"]
# #   security_group_id = module.vpn.sg_ido
# # }

# # resource "aws_security_group_rule" "vpn_https" {
# #   type              = "ingress"
# #   from_port         = 443
# #   to_port           = 443
# #   protocol          = "tcp"
# #   cidr_blocks = ["0.0.0.0/0"]
# #   security_group_id = module.vpn.sg_ido
# # }

# # resource "aws_security_group_rule" "vpn_1194" {
# #   type              = "ingress"
# #   from_port         = 1194
# #   to_port           = 1194
# #   protocol          = "tcp"
# #   cidr_blocks = ["0.0.0.0/0"]
# #   security_group_id = module.vpn.sg_ido
# # }

# # resource "aws_security_group_rule" "vpn_943" {
# #   type              = "ingress"
# #   from_port         = 943
# #   to_port           = 943
# #   protocol          = "tcp"
# #   cidr_blocks = ["0.0.0.0/0"]
# #   security_group_id = module.vpn.sg_ido
# # }


resource "aws_security_group_rule" "vpn_http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.backend_alb.sg_ido
}


module "mongodb" {
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = "for mongodb sg"
  vpc_id      = local.vpc_id
  sg_name     = "mongodb_sg"
}

resource "aws_security_group_rule" "mongodb_vpn_ssh" {
  count                    = length(var.mongodb_ports)
  type                     = "ingress"
  from_port                = var.mongodb_ports[count.index]
  to_port                  = var.mongodb_ports[count.index]
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.mongodb.sg_ido
}
module "redis" {
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = "for redis_sg"
  vpc_id      = local.vpc_id
  sg_name     = "redis_sg"
}

resource "aws_security_group_rule" "redis_vpn_ssh" {
  count                    = length(var.redis_ports)
  type                     = "ingress"
  from_port                = var.redis_ports[count.index]
  to_port                  = var.redis_ports[count.index]
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.redis.sg_ido
}
module "mysql" {
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = "for mysql_vpn_ssh"
  vpc_id      = local.vpc_id
  sg_name     = "mysql_vpn_ssh"
}

resource "aws_security_group_rule" "mysql_vpn_ssh" {
  count                    = length(var.mysql_ports_vpn)
  type                     = "ingress"
  from_port                = var.mysql_ports_vpn[count.index]
  to_port                  = var.mysql_ports_vpn[count.index]
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.mysql.sg_ido
}


module "rabbitmq" {
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = "for rabbitmq_vpn_ssh"
  vpc_id      = local.vpc_id
  sg_name     = "rabbitmq_vpn_ssh"
}

resource "aws_security_group_rule" "rabbitmq_vpn_ssh" {
  count                    = length(var.rabbitmq_ports_vpn)
  type                     = "ingress"
  from_port                = var.rabbitmq_ports_vpn[count.index]
  to_port                  = var.rabbitmq_ports_vpn[count.index]
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.rabbitmq.sg_ido
}

module "catalogue" {
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = "for catalogue"
  vpc_id      = local.vpc_id
  sg_name     = "catalogue"
}

resource "aws_security_group_rule" "catalogue_backend_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.backend_alb.sg_ido
  security_group_id        = module.catalogue.sg_ido
}

resource "aws_security_group_rule" "catalogue_vpn_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.catalogue.sg_ido
}

resource "aws_security_group_rule" "catalogue_vpn_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.catalogue.sg_ido
}

# resource "aws_security_group_rule" "catalogue_bastion_ssh" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.bastion_sg.sg_ido
#   security_group_id = module.catalogue.sg_ido
# }

resource "aws_security_group_rule" "catalogue_mongodb_connect" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.catalogue.sg_ido
  security_group_id        = module.mongodb.sg_ido
}
resource "aws_security_group_rule" "catalogue_cart" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.catalogue.sg_ido
  security_group_id        = module.backend_alb.sg_ido
}
module "frontend_alb" {
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = "for frontend_alb"
  vpc_id      = local.vpc_id
  sg_name     = "frontend_alb"
}

resource "aws_security_group_rule" "frontend_alb_connect" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend_alb.sg_ido
}

module "user" {
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = "for user"
  vpc_id      = local.vpc_id
  sg_name     = "user"
}

resource "aws_security_group_rule" "user_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.user.sg_ido
  security_group_id        = module.redis.sg_ido
}

resource "aws_security_group_rule" "user_mongo" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.user.sg_ido
  security_group_id        = module.mongodb.sg_ido
}


resource "aws_security_group_rule" "user_vpn_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.user.sg_ido
}

resource "aws_security_group_rule" "user_vpn_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.user.sg_ido
}

resource "aws_security_group_rule" "user_backend_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.backend_alb.sg_ido
  security_group_id        = module.user.sg_ido
}


module "cart" {
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = "for cart"
  vpc_id      = local.vpc_id
  sg_name     = "cart"
}

resource "aws_security_group_rule" "cart_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.cart.sg_ido
  security_group_id        = module.redis.sg_ido
}

resource "aws_security_group_rule" "backend_alb_cart" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.backend_alb.sg_ido
  security_group_id        = module.cart.sg_ido
}

resource "aws_security_group_rule" "cart_catalogue_backend_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.cart.sg_ido
  security_group_id        = module.backend_alb.sg_ido
}


resource "aws_security_group_rule" "cart_vpn_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.cart.sg_ido
}

resource "aws_security_group_rule" "cart_vpn_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.cart.sg_ido
}

module "shipping" {
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = "for shipping"
  vpc_id      = local.vpc_id
  sg_name     = "shipping"
}

resource "aws_security_group_rule" "shipping_backend" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.shipping.sg_ido
  security_group_id        = module.backend_alb.sg_ido
}
resource "aws_security_group_rule" "shipping_cart" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.backend_alb.sg_ido
  security_group_id        = module.shipping.sg_ido
}

resource "aws_security_group_rule" "shipping_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.shipping.sg_ido
  security_group_id        = module.mysql.sg_ido
}


resource "aws_security_group_rule" "shipping_ssh_vpn" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.shipping.sg_ido
}
resource "aws_security_group_rule" "shipping_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id = module.shipping.sg_ido
}

module "payment" {
  source      = "../../terraform_aws_sg"
  project     = var.project
  environment = var.environment
  sg_desc     = "for payment"
  vpc_id      = local.vpc_id
  sg_name     = "payment"
}

resource "aws_security_group_rule" "payment_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_ido
  security_group_id        = module.payment.sg_ido
}
resource "aws_security_group_rule" "payment_backend_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.payment.sg_ido
  security_group_id        = module.backend_alb.sg_ido
}
resource "aws_security_group_rule" "payment_cart" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.backend_alb.sg_ido
  security_group_id        = module.payment.sg_ido
}
resource "aws_security_group_rule" "payment_rabbbitmq" {
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  source_security_group_id = module.payment.sg_ido
  security_group_id        = module.rabbitmq.sg_ido
}
########################################################################

#copy from repo


##############################################again
