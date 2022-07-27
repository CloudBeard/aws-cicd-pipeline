output "codebuild_role_arn" {
    value = aws_iam_role.codebuild_role.arn
    description = "The ARN of the Codebuild Role"
}