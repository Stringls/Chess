# resource "aws_cloudwatch_log_destination" "test_destination" {
#   name       = "${var.identifier}-${var.log_destination}"
#   role_arn   = var.iam_for_cloudwatch_arn
#   target_arn = var.kinesis_for_cloudwatch_arn
# }

# data "aws_iam_policy_document" "test_destination_policy" {
#   statement {
#     effect = "Allow"

#     principals {
#       type = "AWS"

#       identifiers = [
#         "123456789012",
#       ]
#     }

#     actions = [
#       "logs:PutSubscriptionFilter",
#     ]

#     resources = [
#       aws_cloudwatch_log_destination.test_destination.arn,
#     ]
#   }
# }

# resource "aws_cloudwatch_log_destination_policy" "test_destination_policy" {
#   destination_name = aws_cloudwatch_log_destination.test_destination.name
#   access_policy    = data.aws_iam_policy_document.test_destination_policy.json
# }


resource "aws_cloudwatch_dashboard" "ec2-dashboard" {
  dashboard_name = var.dashboard_name

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "type": "explorer",
            "x": 0,
            "y": 0,
            "width": 24,
            "height": 15,
            "properties": {
                "metrics": [
                    {
                        "metricName": "CPUUtilization",
                        "resourceType": "
                        "InstanceId",
                        "i-0c53c15559870ef67"
                    }
                ],
                "period": 300,
                "title": "Running EC2 Instance CPUUtilization",
                "stat": "Maximum",
                "stacked": true,
                "view": "timeSeries",
                "liveData": false,
                "region": "eu-central-1",
                "yAxis": {
                    "left": {
                        "min": 0,
                        "max": 100
                    },
                    "right": {
                        "min": 50
                    }
                },
                "annotations": {
                    "horizontal": [
                        {
                            "visible": true,
                            "color": "#9467bd",
                            "label": "Critical range",
                            "value": 20,
                            "fill": "above",
                            "yAxis": "right"
                        }
                    ]
                }
            }
        }
    ]
}
EOF
}

                # "aggregateBy": {
                #     "key": "InstanceType",
                #     "func": "MAX"
                # },
                # "labels": [
                #     {
                #         "key": "State",
                #         "value": "running"
                #     }
                # ],
                # "widgetOptions": {
                #     "legend": {
                #         "position": "bottom"
                #     },
                #     "view": "timeSeries",
                #     "rowsPerPage": 8,
                #     "widgetsPerRow": 2
                # },