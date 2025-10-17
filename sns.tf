resource "aws_sns_topic" "guardduty_alerts" {
  name = "guardduty-alerts"
}

resource "aws_sns_topic_subscription" "gduty_sub" {
  topic_arn = aws_sns_topic.guardduty_alerts.arn
  protocol  = "email"
  endpoint  = var.alerts_email
}

# tflint-ignore: terraform_required_providers
resource "null_resource" "notify_subscription" {
  # Force the resource to run after the subscription confirmation goes out.
  depends_on = [aws_sns_topic_subscription.gduty_sub]

  provisioner "local-exec" {
    # Show the user what they need to do now that the subscription exists...
    command = "echo \"NOTICE!!!\"; echo \"You will need to open the email that you should have received at ${var.alerts_email} and click the link.\"; echo \"The deployment will continue regardless.\""
  }
}

resource "aws_sns_topic_policy" "sns_policy" {
  arn    = aws_sns_topic.guardduty_alerts.arn
  policy = data.aws_iam_policy_document.sns_publish.json
}

data "aws_iam_policy_document" "sns_publish" {
  statement {
    actions = ["SNS:Publish"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    resources = [aws_sns_topic.guardduty_alerts.arn]
  }
}
