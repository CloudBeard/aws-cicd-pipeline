resource "aws_codecommit_repository" "main" {
  repository_name = "${var.base_name}-pipeline-codecommit"
  description     = "This is the main CodeCommit Repository"
  default_branch  = "master"
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
        "ApprovalPoolMembers": ["arn:aws:sts::123456789012:assumed-role/CodeCommitReview/*"]
    }]
}git 
EOF
}
