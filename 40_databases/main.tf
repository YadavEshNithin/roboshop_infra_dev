resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.joindevops.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ local.mongodb_sg_id ]
  subnet_id = local.data_sub_ids[0]

  tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${var.project}.${var.environment}-mongodb"
    }
  )
}




# A use-case for terraform_data is as a do-nothing container
# for arbitrary actions taken by a provisioner.
resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.mongodb.private_ip
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
     ]
  }
}


resource "aws_instance" "redis" {
  ami           = data.aws_ami.joindevops.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ local.redis_sg_id ]
  subnet_id = local.data_sub_ids[0]

  tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${var.project}.${var.environment}-redis"
    }
  )
}




# A use-case for terraform_data is as a do-nothing container
# for arbitrary actions taken by a provisioner.
resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.redis.private_ip
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      # "pip3 install boto3 botocore",
      "sudo sh /tmp/bootstrap.sh redis ${var.environment}"
     ]
  }
}


resource "aws_instance" "mysql" {
  ami           = data.aws_ami.joindevops.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ local.mysql_sg_id ]
  subnet_id = local.data_sub_ids[0]
  iam_instance_profile = "Ec2fetchssmp"

  tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${var.project}.${var.environment}-mysql"
    }
  )
}






# A use-case for terraform_data is as a do-nothing container
# for arbitrary actions taken by a provisioner.
resource "terraform_data" "mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.mysql.private_ip
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mysql ${var.environment}",
      # "sudo sh /tmp/bootstrap.sh mysql ${data.aws_ssm_parameter.mysql_root_password.value}"
     ]
  }
}


resource "aws_instance" "rabbitmq" {
  ami           = data.aws_ami.joindevops.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ local.rabbitmq_sg_id ]
  subnet_id = local.data_sub_ids[0]

  tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${var.project}.${var.environment}-rabbitmq"
    }
  )
}




# A use-case for terraform_data is as a do-nothing container
# for arbitrary actions taken by a provisioner.
resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.rabbitmq.private_ip
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment}"
     ]
  }
}



resource "aws_route53_record" "mongodb" {
  zone_id = var.zone_id
  name    = "mongodb-${var.environment}.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "redis" {
  zone_id = var.zone_id
  name    = "redis-${var.environment}.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.redis.private_ip]
  allow_overwrite = true
}


resource "aws_route53_record" "mysql" {
  zone_id = var.zone_id
  name    = "mysql-${var.environment}.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mysql.private_ip]
  allow_overwrite = true
}


resource "aws_route53_record" "rabbitmq" {
  zone_id = var.zone_id
  name    = "rabbitmq-${var.environment}.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.rabbitmq.private_ip]
  allow_overwrite = true
}




