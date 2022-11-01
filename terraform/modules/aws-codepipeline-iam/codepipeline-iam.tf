resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_role_policy" {
  role = aws_iam_role.codepipeline_role.name

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:*"
          ],
          "Resource" : [
            "*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "kms:GenerateDataKey",
            "kms:Encrypt",
            "kms:Decrypt"
          ],
          "Resource" : [
            var.kms_master_key_id
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iam:PassRole",
          "Resource" : var.codebuild_role_arn
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "codecommit:BatchGet*",
            "codecommit:BatchDescribe*",
            "codecommit:Describe*",
            "codecommit:Get*",
            "codecommit:List*",
            "codecommit:GitPull",
            "codecommit:UploadArchive",
            "codecommit:GetBranch",
          ],
          "Resource" : [
            var.codecommit_arn
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "codebuild:StartBuild",
            "codebuild:StopBuild",
            "codebuild:BatchGetBuilds"
          ],
          "Resource" : [
            var.codebuild_tflint_arn,
            var.codebuild_checkov_arn,
            var.codebuild_apply_arn
          ]
        }
      ]
    }
  )
}
