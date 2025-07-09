data "aws_iam_role" "bastion_role" {
  name = "Terraformadmin"  # Replace with the actual role name
}


resource "aws_iam_instance_profile" "example" {
  name = "instance-profile-name" # Replace with a name
  role = data.aws_iam_role.bastion_role.name
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.joindevops.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ local.security_group_id ]
  subnet_id = local.pub_sub_ids[0]
  iam_instance_profile = aws_iam_instance_profile.example.name

    root_block_device {
    volume_size = 50
    volume_type = "gp3" # or "gp2", depending on your preference
  }

  tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${var.project}.${var.environment}-bastion"
    }
  )
}


resource "terraform_data" "bastion_userdata" {
  triggers_replace = [
    aws_instance.bastion.id
  ]

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.bastion.public_ip
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh "
     ]
  }
}