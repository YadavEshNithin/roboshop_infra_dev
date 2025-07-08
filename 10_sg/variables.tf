variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "frontend_allow_sg_name" {
  default = "allow_all_terraform"
}

variable "sg_desc" {
  default = "creating security group"
}

variable "bastion_sgn" {
  default = "bastion_sg"
}

variable "ports" {
  default = [22, 443, 1194, 943]
}
variable "mongodb_ports" {
  default = [22, 27017]
}
variable "redis_ports" {
  default = [22, 6379]
}
variable "mysql_ports_vpn" {
    default = [22, 3306]
}

variable "rabbitmq_ports_vpn" {
    default = [22, 5672]
}


####################################################################

#copy from repo

# variable "project" {
#     default = "roboshop"
# }

# variable "environment" {
#     default = "dev"
# }

# variable "frontend_sg_name" {
#     default = "frontend"
# }

# variable "frontend_sg_description" {
#     default = "created sg for frontend instance"
# }

# variable "bastion_sg_name" {
#     default = "bastion"
# }

# variable "bastion_sg_description" {
#     default = "created sg for bastion instance"
# }

# variable "mongodb_ports_vpn" {
#     default = [22, 27017]
# }

# variable "redis_ports_vpn" {
#     default = [22, 6379]
# }

# variable "mysql_ports_vpn" {
#     default = [22, 3306]
# }

# variable "rabbitmq_ports_vpn" {
#     default = [22, 5672]
# }