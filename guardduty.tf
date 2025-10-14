resource "aws_guardduty_detector" "ActDetector" {
  enable                       = true
  finding_publishing_frequency = "ONE_HOUR"
}
