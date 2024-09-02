# Create EC2 instance
resource "aws_instance" "webserver" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_pair_name
  root_block_device {
    volume_size = 15
  }
  tags = {
    Name = "Worker-${var.instance_name}"
    Node = "Worker"
  }
}