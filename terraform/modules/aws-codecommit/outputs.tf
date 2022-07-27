output "codecommit_url" {
  value = aws_codecommit_repository.main.clone_url_http
  description = "The URL to use for cloning the repository over HTTPS"
}

output "codecommit_arn" {
  value = aws_codecommit_repository.main.arn
  description = "The ARN of the CICD repository"
}