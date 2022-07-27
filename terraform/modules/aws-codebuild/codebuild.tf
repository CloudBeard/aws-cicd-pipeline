resource "aws_codebuild_project" "this_codebuild" {
  name          = "${var.base_name}-project"
  description   = "test_codebuild_project"
  build_timeout = "5"
  service_role  = var.codebuild_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = var.cicd_s3_bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${var.cicd_s3_bucket}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.buildspec
  }

  source_version = "master"

  tags = {
    Environment = "Mgmt"
  }
}
