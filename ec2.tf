data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.ec2_img_owner]

  filter {
    name   = "name"
    values = [var.ec2_img_name]
  }

  filter {
    name   = "virtualization-type"
    values = [var.ec2_img_virtualization_type]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_key_pair" "mvp_key" {
  key_name   = "mvp-key-pair"
  public_key = file(var.ec2_public_key_path)
}


resource "aws_instance" "mvp_ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = data.aws_subnets.default.ids[0]
  key_name                    = aws_key_pair.mvp_key.key_name
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.env}-mvp-ec2"
  }
}


resource "aws_eip" "mvp_eip" {
  instance = aws_instance.mvp_ec2.id
  domain   = "vpc"
}
