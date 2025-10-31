resource "aws_instance" "my_server" {
  ami                    = var.server_ami
  instance_type          = var.server_type
  user_data              = file("${var.user_data_script_file}")
  key_name               = aws_key_pair.own_ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.local_security_group.id]

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_storage_size
    delete_on_termination = var.delete_on_termination
  }

  tags = {
    Name         = "${var.server_name}"
    Owner        = "${var.server_owner}"
    CanBeDeleted = "${var.server_can_be_deleted}"
  }

}

// Default VPC 

resource "aws_default_vpc" "default_cloud_vpc" {
  tags = {
    Name = "Default VPC"
  }
}


# Combined automation for EC2 instance
resource "null_resource" "save_id_and_ssh" {
  depends_on = [aws_instance.my_server]

  provisioner "local-exec" {
    command = <<EOT
      echo '${aws_instance.my_server.id}' > ${path.root}/ec2_instance_ids.log
      sleep 120
      gnome-terminal -- bash -c 'ssh -o StrictHostKeyChecking=no -i ${path.module}/atul_terraform_JK_KP.pem ubuntu@${aws_instance.my_server.public_ip}; exec bash'
    EOT
  }
}




# # Save EC2 instance ID to a file (append mode)
# resource "null_resource" "save_instance_id" {
#   depends_on = [aws_instance.server]  # use local resource reference, not module

#   provisioner "local-exec" {
#     command = "echo '${aws_instance.server.id}' > ${path.root}/ec2_instance_ids.log"
#   }
# }

# # Open SSH connection after instance creation
# resource "null_resource" "open_ssh_new_terminal" {
#   depends_on = [aws_instance.server]

#   provisioner "local-exec" {
#     command = "sleep 120 && gnome-terminal -- bash -c 'ssh -i ${path.module}/atul_terraform_JK_KP.pem ubuntu@${aws_instance.server.public_ip}; exec bash'"

/////////    ssh connection Yes/No
#     command = "sleep 120 && gnome-terminal -- bash -c "ssh -o StrictHostKeyChecking=no -i ${path.module}/atul_terraform_JK_KP.pem ubuntu@${aws_instance.my_server.public_ip}; exec bash"
#     # same terminal for ssh connecton
#     # command = "sleep 120 && ssh -i ./modules/1_ec2-server/atul_terraform_JK_KP ubuntu@${module.ec2-server_instances.server_public_ip}"
#   }
# }
