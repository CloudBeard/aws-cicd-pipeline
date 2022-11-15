resource "aws_codecommit_repository" "main" {
  repository_name = "${var.base_name}-pipeline-codecommit"
  description     = "This is the main CodeCommit Repository"
  default_branch  = "master"
}
