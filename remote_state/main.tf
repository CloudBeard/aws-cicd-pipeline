resource "aws_s3_bucket" "cicd_remote_state_s3" {
  bucket = "cicd-remote-state"
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "cicd_remote_state_lock_dynamodb" {
  name           = "cicd-remote-state-lock-dynamodb"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }
}
