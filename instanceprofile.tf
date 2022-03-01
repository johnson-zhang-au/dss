
resource "aws_iam_instance_profile" "dss_profile" {
  name = "test_profile"
  role = aws_iam_role.dss_role.name
}

resource "aws_iam_role" "dss_role" {
  name = "johnsonz_dss_role"
  path = "/"

  assume_role_policy  = data.aws_iam_policy_document.instance-assume-role-policy.json
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

resource "aws_iam_policy" "policy_dss_ecr" {
  name = "policy-policy-dss-ecr"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["ecr:DescribeImages",
          "ecr:DescribeRepositories",
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
          "ecr:CreateRepository" ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


resource "aws_iam_policy" "policy_dss_eks" {
  name = "policy-policy-dss-eks"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      "Sid": "EksActions",
      "Effect": "Allow",
      "Action": "eks:*",
      "Resource": "*"
    },
    ]
  })
}


resource "aws_iam_policy" "policy_dss_eksctl_cf" {
  name = "policy-policy-dss-eksctl-cf"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      "Sid": "eksctlCloudFormation",
      "Effect": "Allow",
      "Action": "cloudformation:*",
      "Resource": "*"
    }
    ]
  })
}


resource "aws_iam_policy" "policy_dss_eks_launch_conf" {
  name = "policy-policy-dss-eks-launch-conf"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      "Sid": "EksLaunchConfigs",
      "Effect": "Allow",
      "Action": [
        "autoscaling:CreateLaunchConfiguration",
        "autoscaling:DeleteLaunchConfiguration"
      ],
      "Resource": "arn:aws:autoscaling:*:*:launchConfiguration:*:launchConfigurationName/*"
    }
    ]
  })
}

resource "aws_iam_policy" "policy_dss_eks_autoscale" {
  name = "policy-policy-dss-eks-autoscale"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      "Sid": "EksAutoScaleWrite",
      "Effect": "Allow",
      "Action": [
        "autoscaling:UpdateAutoScalingGroup",
        "autoscaling:DeleteAutoScalingGroup",
        "autoscaling:CreateAutoScalingGroup"
      ],
      "Resource": "arn:aws:autoscaling:*:*:autoScalingGroup:*:autoScalingGroupName/*"
    },
    {
      "Sid": "EksAutoScale",
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeScalingActivities",
        "autoscaling:DescribeLaunchConfigurations"
      ],
      "Resource": "*"
    }
    ]
  })
}

resource "aws_iam_policy" "policy_dss_eks_iam" {
  name = "policy-policy-dss-eks-iam"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      "Sid": "EksIam",
      "Effect": "Allow",
      "Action": [
        "iam:AddRoleToInstanceProfile",
        "iam:AttachRolePolicy",
        "iam:CreateInstanceProfile",
        "iam:CreateRole",
        "iam:DeleteInstanceProfile",
        "iam:DeleteRole",
        "iam:DeleteRolePolicy",
        "iam:DetachRolePolicy",
        "iam:GetInstanceProfile",
        "iam:GetRole",
        "iam:GetRolePolicy",
        "iam:ListAttachedRolePolicies",
        "iam:ListInstanceProfiles",
        "iam:ListInstanceProfilesForRole",
        "iam:PassRole",
        "iam:PutRolePolicy",
        "iam:RemoveRoleFromInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::${locals.current_account_id}:instance-profile/eksctl-*",
        "arn:aws:iam::${locals.current_account_id}:role/eksctl-*"
      ]
    }
    ]
  })
}

resource "aws_iam_policy" "policy_dss_eks_linked_role" {
  name = "policy-policy-dss-eks-linked-role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      "Sid": "EksIamLinkedRole",
      "Effect": "Allow",
      "Action": "iam:CreateServiceLinkedRole",
      "Resource": [
        "arn:aws:iam::${locals.current_account_id}:role/aws-service-role/eks.amazonaws.com/*",
        "arn:aws:iam::${locals.current_account_id}:role/aws-service-role/autoscaling.amazonaws.com/*"
      ]
    }
    ]
  })
}

resource "aws_iam_policy" "policy_dss_eks_iam_openid" {
  name = "policy-policy-dss-eks-iam-openid"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      "Sid": "EksIamOpenID",
      "Effect": "Allow",
      "Action": "iam:GetOpenIDConnectProvider",
      "Resource": "arn:aws:iam::${locals.current_account_id}:oidc-provider/oidc.eks.*"
    }
    ]
  })
}

resource "aws_iam_policy" "policy_dss_eks_igw" {
  name = "policy-policy-dss-eks-igw"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      "Sid": "EksInternetGateway",
      "Effect": "Allow",
      "Action": "ec2:DeleteInternetGateway",
      "Resource": "arn:aws:ec2:*:*:internet-gateway/*"
    }
    ]
  })
}
resource "aws_iam_policy" "policy_dss_eks_launch_template" {
  name = "policy-policy-dss-eks-launch-template"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      "Sid": "EksLaunchTemplates",
      "Effect": "Allow",
      "Action": "ec2:*LaunchTemplate*",
      "Resource": "*"
    }
    ]
  })
}
resource "aws_iam_policy" "policy_dss_eks_networking" {
  name = "policy-policy-dss-eks-networking"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      "Sid": "EksNetworking",
      "Effect": "Allow",
      "Action": [
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:DeleteSubnet",
        "ec2:DeleteTags",
        "ec2:CreateNatGateway",
        "ec2:CreateVpc",
        "ec2:AttachInternetGateway",
        "ec2:DescribeVpcAttribute",
        "ec2:DeleteRouteTable",
        "ec2:AssociateRouteTable",
        "ec2:DescribeVpcs",
        "ec2:DescribeInternetGateways",
        "ec2:CreateRoute",
        "ec2:CreateInternetGateway",
        "ec2:RevokeSecurityGroupEgress",
        "ec2:CreateSecurityGroup",
        "ec2:ModifyVpcAttribute",
        "ec2:DeleteInternetGateway",
        "ec2:DescribeRouteTables",
        "ec2:ReleaseAddress",
        "ec2:AuthorizeSecurityGroupEgress",
        "ec2:DescribeTags",
        "ec2:CreateTags",
        "ec2:DeleteRoute",
        "ec2:CreateRouteTable",
        "ec2:DetachInternetGateway",
        "ec2:DescribeNatGateways",
        "ec2:DisassociateRouteTable",
        "ec2:AllocateAddress",
        "ec2:DescribeSecurityGroups",
        "ec2:RevokeSecurityGroupIngress",
        "ec2:DeleteSecurityGroup",
        "ec2:DeleteNatGateway",
        "ec2:DeleteVpc",
        "ec2:CreateSubnet",
        "ec2:DescribeSubnets",
        "ec2:DescribeImages",
        "ec2:RunInstances"
      ],
      "Resource": "*"
    }
    ]
  })
}
resource "aws_iam_policy" "policy_dss_eks_ssm" {
  name = "policy-policy-dss-eks-ssm"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      "Sid": "SsmOfficialImagesFetch",
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameter",
        "ssm:GetParameters"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:parameter/aws/service/eks/optimized-ami/*/amazon-linux-2/recommended/image_id",
        "arn:aws:ssm:*:*:parameter/aws/service/eks/optimized-ami/*/amazon-linux-2/recommended/image_id",
        "*"
      ]
    }
    ]
  })
}