output "developer_admin_arn" {
  value = aws_iam_group.developer_admin.arn
  description = "The ARN of the codereview role"
}