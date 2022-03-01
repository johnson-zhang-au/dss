resource "aws_iam_instance_profile" "dss_profile" {
  name = "test_profile"
  role = aws_iam_role.dss_role.name
}

resource "aws_iam_role" "dss_role" {
  name = "johnsonz_dss_role"
  path = "/"

  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
managed_policy_arns = [aws_iam_policy.policy_one.arn, ]

}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "policy_one" {
  name = "policy-618033"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ecr:DescribeImages",
        "ecr:DescribeRepositories"]
        Effect   = "Allow"
        Resource = aws_ecr_repository.dss.arn
      },
    ]
  })
}