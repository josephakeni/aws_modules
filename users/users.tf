resource "aws_iam_user" "user" {
  for_each = toset(var.username)
  name     = each.value
}
resource "aws_iam_user_group_membership" "user_group" {
  for_each = toset(var.username)
  user     = aws_iam_user.user[each.value].name

  groups = var.group_name

}