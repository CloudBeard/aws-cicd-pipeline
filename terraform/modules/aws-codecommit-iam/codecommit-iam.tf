data "aws_caller_identity" "current" {}

resource "aws_iam_group" "developer" {
  name = "developer"
  path = "/users/"
}

resource "aws_iam_group_policy" "developer_role_group_policy" {
  name = "developer_group_role_policy"
  group = aws_iam_group.developer.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AssumeDeveloperGroupRole"
        Resource = aws_iam_role.codereview_role.arn
      },
    ]
  })
}

resource "aws_iam_group" "developer_admin" {
  name = "developer_admin"
  path = "/users/"
}

resource "aws_iam_group_policy" "codereview_role_group_policy" {
  name = "codereviewer_group_role"
  group = aws_iam_group.developer_admin.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AssumeCodeReviewGroupRole"
        Resource = aws_iam_role.codereview_role.arn
      },
    ]
  })
}


resource "aws_iam_role" "codereview_role" {
  name = "codereviewer_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AssumeCodeReviewRole"
        Principal = { 
            AWS = "arn:aws:iam::${data.aws_caller_identity.current.id}:root"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "codereview_policy" {
  name = "codereviewer_policy"
  role = aws_iam_role.codereview_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "codecommit:AssociateApprovalRuleTemplateWithRepository",
          "codecommit:BatchAssociateApprovalRuleTemplateWithRepositories",
          "codecommit:BatchDisassociateApprovalRuleTemplateFromRepositories",
          "codecommit:DisassociateApprovalRuleTemplateFromRepository",
          "codecommit:EvaluatePullRequestApprovalRules",
          "codecommit:BatchGet*",
          "codecommit:BatchDescribe*",
          "codecommit:Create*",
          "codecommit:DeleteBranch",
          "codecommit:DeleteFile",
          "codecommit:Describe",
          "codecommit:Get*",
          "codecommit:List*",
          "codecommit:Merge*",
          "codecommit:OverridePullRequestApprovalRules",
          "codecommit:Put*",
          "codecommit:Post*",
          "codecommit:TagResource",
          "codecommit:Test*",
          "codecommit:UntagResource",
          "codecommit:Update*",
          "codecommit:GitPull",
          "codecommit:GitPush"
        ]
        Effect   = "Allow"
        Resource = var.codecommit_arn
      },
    ]
  })
}

resource "aws_iam_role" "developer_role" {
  name = "developer_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AssumeDeveloperRole"
        Principal = {
            AWS = "arn:aws:iam::${data.aws_caller_identity.current.id}:root"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "developer_policy" {
  name = "developer_policy"
  role = aws_iam_role.developer_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "codecommit:BatchGet*",
          "codecommit:BatchDescribe*",
          "codecommit:Create*",
          "codecommit:DeleteBranch",
          "codecommit:DeleteFile",
          "codecommit:Describe",
          "codecommit:Get*",
          "codecommit:List*",
          "codecommit:Put*",
          "codecommit:Post*",
          "codecommit:TagResource",
          "codecommit:Test*",
          "codecommit:UntagResource",
          "codecommit:Update*",
          "codecommit:GitPull",
          "codecommit:GitPush"
        ]
        Effect   = "Allow"
        Resource = var.codecommit_arn
      },
    ]
  })
}

resource "aws_codecommit_approval_rule_template" "main_reviewer" {
  name        = "ApprovalRuleTemplate"
  description = "This is the approval rule template for the IaC CICD pipeline"

  content = <<EOF
{
    "Version": "2018-11-08",
    "DestinationReferences": ["refs/heads/master"],
    "Statements": [{
        "Type": "Approvers",
        "NumberOfApprovalsNeeded": 1,
        "ApprovalPoolMembers": ["arn:aws:sts::${data.aws_caller_identity.current.id}:assumed-role/${aws_iam_role.codereview_role.name}/*"]
    }]
} 
EOF
}