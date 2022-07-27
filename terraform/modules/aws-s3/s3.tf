resource "aws_s3_bucket" "this_bucket" {
  bucket = "${var.base_name}-${var.aws_region}cicd"

  tags = {
    Name        = "CICD Bucket"
    Environment = "Mgmt"
 }
}

resource "aws_s3_bucket_acl" "this_bucket_acl" {
  bucket = aws_s3_bucket.this_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this_bucket_sse" {
  bucket = aws_s3_bucket.this_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_master_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this_bucket_public_access_block" {
  bucket = aws_s3_bucket.this_bucket.id

  block_public_acls   = true
  block_public_policy = true
}