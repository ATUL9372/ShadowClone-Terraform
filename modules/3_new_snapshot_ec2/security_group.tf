resource "aws_security_group" "local_security_group" {
  name        = var.aws_security_group_name
  description = var.aws_security_group_description

  // Setup for Inbound traffic (incoming to your instance) rules 

  dynamic "ingress" {
    for_each = var.allowed_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow TCP port ${port.value}"
    }

  }

  // Setup for Outbound traffic (outgoing from your instance) rules 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name         = "${var.server_owner}"
    CanBeDeleted = "${var.server_can_be_deleted}"
  }

}
