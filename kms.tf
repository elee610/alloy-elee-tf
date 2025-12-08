resource "aws_kms_key" "main" {
  description             = "KMS key for encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms_policy.json

  tags = merge(
    local.tags,
    {
      Name = "${local.naming}-kms-key"
    }
  )
}

data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid       = "Enable IAM User Permissions"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  statement {
    sid = "Allow service-linked role use"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/*"]
    }
  }
}

resource "aws_kms_alias" "main" {
  name          = "alias/${local.naming}-kms-key"
  target_key_id = aws_kms_key.main.key_id
}

data "aws_caller_identity" "current" {}