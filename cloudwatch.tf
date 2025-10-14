resource "aws_cloudwatch_event_rule" "guardduty_finding" {
  name        = "guardduty-finding_rule"
  description = "Search for a GuardDuty finding"
  event_pattern = jsonencode({
    source      = ["aws.guardduty"]
    detail-type = ["GuardDuty Finding"]
  })
}

resource "aws_cloudwatch_event_target" "send_to_sns" {
  rule      = aws_cloudwatch_event_rule.guardduty_finding.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.guardduty_alerts.arn
}
