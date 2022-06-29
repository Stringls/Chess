# security groups
resource "aws_security_group" "rds-app-prod" {
  vpc_id      = module.vpc.aws_vpc.main.id
  name        = var.rds_identifier
  description = "Allow inbound SQL Server traffic"

  tags {
    Name      = var.rds_identifier
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
  source_security_group_id = aws_security_group.rds-app-prod.id
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
  name        = var.rds_identifier
  description = "RDS Subnet Group"
  subnet_ids  = [module.vpc.aws_subnet.main-private-1.id, module.vpc.aws_subnet.main-private-2.id]
}

resource "aws_db_instance" "rds-app-prod" {
  allocated_storage         = var.db_storage
  engine                    = "sqlserver-ex"
  engine_version            = var.msqql_engine_version
  instance_class            = var.db_instance_class
  identifier                = var.mssql_identifier
  storage_type              = "gp2"
  username                  = var.sql_admin_username
  password                  = var.sql_admin_password
  db_subnet_group_name      = aws_db_subnet_group.rds-app-prod.name
  parameter_group_name      = var.parameter_group_name
  multi_az                  = false
  vpc_security_group_ids    = ["${aws_security_group.rds-app-prod.id}"]
  backup_retention_period   = 30
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = "${var.environment}-mssql-final-snapshot"
  tags {
    Name      = "rds-app-prod"
    Env       = var.env
    ManagedBy = "terraform"
    Repo      = var.repo_url
  }
}