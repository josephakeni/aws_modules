resource "aws_iam_group" "developers" {
  name = "developers"
  #path = "/users/"
}

resource "aws_iam_group" "operations1" {
  name = "operations1"
  #path = "/users/"
}


# resource "aws_iam_policy" "policy" {
#   name        = "IAMUserChangePassword"
#   description = "A test policy"

#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "iam:ChangePassword"
#             ],
#             "Resource": [
#                 "arn:aws:iam::*:user/*"
#             ]
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "iam:GetAccountPasswordPolicy"
#             ],
#             "Resource": "*"
#         }
#     ]
# }
# EOF
# }









# output "role" {
#   value = vault_aws_secret_backend_role.role.name
# }