data "aws_kms_alias" "cicd_key_alias" {
  name = "alias/cicd-key"
}

resource "aws_sns_topic" "cicd_sns" {
  name              = "cicd-sns"
  kms_master_key_id = data.aws_kms_alias.cicd_key_alias.target_key_id
}