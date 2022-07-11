# key pair
resource "aws_key_pair" "app" {
  key_name   = "app-prod"
  public_key = "${var.SSH_PUBLIC_KEY}"
}

# security group
resource "aws_security_group" "eb_app_prod" {
  vpc_id      = var.vpc_id
  name        = "${var.identifier}-${var.eb_identifier}"
  description = "App prod security group"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.identifier}-${var.eb_identifier}"
    Env       = var.env
    ManagedBy = "terraform"
    Repo      = var.repo_url
  }
}

# app

resource "aws_elastic_beanstalk_application" "app" {
  name        = "${var.identifier}-app"
  description = "EB ASP.NET Core Application"
}

resource "aws_elastic_beanstalk_environment" "app-prod" {
  name                = "${var.identifier}-${var.eb_identifier}"
  application         = aws_elastic_beanstalk_application.app.name
  solution_stack_name = var.solution_stack_name
  cname_prefix        = "${var.identifier}-app-prod"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${var.subnet_private1_id},${var.subnet_private2_id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = var.associate_public_ip_address
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.eb_app_prod.id
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = aws_key_pair.app.id
    resource = ""
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.eb_instance_type
    resource = ""
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.ec2_role
    resource = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = var.eb_service_role
    resource = ""
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = var.elb_scheme
    resource = ""
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${var.public_subnet1_id},${var.public_subnet2_id}"
    resource = ""
  }

  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "CrossZone"
    value     = var.cross_zone
    resource = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSize"
    value     = var.batch_size
    resource = ""
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSizeType"
    value     = var.banch_size_type
    resource = ""
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Availability Zones"
    value     = var.availability_zones
    resource = ""
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.min_size
    resource = ""
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = var.rolling_update_type
    resource = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "ASPNETCORE_ENVIRONMENT"
    value     = "Development"
    resource = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "CONNECTION_STRING"
    value     = "Server=${var.db_instance_address},1433;Database=Chess;User Id=${var.db_instance_username};Password=${var.db_instance_password};"
    resource = ""
  }
}