output "codepipeline_role" {
    value = aws_iam_role.codepipeline_role.arn
    description = "The ARN for CodePipeline IAM Role"
}