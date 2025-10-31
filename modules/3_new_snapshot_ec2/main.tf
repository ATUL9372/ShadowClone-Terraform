# Step 1: Create a temporary AMI from the snapshot

resource "aws_ami" "from_snapshot" {
  name                = "ami-from-snapshot-${formatdate("YYYYMMDD-HHmmss", timestamp())}"
  virtualization_type = "hvm"
  root_device_name    = "/dev/sda1"

  ebs_block_device {
    device_name           = "/dev/sda1"
    snapshot_id           = trim(file("${path.module}/../2_ec2_snapshot_backup/../../snapshot_id.log"), "\n")
    volume_size           = "${var.volume_storage_size}"
    delete_on_termination = true
  }

  tags = {
    Name        = "AMI-from-Snapshot-TF"
    Created_By  = "Terraform"
  }
}

# Step 2: Launch a new EC2 instance from the new AMI
resource "aws_instance" "from_snapshot_instance" {
  ami                         = aws_ami.from_snapshot.id
  instance_type               = "${var.server_type}"
  key_name                    = aws_key_pair.own_ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.local_security_group.id]


  tags = {
    Name        = "Restored-From-Snapshot-TF"
    Created_By  = "Terraform"
  }

  depends_on = [aws_ami.from_snapshot]
}

# Combined automation for EC2 instance
resource "null_resource" "save_id_and_ssh" {
  depends_on = [aws_instance.from_snapshot_instance]

  provisioner "local-exec" {
    command = <<EOT
      echo '${aws_instance.from_snapshot_instance.id}' > ${path.root}/snpashot_ec2_instance_ids.log
      sleep 120
      gnome-terminal -- bash -c 'ssh -o StrictHostKeyChecking=no -i ${path.module}/snapshot_atul_terraform_KP.pem ubuntu@${aws_instance.from_snapshot_instance.public_ip}; exec bash'
    EOT
  }
}
