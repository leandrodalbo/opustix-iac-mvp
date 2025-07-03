variable "region" {
  description = "AWS region"
  type        = string
  default     = "sa-east-1"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "ec2_sg" {
  type    = string
  default = "mvp-ec2-sg"
}

variable "ec2_sg_desc" {
  type    = string
  default = "mvp-ec2-access"
}

variable "ec2_access_protocol" {
  type = string
}

variable "ec2_access_port_conf" {
  type = number
}

variable "ec2_access_port_http" {
  type = number
}

variable "ec2_access_port_https" {
  type = number
}

variable "ec2_cidr_blocks" {
  type = string
}

variable "ec2_img_owner" {
  type = string
}


variable "ec2_img_name" {
  type = string
}

variable "ec2_img_virtualization_type" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}

variable "ec2_public_key_path" {
  type = string
}



