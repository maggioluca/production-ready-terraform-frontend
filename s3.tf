resource aws_s3_bucket static {
  bucket = local.bucket_name 
}

resource "aws_s3_bucket_ownership_controls" "object" {
  bucket = aws_s3_bucket.static.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.block]
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.static.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.object]

  bucket = aws_s3_bucket.static.id
  acl    = "private"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.static.id
  key    = "index.html"
  source = "./public/index.html"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.static.id

  index_document {
    suffix = "index.html"
  }
}