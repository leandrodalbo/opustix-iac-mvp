resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_sg
  description = var.ec2_sg_desc
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = var.ec2_access_port_conf
    to_port     = var.ec2_access_port_conf
    protocol    = var.ec2_access_protocol
    cidr_blocks = [var.ec2_cidr_blocks]
  }

  ingress {
    from_port   = var.ec2_access_port_http
    to_port     = var.ec2_access_port_http
    protocol    = var.ec2_access_protocol
    cidr_blocks = [var.ec2_cidr_blocks]
  }

  ingress {
    from_port   = var.ec2_access_port_https
    to_port     = var.ec2_access_port_https
    protocol    = var.ec2_access_protocol
    cidr_blocks = [var.ec2_cidr_blocks]
  }

}
