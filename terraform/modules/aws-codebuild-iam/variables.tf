variable "cicd_s3_arn" {
  type        = string
  description = "The S3 Bucket for CICD pipeline"
}

variable "kms_master_key_id" {
  type        = string
  description = "The CICD KMS Key ARN"
}
