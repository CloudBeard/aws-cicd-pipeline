output "cicd_key_arn" {
    value = aws_kms_key.cicd_key.arn
    description = "The arn of the CICD kms key"
}