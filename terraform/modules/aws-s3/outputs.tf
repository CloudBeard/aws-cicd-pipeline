output "cicd_bucket_arn" {
    value = aws_s3_bucket.this_bucket.arn
    description = "The arn of the CICD bucket key"
}

output "cicd_bucket_bucket" {
    value = aws_s3_bucket.this_bucket.bucket
    description = "The bucket of the CICD bucket key"
}