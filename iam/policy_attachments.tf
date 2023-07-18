##################### Development ##############################
resource "aws_iam_policy_attachment" "IAMUserChangePassword" {
  name = "IAMUserChangePassword"
  # users      = [aws_iam_user.user.name]
  # roles      = [aws_iam_role.role.name]
  groups     = [aws_iam_group.developers.name, aws_iam_group.operations1.name]
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

######################## Operations #############################
resource "aws_iam_policy_attachment" "AWSCodeCommitPowerUser" {
  name       = "AWSCodeCommitPowerUser"
  groups     = [aws_iam_group.operations1.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitPowerUser"
}

resource "aws_iam_policy_attachment" "AmazonS3FullAccess" {
  name       = "AmazonS3FullAccess"
  groups     = [aws_iam_group.operations1.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_policy_attachment" "SystemAdministrator" {
  name       = "SystemAdministrator"
  groups     = [aws_iam_group.operations1.name]
  policy_arn = "arn:aws:iam::aws:policy/job-function/SystemAdministrator"
}

resource "aws_iam_policy_attachment" "AdministratorAccess" {
  name       = "AdministratorAccess"
  groups     = [aws_iam_group.operations1.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_policy_attachment" "AmazonRoute53FullAccess" {
  name       = "AmazonRoute53FullAccess"
  groups     = [aws_iam_group.operations1.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}
