resource "aws_s3_bucket" "banners" {
  bucket        = "mvp-banners-bucket-${var.env}"
  force_destroy = true


  tags = {
    Name        = "Banners Bucket"
    Environment = var.env
  }
}

resource "aws_s3_bucket_public_access_block" "banners_block" {
  bucket = aws_s3_bucket.banners.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}
