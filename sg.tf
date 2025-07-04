resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_sg
  description = var.ec2_sg_desc
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = var.ec2_access_port_conf
    to_port     = var.ec2_access_port_conf
    protocol    = var.net_protocol
    cidr_blocks = [var.ec2_cidr_blocks]
  }

  ingress {
    from_port   = var.ec2_access_port_http
    to_port     = var.ec2_access_port_http
    protocol    = var.net_protocol
    cidr_blocks = [var.ec2_cidr_blocks]
  }

  ingress {
    from_port   = var.ec2_access_port_https
    to_port     = var.ec2_access_port_https
    protocol    = var.net_protocol
    cidr_blocks = [var.ec2_cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.ec2_sg}"
  }

}

resource "aws_db_subnet_group" "default" {
  name       = "default-subnet-group"
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "${var.env}-db-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.env}-rds-access"
  description = "Allow access from EC2 to RDS"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = var.net_protocol
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-allow-EC2-to-access-RDS"
  }
}

