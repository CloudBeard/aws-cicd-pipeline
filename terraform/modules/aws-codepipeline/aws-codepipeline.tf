resource "aws_codepipeline" "codepipeline" {
  name     = var.base_name
  role_arn = var.codepipeline_role

  artifact_store {
    location = var.cicd_s3_bucket
    type     = "S3"

    encryption_key {
      id   = var.kms_master_key_id
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName       = "${var.base_name}-pipeline-codecommit"
        PollForSourceChanges = true
        BranchName           = "master"
      }
    }
  }

  stage {
    name = "Build-TFLint"

    action {
      name             = "Build-TFLint"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_tflint_output"]
      version          = "1"

      configuration = {
        ProjectName = "build-tflint-project"
      }
    }
  }

  stage {
    name = "Build-Checkov"

    action {
      name             = "Build-Checkov"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_checkov_output"]
      version          = "1"

      configuration = {
        ProjectName = "build-checkov-project"
      }
    }
  }

    stage {
    name = "Manual-Approval"

    action {
      name             = "Manual-Approval"
      category         = "Approval"
      owner            = "AWS"
      provider         = "Manual"
      version          = "1"
      
      configuration = {
        NotificationArn = var.cicd_sns_arn
        ExternalEntityLink = var.codecommit_url
      }
    }
  }

  stage {
    name = "Build-Apply"

    action {
      name             = "Build-Apply"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_apply_output"]
      version          = "1"

      configuration = {
        ProjectName = "build-apply-project"
      }
    }
  }
}
