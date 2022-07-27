variable "base_name" {
  type        = string
  description = "The base name for all resources"
}
variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "The default region for dem bros"
}

variable "kms_master_key_id" {
  type        = string
  description = "The CICD KMS Key ARN"
}

variable "codecommit_url" {
  type        = string
  description = "The URL to use for cloning the repository over HTTPS"
}

variable "cicd_s3_bucket" {
  type        = string
  description = "The S3 Bucket for CICD pipeline"
}

variable "codepipeline_role" {
  type        = string
  description = "The ARN for CodePipeline Role"
}