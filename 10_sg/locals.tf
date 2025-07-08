locals {
  vpc_id = data.aws_ssm_parameter.vpc_idf.value

  tg_ct = {
    catalogue = module.catalogue.sg_ido
    user      = module.user.sg_ido
    cart      = module.cart.sg_ido
    shipping  = module.shipping.sg_ido
    payment   = module.payment.sg_ido
    frontend  = module.frontend.sg_ido
  }
}
