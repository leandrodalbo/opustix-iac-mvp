resource "aws_s3_bucket" "banners" {
  bucket        = "mvp-banners-bucket-${var.env}"
  force_destroy = true

  tags = {
    Name        = "Banners Bucket"
    Environment = var.env
  }
}
