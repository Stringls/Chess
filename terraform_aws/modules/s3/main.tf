# cache s3 bucket
resource "aws_s3_bucket" "codebuild-cache" {
  bucket = "${var.identifier}-codebuild-cache-${random_string.random.result}"
}

resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.identifier}-artifacts-${random_string.random.result}"
}

# Lifecycle configuration is available starting with AWS Provider 4.x
resource "aws_s3_bucket_lifecycle_configuration" "artifacts-lifecycle" {
  bucket = aws_s3_bucket.artifacts.id

  rule {
      id = "${var.rule_id}"
      status = "${var.lifecycle_rule_status}"

      expiration {
        days = var.lifecycle_expiration
      }
  }
}

resource "random_string" "random" {
  length = 8
  special = false
  upper = false
}