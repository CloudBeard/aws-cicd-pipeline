output "codebuild_arn" {
    value = aws_codebuild_project.this_codebuild.arn
    description = "ARN for each CodeBuild Project."
}