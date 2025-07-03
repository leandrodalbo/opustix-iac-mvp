output "ec2_public_ip" {
  value = aws_eip.mvp_eip.public_ip
}