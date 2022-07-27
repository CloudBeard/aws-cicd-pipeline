resource "aws_kms_key" "cicd_key" {
  description         = "Key for ${var.base_name} CICD"
  enable_key_rotation = true
}