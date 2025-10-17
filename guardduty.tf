resource "aws_guardduty_detector" "act_detector" {
  enable                       = true
  finding_publishing_frequency = "ONE_HOUR"
}
