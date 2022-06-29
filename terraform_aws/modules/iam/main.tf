# iam roles
resource "aws_iam_role" "app-ec2-role" {
  name               = var.iam_ec2_role
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2-profile" {
  name = var.iam_intance_profile
  role = aws_iam_role.app-ec2-role.name
}

# service
resource "aws_iam_role" "elasticbeanstalk-service-role" {
  name               = var.iam_eb_role
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "elasticbeanstalk.amazonaws.com"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "elasticbeanstalk"
                }
            }
        }
    ]
}
EOF
}

# policies
resource "aws_iam_policy_attachment" "app-attach1" {
  name       = "${var.app-attach}-1"
  roles      = [aws_iam_role.app-ec2-role.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_policy_attachment" "app-attach2" {
  name       = "${var.app-attach}-2"
  roles      = [aws_iam_role.app-ec2-role.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMultiContainerDocker"
}

resource "aws_iam_policy_attachment" "app-attach3" {
  name       = "${var.app-attach}-3"
  roles      = [aws_iam_role.app-ec2-role.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_iam_policy_attachment" "app-attach4" {
  name       = "${var.app-attach}-4"
  roles      = [aws_iam_role.elasticbeanstalk-service-role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}

resource "aws_iam_policy_attachment" "app-attach5" {
  name       = "${var.app-attach}-5"
  roles      = [aws_iam_role.elasticbeanstalk-service-role.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy"
}