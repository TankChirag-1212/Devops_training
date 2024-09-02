# Create EC2 instance
resource "aws_instance" "webserver" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_pair_name
  root_block_device {
    volume_size = 20
  }
  tags = {
    Name = "Controller-${var.instance_name}"
    Node = "Master"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("../../../final-task-chirag-ap-south.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt update && sudo apt install ansible -y",
      "ansible --version"
    ]
  }
  provisioner "local-exec" {
    command = "echo 'ansible installation completed on ${aws_instance.webserver.public_ip}'"
  }
 
}
