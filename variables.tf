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

variable "net_protocol" {
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

variable "ec2_private_key_path" {
  type = string
}


variable "db_port" {
  type = number
}

variable "db_name" {
  type = string
}
variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "rds_identifier" {
  type = string
}

variable "rds_engine" {
  type = string
}

variable "rds_engine_version" {
  type = string
}

variable "rds_instance_class" {
  type = string
}

variable "rds_allocated_storage" {
  type = number
}



