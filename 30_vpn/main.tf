resource "aws_key_pair" "vpn_keypair" {
  key_name   = "openvpn-key"
  public_key = file("C:\\devops\\openvpn.pub")
}

resource "aws_instance" "vpn" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ local.security_group_id ]
  subnet_id = local.pub_sub_ids[0]
  key_name = aws_key_pair.vpn_keypair.key_name
  user_data = file("openvpn.sh")

  tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${var.project}.${var.environment}-vpn"
    }
  )
}


resource "aws_route53_record" "vpn-backend-dev" {
  zone_id = var.zone_id
  name    = "vpn-dev"
  type    = "A"
  ttl     = 1
  records = [aws_instance.vpn.public_ip]
  allow_overwrite = true
}