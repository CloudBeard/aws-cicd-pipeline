variable "codebuild_role_arn" {
  type        = string
  description = "The CICD KMS Key ARN"
}

variable "cicd_s3_arn" {
  type        = string
  description = "The S3 Bucket for CICD pipeline"
}

variable "codecommit_arn" {
  type        = string
  description = "The ARN for the repository"
}

variable "codebuild_tflint_arn" {
  type        = string
  description = "The ARN for the CodeBuild tflint build"
}

variable "codebuild_checkov_arn" {
  type        = string
  description = "The ARN for the CodeBuild checkov build"
}

variable "codebuild_terratest_arn" {
  type        = string
  description = "The ARN for the CodeBuild terratest build"
}

variable "kms_master_key_id" {
  type        = string
  description = "The CICD KMS Key ARN"
}