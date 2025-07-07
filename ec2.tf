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

resource "aws_key_pair" "mvp_key" {
  key_name   = "mvp-key-pair"
  public_key = file(var.ec2_public_key_path)
}


resource "aws_instance" "mvp_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.ec2_instance_type
  subnet_id              = data.aws_subnets.default.ids[0]
  key_name               = aws_key_pair.mvp_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "${var.env}-mvp-ec2"
  }
}

resource "aws_instance" "auth_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.ec2_instance_type
  subnet_id              = data.aws_subnets.default.ids[0]
  key_name               = aws_key_pair.mvp_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "${var.env}-mvp-ec2"
  }
}


resource "aws_eip" "auth_eip" {
  instance = aws_instance.auth_ec2.id
  domain   = "vpc"
}


resource "aws_eip" "mvp_eip" {
  instance = aws_instance.mvp_ec2.id
  domain   = "vpc"
}

resource "null_resource" "provision_mvp_ec2" {
  depends_on = [aws_eip.mvp_eip]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release",

      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",

      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",

      "sudo apt-get update -y",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",

      "sudo usermod -aG docker ubuntu"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ec2_private_key_path)
      host        = aws_eip.mvp_eip.public_ip
    }
  }
}



resource "null_resource" "provision_auth_ec2" {
  depends_on = [aws_eip.auth_eip]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release",

      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",

      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",

      "sudo apt-get update -y",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",

      "sudo usermod -aG docker ubuntu"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ec2_private_key_path)
      host        = aws_eip.auth_eip.public_ip
    }
  }
}
