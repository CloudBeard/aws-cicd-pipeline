module "aws-codecommit" {
  source    = "./modules/aws-codecommit"
  base_name = var.base_name
}

module "aws-codebuild-iam" {
  source    = "./modules/aws-codebuild-iam"
  cicd_s3_arn = module.aws-s3.cicd_bucket_arn
}

module "aws-codepipeline-iam" {
  source    = "./modules/aws-codepipeline-iam"
  cicd_s3_arn = module.aws-s3.cicd_bucket_arn
  codebuild_role_arn  = module.aws-codebuild-iam.codebuild_role_arn
  codecommit_arn = module.aws-codecommit.codecommit_arn
  codebuild_tflint_arn = module.aws-codebuild-tflint.codebuild_arn
  codebuild_checkov_arn = module.aws-codebuild-checkov.codebuild_arn
  codebuild_terratest_arn = module.aws-codebuild-terratest.codebuild_arn
  kms_master_key_id = module.aws-kms.cicd_key_arn

}

module "aws-codebuild-tflint" {
    source    = "./modules/aws-codebuild"
    base_name = "build-tflint"
    codecommit_url = module.aws-codecommit.codecommit_url
    cicd_s3_bucket = module.aws-s3.cicd_bucket_bucket
    cicd_s3_arn = module.aws-s3.cicd_bucket_arn
    codebuild_role_arn  = module.aws-codebuild-iam.codebuild_role_arn
    buildspec = "buildspec-tflint.yml"

}

module "aws-codebuild-checkov" {
    source    = "./modules/aws-codebuild"
    base_name = "build-checkov"
    codecommit_url = module.aws-codecommit.codecommit_url
    cicd_s3_bucket = module.aws-s3.cicd_bucket_bucket
    cicd_s3_arn = module.aws-s3.cicd_bucket_arn
    codebuild_role_arn  = module.aws-codebuild-iam.codebuild_role_arn
    buildspec = "buildspec-checkov.yml"

}

module "aws-codebuild-terratest" {
    source    = "./modules/aws-codebuild"
    base_name = "build-terratest"
    codecommit_url = module.aws-codecommit.codecommit_url
    cicd_s3_bucket = module.aws-s3.cicd_bucket_bucket
    cicd_s3_arn = module.aws-s3.cicd_bucket_arn
    codebuild_role_arn  = module.aws-codebuild-iam.codebuild_role_arn
    buildspec = "buildspec-terratest.yml"

}

module "aws-codepipeline" {
  source = "./modules/aws-codepipeline"
  base_name = var.base_name
  codecommit_url = module.aws-codecommit.codecommit_url
  cicd_s3_bucket = module.aws-s3.cicd_bucket_bucket
  kms_master_key_id = module.aws-kms.cicd_key_arn
  codepipeline_role = module.aws-codepipeline-iam.codepipeline_role
}

module "aws-kms" {
    source    = "./modules/aws-kms"
    base_name = var.base_name
}

module "aws-s3" {
    source = "./modules/aws-s3"
    kms_master_key_id = module.aws-kms.cicd_key_arn
    base_name = var.base_name
}