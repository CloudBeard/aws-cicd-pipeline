output "cicd_sns_arn" {
    value = aws_sns_topic.cicd_sns.arn
    description = "The arn of the CICD SNS Topic"
}