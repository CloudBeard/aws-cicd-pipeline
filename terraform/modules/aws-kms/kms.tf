resource "aws_kms_key" "cicd_key" {
  description         = "Key for ${var.base_name} CICD"
  enable_key_rotation = true
}

resource "aws_kms_alias" "cicd_key_name" {
  name          = "alias/cicd-key"
  target_key_id = aws_kms_key.cicd_key.key_id
}
