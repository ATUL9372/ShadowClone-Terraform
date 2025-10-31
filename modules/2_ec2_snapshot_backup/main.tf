# Stop running ec2-instance

resource "aws_ec2_instance_state" "stop_running_instances" {
  instance_id = trim(file("${path.module}/../1_ec2-server/../../ec2_instance_ids.log"), "\n")
  state       = "stopped"
}

# Fetch instance details (to get attached volume IDs)

data "aws_instance" "selected_instance" {
  instance_id = trim(file("${path.module}/../../ec2_instance_ids.log"), "\n")
}


# Create a snapshot of the root EBS volume

resource "aws_ebs_snapshot" "ec2_root_snapshot" {
  volume_id   = tolist(data.aws_instance.selected_instance.root_block_device)[0].volume_id
  description = "Snapshot of EC2 instance ${data.aws_instance.selected_instance.id} root volume"

  tags = {
    Name        = "${var.snapshot_name}"
    Instance_ID = data.aws_instance.selected_instance.id
    Created_By  = "Terraform"
    Date        = timestamp()
  }

  depends_on = [aws_ec2_instance_state.stop_running_instances]
}

resource "null_resource" "save_snapshot_id" {
  depends_on = [aws_ebs_snapshot.ec2_root_snapshot]

  provisioner "local-exec" {
    command = "echo '${aws_ebs_snapshot.ec2_root_snapshot.id}' > ${path.module}/../../snapshot_id.log"
  }
}