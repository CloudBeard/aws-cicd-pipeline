variable "base_name" {
  type        = string
  description = "The base name for all resources"
}

variable "codecommit_url" {
  type        = string
  description = "The URL to use for cloning the repository over HTTPS"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "The default region for dem bros"
}

variable "cicd_s3_bucket" {
  type        = string
  description = "The S3 Bucket for CICD pipeline"
}

variable "cicd_s3_arn" {
  type        = string
  description = "The S3 Bucket for CICD pipeline"
}

variable "codebuild_role_arn" {
  type        = string
  description = "The Service Role for CodeBuild"
}

variable "buildspec" {
  type        = string
  description = "The Service Role for CodeBuild"
}
