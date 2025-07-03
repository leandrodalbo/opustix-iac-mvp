output "ec2_public_ip" {
  value = aws_eip.mvp_eip.public_ip
}

output "banners_bucket_name" {
  value = aws_s3_bucket.banners.bucket
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "rds_db_name" {
  value = aws_db_instance.postgres.db_name
}
