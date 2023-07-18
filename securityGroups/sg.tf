# ALB Security Group: Edit to restrict access to the application
resource "aws_security_group" "sg" {
  name        = var.name
  description = var.description #"controls access to the ALB"
  vpc_id      = var.aws_vpc_main

  tags = {
    Name = var.name
  }
}

resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.ingress_rules)

  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "egress_rules" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}