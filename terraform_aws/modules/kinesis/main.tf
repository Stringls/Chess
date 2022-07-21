resource "aws_kinesis_stream" "test_stream" {
  name             = "${var.identifier}-${var.kinesis_name}"
  shard_count      = var.shard_count
  retention_period = var.retention_period

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  stream_mode_details {
    stream_mode = var.stream_mode
  }

  tags = {
    Name      = "${var.identifier}-${var.kinesis_name}"
    Env       = "${var.env}"
    ManagedBy = "terraform"
    Repo      = "${var.repo_url}"
  }
}