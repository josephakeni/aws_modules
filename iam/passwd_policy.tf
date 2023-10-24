resource "aws_iam_account_password_policy" "iam_policy" {
  minimum_password_length             = 8
  require_lowercase_characters       = true
  require_numbers                    = true
  require_symbols                    = true
  require_uppercase_characters       = true
  allow_users_to_change_password      = true
#   hard_expiry                        = false
#   max_password_age                    = 90
#   password_reuse_prevention          = 3
}
