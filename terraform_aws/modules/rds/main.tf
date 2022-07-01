# security groups
resource "aws_security_group" "rds-app-prod" {
  vpc_id      = var.vpc_id
  name        = "${var.identifier}-${var.rds_identifier}"
  description = "Allow inbound SQL Server traffic"

  tags = {
    Name      = "${var.identifier}-${var.rds_identifier}"
    Env       = var.env
    ManagedBy = "terraform"
    Repo      = var.repo_url
  }
}

resource "aws_security_group_rule" "allow-mssql" {
  type                     = "ingress"
  from_port                = 1433
  to_port                  = 1433
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds-app-prod.id
  source_security_group_id = var.eb_security_group_id
}

resource "aws_security_group_rule" "allow-outgoing" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.rds-app-prod.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# rds
resource "aws_db_subnet_group" "rds-app-prod" {
  name        = "${var.identifier}-${var.rds_identifier}"
  description = "RDS Subnet Group"
  subnet_ids  = [var.subnet_1_id, var.subnet_2_id]
}

resource "aws_db_instance" "rds-app-prod" {
  allocated_storage         = var.db_storage
  engine                    = "sqlserver-ex"
  engine_version            = var.msqql_engine_version
  instance_class            = var.db_instance_class
  identifier                = "${var.identifier}-${var.mssql_identifier}"
  storage_type              = "gp2"
  username                  = var.sql_admin_username
  password                  = var.sql_admin_password
  db_subnet_group_name      = aws_db_subnet_group.rds-app-prod.name
  multi_az                  = false
  vpc_security_group_ids    = ["${aws_security_group.rds-app-prod.id}"]
  backup_retention_period   = 30
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = "${var.identifier}-mssql-final-snapshot"

  tags = {
    Name      = "${var.identifier}-${var.rds_identifier}"
    Env       = var.env
    ManagedBy = "terraform"
    Repo      = var.repo_url
  }
}