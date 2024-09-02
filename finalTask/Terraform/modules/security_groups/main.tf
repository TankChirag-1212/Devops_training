# Create the security group
resource "aws_security_group" "controller_sg" {
  name_prefix = "Controller-sg-"
  vpc_id      = var.my_vpc_id
  tags = {
    Name = "Controller-sg-chirag"
  }
}

resource "aws_vpc_security_group_ingress_rule" "controller_sg_ingress" {
  security_group_id = aws_security_group.controller_sg.id
  count             = length(var.controller_ingress_rules)
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.controller_ingress_rules[count.index].from_port
  to_port           = var.controller_ingress_rules[count.index].to_port
  ip_protocol       = "tcp"

}

resource "aws_vpc_security_group_egress_rule" "controller_sg_egress" {
  security_group_id = aws_security_group.controller_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Create the worker security group
resource "aws_security_group" "worker_sg" {
  name_prefix = "Worker-sg-"
  vpc_id      = var.my_vpc_id
  tags = {
    Name = "Worker-sg-chirag"
  }
}

resource "aws_vpc_security_group_ingress_rule" "worker_sg_ingress" {
  security_group_id = aws_security_group.worker_sg.id
  count             = length(var.worker_ingress_rules)
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.worker_ingress_rules[count.index].from_port
  to_port           = var.worker_ingress_rules[count.index].to_port
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "worker_sg_egress" {
  security_group_id = aws_security_group.worker_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
