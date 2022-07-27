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