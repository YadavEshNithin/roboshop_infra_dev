variable "ec2_tags" {
  type = map(string)
  default = {
  }
}

variable "project" {
  default  = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "zone_id" {
  default = "Z06785221SBGYOQ3RLYGM"
}

variable "zone_name" {
  default = "rshopdaws84s.site"
}
